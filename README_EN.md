# daily_stock_analysis — LLM-powered multi-market stock analysis

> This is a **fork** of the upstream project [ZhuLinsen/daily_stock_analysis](https://github.com/ZhuLinsen/daily_stock_analysis). Upstream license/notices are retained; see `README.md` (Chinese) and `docs/README_EN.md` for the full canonical docs. This file is a concise English overview with an architecture diagram.

An AI/LLM-powered self-selected-stock analysis system for **A-share / HK / US / JP / KR** markets: it analyzes daily and pushes a **decision dashboard** to WeCom / Feishu / Telegram / Discord / Slack / email, with cost-free scheduled runs (e.g. GitHub Actions).

## Key Features
- Multi-source market data via `data_provider/`
- Strategy/analysis layer (`strategies/`, `src/`)
- Decision dashboard (`templates/`, `apps/`) and bots for multi-channel push (`bot/`)
- Zero-cost scheduling (GitHub Actions / Docker)

## Architecture & Workflow
```mermaid
flowchart TD
    SCHED[Scheduler / GitHub Actions] --> MAIN[main.py]
    MAIN --> DP[data_provider/ multi-source market data]
    DP --> STRAT[strategies/ analysis]
    STRAT --> LLM[LLM analysis]
    LLM --> DASH[Decision dashboard (templates/apps)]
    DASH --> BOT[bot/ push: WeCom/Feishu/Telegram/Discord/Slack/Email]
    API[api/] --> DASH
```

## Project Structure
```
daily_stock_analysis/
├─ data_provider/   # market data providers
├─ strategies/      # analysis strategies
├─ apps/ templates/ # dashboard
├─ bot/             # notification bots
├─ api/ src/ docs/ scripts/ tests/
├─ main.py / pyproject.toml / requirements.txt
└─ .env.example
```

## Getting Started
See upstream `README.md` / `docs/`. Typical: configure `.env`, then `python main.py` or run the GitHub Actions workflow / Docker.

## License & Credit
Upstream: ZhuLinsen/daily_stock_analysis (MIT, see `LICENSE`). This fork keeps upstream credit and license.