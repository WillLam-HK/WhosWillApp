# Deploy WhosWill (iOS)

## Pre-deploy checklist

- [x] **Unit tests** — All tests in `WhosWillTests` pass (`AppLocale`, `Project`, `SkillsData`, `AppState.mergeProjects`, `Translations` fallback and decode).
- [x] **Translations** — Fallback used when bundle JSON is missing; no force-unwrap in production.
- [x] **Accessibility** — Tab bar, project cards, “View all”, language picker, contact links, and close button have labels/hints.
- [x] **Links** — Email (mailto), LinkedIn, SmartRehab, Air Guitar external URLs are correct and open in Safari.
- [x] **UI** — Home (hero + featured projects), Skills, Projects (full list + detail sheet), Contact (email + LinkedIn) are implemented.

## Build & test

```bash
# Build
xcodebuild -scheme WhosWill -destination 'platform=iOS Simulator,name=iPhone 17' build

# Run unit tests
xcodebuild -scheme WhosWill -destination 'platform=iOS Simulator,name=iPhone 17' test -only-testing:WhosWillTests
```

## App Store / TestFlight

1. In Xcode: Select the WhosWill target → **Signing & Capabilities** → choose your Team.
2. Set **Version** and **Build** in the target’s General tab.
3. **Product → Archive** → **Distribute App** (App Store Connect or Ad Hoc).
4. Ensure `en.json`, `zh-Hans.json`, `zh-Hant.json` are in the app target’s **Copy Bundle Resources** (they are under `WhosWill/Resources/messages/` with file system sync).

## Optional

- Add a **Privacy Policy** URL in App Store Connect if required.
- Replace placeholder project images in `Project.baseProjects` with real asset URLs or bundled images.
