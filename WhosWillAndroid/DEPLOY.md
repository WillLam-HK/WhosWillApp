# Deploy WhosWill (Android)

## Features (parity with iOS)

- **Tabs:** Home, Skills, Projects, Contact
- **Localization:** en, zh-Hans, zh-Hant (JSON in `app/src/main/assets/messages/`)
- **Home:** Hero (name, tagline, skill pills), featured projects (first 2), “View all” → Projects tab
- **Skills:** Overview stats, skill categories with progress bars, experience list, languages
- **Projects:** Full list, project cards, detail dialog (features, awards, links)
- **Contact:** Intro, email (mailto), LinkedIn link
- **Language picker:** Toolbar menu to switch locale (persisted in SharedPreferences)

## Build

```bash
./gradlew assembleDebug   # debug APK
./gradlew assembleRelease # release (configure signing first)
```

## Release checklist

1. **Signing:** Create a keystore and set `signingConfigs` in `app/build.gradle` for release.
2. **Version:** Update `versionCode` and `versionName` in `app/build.gradle`.
3. **Assets:** Ensure `assets/messages/en.json`, `zh-Hans.json`, `zh-Hant.json` are included (default for `src/main/assets`).
4. **ProGuard:** If you enable minify for release, add keep rules for Gson model classes if needed.

## Run on device/emulator

```bash
./gradlew installDebug
```

Or open the project in Android Studio and run the **app** configuration.
