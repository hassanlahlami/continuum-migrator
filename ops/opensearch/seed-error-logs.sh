#!/usr/bin/env bash
# Seeds demo technical error events (ECS, plan §10.3) into OpenSearch for the admin error-log / trace views.
# Event codes and levels come from the catalogue in plan §10.4. Timestamps are relative to "now" so the
# default time windows always show data. Idempotent: documents have fixed ids, re-running overwrites them.
# Usage: OPENSEARCH_URL=http://localhost:9200 ./seed-error-logs.sh
set -euo pipefail
URL="${OPENSEARCH_URL:-http://localhost:9200}"
INDEX="${LOG_INDEX:-continuum-logs-demo}"
SERVICE="${LOG_SERVICE:-continuum-backend}"

ts() { date -u -d "$1 ago" +%Y-%m-%dT%H:%M:%S.000Z; }   # ts "3 days"

here="$(cd "$(dirname "$0")" && pwd)"
# keyword mappings are required by the backend aggregations (event.code, log.level, trace.id...)
curl -fsS -X PUT "$URL/_index_template/continuum-logs" -H 'Content-Type: application/json' --data-binary @"$here/index-template.json" >/dev/null
# recreate our own demo index so it picks up the template mappings
curl -fsS -X DELETE "$URL/$INDEX" >/dev/null 2>&1 || true

BULK="$(mktemp)"; trap 'rm -f "$BULK"' EXIT
n=0
# add <ago> <level> <code> <node> <message> [trace span parent op]
add() {
  n=$((n+1))
  printf '{"index":{"_index":"%s","_id":"seed-%03d"}}\n' "$INDEX" "$n" >> "$BULK"
  local extra=""
  if [ $# -ge 9 ]; then
    extra=",\"trace.id\":\"$6\",\"span.id\":\"$7\",\"event.action\":\"$9\""
    [ -n "$8" ] && extra="$extra,\"span.parent.id\":\"$8\""
  fi
  printf '{"@timestamp":"%s","log.level":"%s","event.code":"%s","service.name":"%s","service.node.name":"%s","message":"%s"%s}\n' \
    "$(ts "$1")" "$2" "$3" "$SERVICE" "$4" "$5" "$extra" >> "$BULK"
}

# CTN-INT-0102 ERROR: ERP call failed after retries (recurring, trending, two nodes)
for d in "6 days" "5 days" "5 days" "3 days" "2 days" "2 days" "2 days" "1 day" "20 hours" "6 hours" "2 hours"; do
  add "$d" ERROR CTN-INT-0102 backend-worker-1 "Core banking call failed after 3 retries"
done
for d in "4 days" "1 day" "3 hours"; do
  add "$d" ERROR CTN-INT-0102 backend-worker-2 "Core banking call failed after 3 retries"
done
# CTN-SIG-0500 ERROR: signature provider unavailable
for d in "3 days" "36 hours" "30 hours" "5 hours"; do
  add "$d" ERROR CTN-SIG-0500 backend-api-1 "Signature provider unavailable, requests kept PENDING"
done
# WARN codes
for d in "6 days" "4 days" "2 days" "1 day" "4 hours" "1 hour"; do
  add "$d" WARN CTN-SEC-0001 backend-api-1 "Repeated failed logins on an account"
done
for d in "2 days" "10 hours"; do
  add "$d" WARN CTN-IAM-0200 backend-api-2 "Workflow task has no candidate: no position holds the feature"
done
add "7 hours" WARN CTN-CCM-0042 backend-worker-1 "CCM control run outside its scheduled window"
add "3 days" WARN CTN-CACHE-0300 backend-api-2 "Instance did not acknowledge a cache purge"
add "26 hours" WARN CTN-CACHE-0300 backend-api-1 "Instance did not acknowledge a cache purge"

# Two traces (trace.id / span.id / span.parent.id) for the trace view
T1=4bf92f3577b34da6a3ce929d0e0e4736
add "6 hours" WARN  CTN-INT-0100 backend-worker-1 "Core banking call slow, retrying (attempt 2)" "$T1" 00f067aa0ba902b8 00f067aa0ba902b7 retryGetAccountList
add "6 hours" ERROR CTN-INT-0102 backend-worker-1 "Core banking call failed after 3 retries" "$T1" 00f067aa0ba902b9 00f067aa0ba902b7 GetAccountList
add "6 hours" ERROR CTN-INT-0103 backend-worker-1 "CCM control aborted: source unavailable" "$T1" 00f067aa0ba902b7 "" runCcmControl
T2=7c2a91d03e5b4f6a8d1e0f2b3c4d5e6f
add "5 hours" ERROR CTN-SIG-0500 backend-api-1 "Signature provider unavailable, requests kept PENDING" "$T2" 1a2b3c4d5e6f7081 "" requestSignature

curl -fsS -H 'Content-Type: application/x-ndjson' -X POST "$URL/_bulk?refresh=true" --data-binary @"$BULK" \
  | grep -q '"errors":false' && echo "seeded $n events into $INDEX"
