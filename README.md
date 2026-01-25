# Briefly

Briefly is a modern, offline-first iOS app that aggregates content from multiple public sources and turns it into concise, readable insights using structured processing and AI-assisted summarization.

Built as a production-grade reference app, Briefly focuses on clean architecture, scalable state management, and real-world iOS patterns.

 # ✨ What It Does

📰 Aggregates news from Hacker News, Reddit, RSS, and APIs

🧾 Generates smart article previews using comments + content

📦 Works offline-first with graceful fallbacks

🌍 Fully localized (no hardcoded strings)

🧑‍💻 Personalized feed via profile & topic preferencesWhat It Does

# 🏗 Architecture

SwiftUI Views
→ ViewModels (State + Intents)
→ Use Cases (Business Logic)
→ Repositories / Sources
→ Network & Persistence

Key principles

No business logic in Views

No SwiftUI in domain layers

Feature-scoped responsibilities

Centralized Dependency Injection

# 🧩 Tech Stack

UI & State

SwiftUI, @Observable, @Environment
NavigationStack, TabView

Networking & Data

URLSession + async/await
RSS parsing
Pagination-ready APIs

Persistence

Offline-first design
Core Data (planned)

AI & Intelligence
AI-assisted article preview generation
Comment-aware summarization (pluggable)

System APIs
Localization (String Catalogs)
Error handling & logging
Deep links (planned)

# 🧭 App Structure

Home — Curated feed & topics

Discover — Search & exploration

Saved — Offline content

Profile — Preferences & personalization

Navigation and tab selection are managed via a centralized AppNavigationState, mirroring large-scale app patterns.

# 🗺 Roadmap

 Localization (String Catalog + enums)
 
 Profile & preferences
 
 Article details & previews
 
 Clean DI container
 
 Swift Package modularization
 
 Core Data persistence
 
 AI pipelines (on-device / backend)
 
 Stocks / Markets (Swift Charts)
 
 Weather integration
 
 Authentication
 
 Server-driven UI experiments
 
 GitHub Actions (CI/CD)

# 🚧 Status

Feed MVP in active development

This project evolves continuously as architectural and feature experiments are added.

