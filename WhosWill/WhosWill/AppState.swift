//
//  AppState.swift
//  WhosWill
//
//  Locale and translations state.
//

import SwiftUI

@Observable
final class AppState {
    var locale: AppLocale {
        didSet { UserDefaults.standard.set(locale.rawValue, forKey: "app_locale") }
    }
    
    private(set) var translations: Translations?
    
    init() {
        let saved = UserDefaults.standard.string(forKey: "app_locale")
        self.locale = AppLocale(rawValue: saved ?? "en") ?? .en
        self.translations = TranslationsLoader.load(self.locale)
    }
    
    func reloadTranslations() {
        translations = TranslationsLoader.load(locale)
    }
    
    func setLocale(_ newLocale: AppLocale) {
        locale = newLocale
        reloadTranslations()
    }
    
    var t: Translations {
        translations ?? TranslationsLoader.load(.en) ?? Translations.fallback()
    }
    
    /// Projects with titles/descriptions/features/awards from current locale.
    func projects() -> [Project] {
        Self.mergeProjects(base: Project.baseProjects, with: t.projectsData)
    }
    
    /// Merges base projects with localized project data. Exposed for unit testing.
    static func mergeProjects(base: [Project], with data: ProjectsDataMsg) -> [Project] {
        let idToKey: [String: String] = ["1": "smartrehab", "2": "airGuitar"]
        return base.map { p in
            let key = idToKey[p.id]
            guard let key = key else { return p }
            let entry: ProjectDataEntry?
            switch key {
            case "smartrehab": entry = data.smartrehab
            case "airGuitar": entry = data.airGuitar
            default: entry = nil
            }
            guard let e = entry else { return p }
            return Project(
                id: p.id,
                title: e.title,
                description: e.description,
                technologies: p.technologies,
                images: p.images,
                features: e.features ?? p.features,
                awards: e.awards ?? p.awards,
                githubUrl: p.githubUrl,
                youtubeUrl: p.youtubeUrl,
                externalUrl: p.externalUrl
            )
        }
    }
}
