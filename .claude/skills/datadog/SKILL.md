---
name: datadog
description: Query Datadog logs, metrics, monitors, APM, errors, incidents, and more using the pup CLI. Use when the user shares a Datadog URL, asks about errors/logs/metrics, or wants to diagnose production issues.
---

# Datadog Observability Skill

You are a production support expert. Use the `pup` CLI to query Datadog for logs, metrics, monitors, APM data, errors, and incidents. Synthesize findings into clear diagnoses.

## Prerequisites

- `pup` CLI must be installed (binary from https://github.com/datadog-labs/pup/releases)
- Authenticated via `pup auth login` (OAuth2)
- `DD_SITE=datadoghq.eu` must be set (our org uses the EU site)

If `pup` is not found, tell the user to install it:
```bash
brew tap datadog-labs/pack
brew install datadog-labs/pack/pup
```

If auth fails, tell the user to run `pup auth login`.

## Environment

Always set `DD_SITE=datadoghq.eu` when running pup commands. Prefix commands with `DD_SITE=datadoghq.eu` or ensure it's exported.

## Parsing Datadog URLs

When the user pastes a Datadog URL, extract context to build queries:

- **Log URL**: `app.datadoghq.eu/logs?query=...` → extract the query, time range
- **APM trace**: `app.datadoghq.eu/apm/traces?query=...` → extract service, operation, trace ID
- **Monitor**: `app.datadoghq.eu/monitors/12345` → extract monitor ID, use `pup monitors get <id>`
- **Dashboard**: `app.datadoghq.eu/dashboard/abc-def` → extract dashboard ID
- **Error tracking**: `app.datadoghq.eu/error-tracking/issue/...` → extract issue ID
- **SLO**: `app.datadoghq.eu/slo?slo_id=...` → extract SLO ID
- **Incident**: `app.datadoghq.eu/incidents/...` → extract incident ID

## Core Commands

### Logs
```bash
# Search logs (most common)
pup logs search --query="status:error service:rx-api" --from="1h"
pup logs search --query="@http.status_code:500" --from="15m"
pup logs search --query="service:rx-frontend @error.message:*timeout*" --from="4h"

# Search with flex storage (for older logs)
pup logs search --query="status:error" --from="7d" --storage="flex"

# Aggregate logs (counts, patterns)
pup logs aggregate --query="status:error" --from="1h"
```

### Metrics
```bash
pup metrics query --query="avg:system.cpu.user{service:rx-api}" --from="1h"
pup metrics search --query="rx"
```

### Monitors
```bash
pup monitors list --tags="team:external-analytics"
pup monitors get <monitor_id>
pup monitors search --query="status:alert"
```

### APM / Services
```bash
pup apm services list
pup apm services stats --name="rx-api" --from="1h"
pup apm dependencies list --service="rx-api"
```

### Error Tracking
```bash
pup error-tracking issues search --query="service:rx-api"
pup error-tracking issues get <issue_id>
```

### SLOs
```bash
pup slos list
pup slos get <slo_id>
pup slos status <slo_id>
```

### Incidents
```bash
pup incidents list
pup incidents get <incident_id>
```

### Events
```bash
pup events search --query="source:alert" --from="1h"
```

## Diagnosis Workflow

When asked to diagnose an issue (error link, SLO violation, alert):

1. **Gather context** — Fetch the specific error/alert/SLO first
2. **Search related logs** — Query logs around the same time window, filtering by service/environment
3. **Check monitors** — Look for related alerting monitors
4. **Check metrics** — Query relevant metrics (latency, error rate, throughput) for the affected service
5. **Synthesize** — Provide a clear diagnosis with:
   - **What happened**: Summarize the error/issue
   - **When**: Time range and duration
   - **Impact**: Which services/users affected
   - **Likely cause**: Based on log patterns, metrics correlation
   - **Suggested next steps**: What to investigate or fix

## Output Handling

- pup outputs JSON by default — use `--output table` for human-readable summaries
- For large result sets, pipe through `jq` to extract relevant fields
- When showing results to the user, summarize key findings rather than dumping raw JSON

## Our Services

Key services to know about when querying:
- `rx-api` — RX Backend API
- `rx-frontend` — RX Frontend
- `rx-analytics` — RX Analytics service

## Tips

- Use `--from` with relative times: `15m`, `1h`, `4h`, `1d`, `7d`
- Combine filters: `service:rx-api env:production status:error`
- Use wildcards in queries: `@error.message:*timeout*`
- For high-cardinality searches, narrow the time range first
- Use `pup logs aggregate` to get counts/patterns before diving into individual logs
