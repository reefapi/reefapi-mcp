# ReefAPI MCP

**One MCP server for 160+ live web-data APIs** — search engines, social media, e-commerce, real estate, jobs, travel, news, finance, and company/domain/people intelligence. The assistant discovers the right engine, then pulls clean JSON from sites that block scrapers (captcha, login, JS, anti-bot).

- 🌐 **Homepage:** https://reefapi.com
- 📚 **Docs:** https://reefapi.com/docs
- 🔌 **MCP guide:** https://reefapi.com/mcp
- 🟢 **Status:** https://reefapi.com/status

## Why one server, not 160 tools

Emitting one tool per API blows past the ~30–50-tool ceiling where agents stop picking the right tool. ReefAPI uses dynamic discovery — **4 generic tools** let the assistant find the right engine, then call it:

| Tool | Keyless | What it does |
|---|---|---|
| `search_engines(query)` | ✅ | Find the right engine by intent ("company reviews", "is this domain free") |
| `get_catalog()` | ✅ | The full menu of every engine, grouped by category |
| `get_engine_schema(engine)` | ✅ | An engine's actions, params, and return shapes |
| `get_action_schema(engine, action)` | ✅ | Full params for one action |
| `call_engine(engine, action, params)` | 🔑 | Run it → clean `{ ok, data, meta, error }` JSON |

Discovery is keyless; only `call_engine` needs a key. **Failed or blocked calls cost nothing.**

## Connect (remote — recommended)

Add to Claude Desktop, Cursor, Windsurf, or any client that takes a remote MCP URL:

```json
{
  "mcpServers": {
    "reefapi": {
      "url": "https://api.reefapi.com/mcp",
      "headers": { "Authorization": "Bearer YOUR_REEFAPI_KEY" }
    }
  }
}
```

Claude Code (CLI):

```bash
claude mcp add --transport http reefapi https://api.reefapi.com/mcp \
  --header "Authorization: Bearer YOUR_REEFAPI_KEY"
```

Get a **free key (1,000 credits, no card)** at https://reefapi.com.

## Run it locally (stdio)

```bash
pip install -r requirements.txt
export REEFAPI_KEY=ak_live_your_key   # Windows: set REEFAPI_KEY=...
python server.py                      # stdio transport
```

Then point your client at `python /path/to/server.py`. The same file also serves the streamable-HTTP
transport with `MCP_TRANSPORT=streamable-http` (used by the hosted endpoint above).

## What you can ask

- "What are people saying about the new iPhone on Reddit?"
- "Get current Zillow listings in Austin under $500k."
- "Is the domain `coolstartup.ai` available?"
- "Compare Amazon prices for AirPods Pro."
- "Top Hacker News stories right now."
- "What tech stack does stripe.com run on?"

## Coverage

Search/SEO · Social Media (Reddit, TikTok, Threads, Bluesky) · E-commerce (Amazon, eBay, AliExpress, Etsy, BestBuy) · Real Estate (Zillow, Redfin) · Jobs · Travel · News · Finance · Media/Film · Reputation/Reviews (Glassdoor, Trustpilot) · Company/Domain/People intelligence · Developer utilities — **160+ engines and growing.**

## License

MIT — see [LICENSE](LICENSE). The APIs are a hosted service with a free tier; see https://reefapi.com.
