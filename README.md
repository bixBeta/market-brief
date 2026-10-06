# Market Brief

A daily US stock market pre-open brief, generated every weekday before the 9:30 a.m. ET open and rendered as a single static page.

## Layout

```
index.html            # the dashboard (static, no build step)
data/index.json       # list of available dates + latest
data/latest.json      # copy of the most recent brief
data/YYYY-MM-DD.json  # one file per trading day
```

`index.html` reads `data/index.json`, loads the latest brief (or `?d=YYYY-MM-DD`), and offers a date picker for past days.

## Viewing

The page fetches JSON, so it must be served over HTTP rather than opened from disk:

```bash
python3 -m http.server 8000
# then open http://localhost:8000
```

Or enable GitHub Pages (Settings → Pages → deploy from `main`, root).

## Data rules

- Figures come from public sources (Yahoo Finance, StockAnalysis.com, CNBC, Nasdaq, MarketWatch, Benzinga and others) and are cross-checked.
- Anything that can't be found or verified is recorded as `null` / `"n/a"`, never estimated.
- Quality movers: price ≥ $5 and market cap ≥ $2B. Penny movers: price < $5, ≥ 500K shares (100K pre-market).
- Relative volume uses the source's average-volume field; the brief notes which average was used.

This is a factual market summary, not investment advice.
