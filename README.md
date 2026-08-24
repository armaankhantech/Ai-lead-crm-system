# AI Lead CRM System

A complete AI-powered lead qualification and CRM system built with n8n, Ollama (local LLM), PostgreSQL, Google Sheets, and Gmail.

Built as part of my public AI Automation Engineering journey — Day 10 project.

---

## What This System Does

A business receives leads through a Google Form. This system automatically:

1. **Scores the lead** using rule-based logic (revenue, timeline, company size)
2. **Analyzes the lead** using a local AI model (Ollama/Qwen3) to generate business insights
3. **Stores everything** in a PostgreSQL database
4. **Displays a live CRM dashboard** via a webhook-triggered HTML interface
5. **Sends automated emails** to qualified and unqualified leads instantly

No manual work. Zero human intervention needed.

---

## System Architecture

```
Google Form Submission
        ↓
Google Sheets Trigger (n8n)
        ↓
Rule-Based Lead Scorer (JavaScript)
    → Scores: Revenue + Timeline + Company Size
    → Status: Hot / Warm / Cold
        ↓
AI Agent (Ollama - Qwen3:8b)
    → Generates: Reason, Priority, Recommended Action
        ↓
PostgreSQL Database (ai_leads table)
        ↓
CRM Dashboard (Webhook → HTML response)
```

---

## Updates

### Day 12 — Error Handling & Resilience

Added production-grade error handling to the AI Lead Analyzer Code node:

- **try/catch wrapping** around all JSON.parse calls — the system no longer crashes on malformed AI output
- **Regex markdown fence stripping** — removes ```json fences that Ollama sometimes wraps around responses
- **Fallback values** — if AI parsing fails entirely, sensible defaults are applied so the lead still gets stored
- **NEEDS_REVIEW priority tag** — failed AI parse leads are flagged with `NEEDS_REVIEW` instead of silently entering a normal lead bucket
- **Verified by deliberate breakage** — bad JSON was intentionally injected to confirm the fallback path works end-to-end

This is the difference between a system that works in demos and one that holds up in production.

---

## Workflows

| File                       | Purpose                                                       |
|----------------------------|---------------------------------------------------------------|
| `lead_qualify_system.json` | Early version — IF logic, lead segmentation, Gmail automation |
| `AI_LEAD_ANALYZER.json`    | Main workflow — scoring + AI analysis + PostgreSQL storage    |
| `CRM_Dashboard.json`       | Webhook-based live dashboard showing all leads                |

---

## Database Schema

See `schema.sql` for the full PostgreSQL table structure.

Key table: `ai_leads`

- name, email, company, industry, company_size
- monthly_revenue, automation_request, timeline
- lead_score (0–100), lead_status (hot/warm/cold)
- priority (High/Medium/Low/NEEDS_REVIEW), reason, recommended_action

---

## Tech Stack

- **n8n** — workflow automation engine
- **Ollama (Qwen3:8b)** — local LLM for AI reasoning
- **PostgreSQL 16** — structured data storage
- **Google Sheets + Forms** — data entry and integration
- **Gmail API** — automated email responses
- **JavaScript** — custom scoring logic and error handling inside n8n Code nodes
- **Docker** — local infrastructure

---

## Key Technical Decisions

**Why hybrid rule-based + AI instead of pure AI scoring?**

Pure AI scoring is unreliable for business logic — it can hallucinate scores or be inconsistent. Rule-based scoring first gives deterministic, auditable results. AI then adds qualitative reasoning on top. This is how production systems actually work.

**Why local Ollama instead of OpenAI API?**

Zero API cost during development. Qwen3:8b runs locally via Docker and is capable enough for lead analysis tasks.

---

## How to Run This Yourself

### Prerequisites

- Docker installed
- n8n running locally or on cloud
- Google Sheets OAuth credentials
- Gmail OAuth credentials

### Setup

1. Import the workflow JSON files into your n8n instance
2. Run `schema.sql` against your PostgreSQL database
3. Update Google Sheets document IDs in the trigger nodes
4. Update your Ollama endpoint in the Ollama Chat Model node
5. Activate all workflows

---

## What I Learned Building This

- Webhook triggers vs polling triggers — when to use each
- Why AI output needs to be parsed carefully (JSON.parse on LLM output)
- Why error handling isn't optional — silent failures hide in production
- PostgreSQL schema design for CRM data
- How to build a live HTML dashboard served directly from n8n
- Hybrid rule-based + AI architecture for reliable business automation

---

## Author

**Armaan Khan** — Aspiring AI Automation Engineer

Building in public: [LinkedIn](https://www.linkedin.com/in/armaankhan-tech/) · [GitHub](https://github.com/armaankhantech) · [Twitter/X](https://x.com/armaankhantech)

Part of my [AI Automation Journey](https://github.com/armaankhantech/Ai-automation-journey)
