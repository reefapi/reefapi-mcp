# ReefAPI MCP

<a href="https://glama.ai/mcp/servers/reefapi/reefapi-mcp">
  <img width="380" height="200" src="https://glama.ai/mcp/servers/reefapi/reefapi-mcp/badges/card.svg" alt="ReefAPI MCP server" />
</a>

**One MCP server for 150+ live web-data APIs** — search engines, social media, e-commerce, real estate, jobs, travel, news, finance, and company/domain/people intelligence. The assistant discovers the right engine, then pulls clean JSON from sites that block scrapers (captcha, login, JS, anti-bot).

- 🌐 **Homepage:** https://reefapi.com
- 📚 **Docs:** https://reefapi.com/docs
- 🔌 **MCP guide:** https://reefapi.com/mcp
- 🟢 **Status:** https://reefapi.com/status

## Why one server, not one tool per API

Emitting one tool per API blows past the ~30–50-tool ceiling where agents stop picking the right tool. ReefAPI uses dynamic discovery instead: **five generic tools** let the assistant find the right engine, then call it. Discovery is keyless; only `call_engine` needs a key. **Failed or blocked calls cost nothing.**

## Tools

| Tool | Keyless | What it does |
|---|---|---|
| `search_engines(query)` | ✅ | Ranks the catalog against English keywords or a short use-case ("company reviews", "is this domain free") and returns the best-matching engines with their actions. |
| `get_catalog()` | ✅ | Returns the full menu — every engine with a one-line title, grouped by category — so the model can pick semantically when a keyword search misses. |
| `get_engine_schema(engine)` | ✅ | Compact overview of one engine: each action with its description, required params, and return shape, kept lean so a large engine stays token-cheap. |
| `get_action_schema(engine, action)` | ✅ | Full detail for a single action: every parameter with type, allowed values, default, example, plus pricing and ready-to-run example params. |
| `call_engine(engine, action, params)` | 🔑 | Runs the action and returns the uniform `{ ok, data, meta, error }` envelope. |

The intended path is `search_engines` (or `get_catalog`) → `get_engine_schema` → `get_action_schema` → `call_engine`.

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

Each example below is answered by one engine; the link goes to that engine's parameters and response shape.

- *"What are people saying about the new iPhone on Reddit?"* → [`reddit`](https://reefapi.com/docs/reddit)
- *"Get current Zillow listings in Austin under $500k."* → [`zillow`](https://reefapi.com/docs/zillow)
- *"Is the domain `coolstartup.ai` available?"* → [`domain-availability`](https://reefapi.com/docs/domain-availability)
- *"Compare Amazon prices for AirPods Pro."* → [`amazon`](https://reefapi.com/docs/amazon)
- *"Top Hacker News stories right now."* → [`hackernews`](https://reefapi.com/docs/hackernews)
- *"What tech stack does stripe.com run on?"* → [`domain-intel`](https://reefapi.com/docs/domain-intel)
- *"Find remote backend jobs posted this week."* → [`global-jobs`](https://reefapi.com/docs/global-jobs)

You never have to name the engine yourself — that is what `search_engines` is for. The links are there for
when you want to see the exact params and fields before wiring a call.

## Coverage

150+ engines across Search/SEO, Social Media, E-commerce, Real Estate, Jobs, Travel, News, Finance,
Media/Film, Reputation/Reviews, Company/Domain/People intelligence, and developer utilities.
Browse the full catalog at [reefapi.com/docs](https://reefapi.com/docs), or call `get_catalog()` for the
live list. A few of the most-used ones:

| Engine | Returns |
|---|---|
| [`amazon`](https://reefapi.com/docs/amazon) | Product search, listing detail, prices, variants and reviews |
| [`ebay`](https://reefapi.com/docs/ebay) | Listings, item detail and sold/completed pricing |
| [`aliexpress`](https://reefapi.com/docs/aliexpress) | Product search and detail, including per-SKU pricing and images |
| [`zillow`](https://reefapi.com/docs/zillow) | For-sale and rental listings, property detail and value estimates |
| [`redfin`](https://reefapi.com/docs/redfin) | Listings and market data as a second US real-estate source |
| [`reddit`](https://reefapi.com/docs/reddit) | Subreddit and keyword search, post detail and comment threads |
| [`bluesky`](https://reefapi.com/docs/bluesky) | Posts, profiles and search across the AT Protocol network |
| [`glassdoor`](https://reefapi.com/docs/glassdoor) | Company reviews, ratings and salary data |
| [`trustpilot`](https://reefapi.com/docs/trustpilot) | Business profiles and customer reviews with ratings |
| [`indeed`](https://reefapi.com/docs/indeed) | Job search and posting detail across country sites |
| [`domain-intel`](https://reefapi.com/docs/domain-intel) | DNS, WHOIS and detected tech stack for a domain |
| [`news-intel`](https://reefapi.com/docs/news-intel) | Article search and extraction across news sources |

Every engine returns the same `{ ok, data, meta, error }` envelope and draws on one shared credit pool.

## License

MIT — see [LICENSE](LICENSE). The APIs are a hosted service with a free tier; see https://reefapi.com.
