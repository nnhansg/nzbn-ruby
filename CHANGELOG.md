# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.3] - 2026-02-09

### Fixed
- Fixed `:json is not registered on Faraday::Request` error by removing middleware dependency
- Manually handle JSON encoding/decoding for better compatibility with Faraday 1.x

## [0.1.2] - 2026-02-09

### Fixed
- Update dependency gems.

## [0.1.1] - 2026-02-09

### Fixed
- Update dependency gems.

## [0.1.0] - 2024-02-04

### Added
- Initial release
- Entity search and retrieval
- Entity creation (sole trader, partnership, trust)
- Address management
- Role management (directors, partners, trustees)
- Trading names management
- Phone numbers management
- Email addresses management
- Websites management
- Industry classifications management
- Privacy settings management
- Company and non-company details
- Watchlist management for change notifications
- Organisation parts (OPN/GLN) management
- Historical data access
- Full error handling with custom exceptions
