//
//  WhosWillTests.swift
//  WhosWillTests
//

import Foundation
import Testing
@testable import WhosWill

// MARK: - AppLocale

struct AppLocaleTests {

    @Test func rawValues() {
        #expect(AppLocale.en.rawValue == "en")
        #expect(AppLocale.zhHans.rawValue == "zh-Hans")
        #expect(AppLocale.zhHant.rawValue == "zh-Hant")
    }

    @Test func displayNames() {
        #expect(AppLocale.en.displayName == "English")
        #expect(AppLocale.zhHans.displayName == "简体中文")
        #expect(AppLocale.zhHant.displayName == "繁體中文")
    }

    @Test func bundleFileName() {
        #expect(AppLocale.en.bundleFileName == "en")
        #expect(AppLocale.zhHans.bundleFileName == "zh-Hans")
        #expect(AppLocale.zhHant.bundleFileName == "zh-Hant")
    }

    @Test func allCasesCount() {
        #expect(AppLocale.allCases.count == 3)
    }

    @Test func identifiableId() {
        #expect(AppLocale.en.id == "en")
    }
}

// MARK: - Project

struct ProjectTests {

    @Test func baseProjectsCount() {
        #expect(Project.baseProjects.count == 2)
    }

    @Test func baseProjectsIds() {
        #expect(Project.baseProjects[0].id == "1")
        #expect(Project.baseProjects[1].id == "2")
    }

    @Test func baseProjectsTitles() {
        #expect(Project.baseProjects[0].title == "SmartRehab")
        #expect(Project.baseProjects[1].title == "Air Guitar")
    }

    @Test func baseProjectsHaveExternalUrls() {
        #expect(Project.baseProjects[0].externalUrl != nil)
        #expect(Project.baseProjects[1].externalUrl != nil)
    }

    @Test func projectEquatable() {
        let a = Project.baseProjects[0]
        let b = Project(
            id: a.id,
            title: "Other",
            description: a.description,
            technologies: a.technologies,
            images: a.images,
            features: a.features,
            awards: a.awards,
            githubUrl: a.githubUrl,
            youtubeUrl: a.youtubeUrl,
            externalUrl: a.externalUrl
        )
        #expect(a != b)
        #expect(a.id == Project.baseProjects[0].id)
    }
}

// MARK: - SkillsData

struct SkillsDataTests {

    @Test func categoriesCount() {
        #expect(SkillsData.categories.count == 4)
    }

    @Test func categoryKeys() {
        let keys = Set(SkillsData.categories.map(\.key))
        #expect(keys.contains("mobile"))
        #expect(keys.contains("ai"))
        #expect(keys.contains("web"))
        #expect(keys.contains("tools"))
    }

    @Test func totalSkillItems() {
        let total = SkillsData.categories.reduce(0) { $0 + $1.items.count }
        #expect(total == 14)
    }

    @Test func languagesCount() {
        #expect(SkillsData.languages.count == 3)
    }

    @Test func yearsExperience() {
        #expect(SkillsData.yearsExperience == 5)
    }

    @Test func skillLevelsInRange() {
        for category in SkillsData.categories {
            for item in category.items {
                #expect(item.level >= 0 && item.level <= 100)
            }
        }
        for lang in SkillsData.languages {
            #expect(lang.level >= 0 && lang.level <= 100)
        }
    }
}

// MARK: - Project merge (AppState.mergeProjects)

struct ProjectMergeTests {

    @Test func mergeWithNoDataReturnsBaseTitles() {
        let data = ProjectsDataMsg(smartrehab: nil, airGuitar: nil)
        let result = AppState.mergeProjects(base: Project.baseProjects, with: data)
        #expect(result.count == 2)
        #expect(result[0].title == "SmartRehab")
        #expect(result[1].title == "Air Guitar")
    }

    @Test func mergeWithSmartrehabDataOverridesTitleAndDescription() {
        let entry = ProjectDataEntry(
            title: "SmartRehab Localized",
            description: "Localized description",
            features: ["Feature 1"],
            awards: nil
        )
        let data = ProjectsDataMsg(smartrehab: entry, airGuitar: nil)
        let result = AppState.mergeProjects(base: Project.baseProjects, with: data)
        #expect(result[0].title == "SmartRehab Localized")
        #expect(result[0].description == "Localized description")
        #expect(result[0].features?.count == 1)
        #expect(result[0].features?[0] == "Feature 1")
        #expect(result[1].title == "Air Guitar")
    }

    @Test func mergePreservesTechnologiesAndUrls() {
        let entry = ProjectDataEntry(
            title: "SmartRehab",
            description: "Desc",
            features: nil,
            awards: nil
        )
        let data = ProjectsDataMsg(smartrehab: entry, airGuitar: nil)
        let result = AppState.mergeProjects(base: Project.baseProjects, with: data)
        #expect(result[0].technologies == Project.baseProjects[0].technologies)
        #expect(result[0].externalUrl == Project.baseProjects[0].externalUrl)
    }
}

// MARK: - Translations

struct TranslationsTests {

    @Test func fallbackReturnsValidTranslations() {
        let t = Translations.fallback()
        #expect(!t.nav.home.isEmpty)
        #expect(!t.common.viewDetails.isEmpty)
        #expect(!t.hero.tagline.isEmpty)
        #expect(!t.home.featuredProjects.isEmpty)
        #expect(!t.projects.title.isEmpty)
        #expect(!t.contact.title.isEmpty)
        #expect(!t.skills.title.isEmpty)
        #expect(!t.footer.copyright.isEmpty)
    }

    @Test func fallbackProjectsDataIsNilSoMergeUsesBase() {
        let t = Translations.fallback()
        #expect(t.projectsData.smartrehab == nil)
        #expect(t.projectsData.airGuitar == nil)
        let merged = AppState.mergeProjects(base: Project.baseProjects, with: t.projectsData)
        #expect(merged[0].title == "SmartRehab")
        #expect(merged[1].title == "Air Guitar")
    }

    @Test func decodeMinimalTranslationsFromJSON() throws {
        let json = """
        {
          "nav": {"home":"Home","skills":"Skills","projects":"Projects","contact":"Contact"},
          "common": {"skipToContent":"Skip","viewAll":"View all","viewDetails":"Details","close":"Close","link":"Link","github":"GitHub","video":"Video","visitProject":"Visit","featuresSection":"Features","awardsSection":"Awards","moreProjectsLater":"Later","moreProjectsSoon":"Soon"},
          "hero": {"tagline":"Tagline"},
          "home": {"work":"Work","featuredProjects":"Featured"},
          "projects": {"portfolio":"Portfolio","title":"Projects"},
          "contact": {"getInTouch":"Touch","title":"Contact","intro":"Intro","orEmail":"Email","connectLinkedIn":"LinkedIn","form": {"name":"Name","email":"Email","message":"Message","send":"Send","sending":"Sending","success":"OK","error":"Error","errors": {"nameRequired":"","nameMin":"","emailRequired":"","emailInvalid":"","messageRequired":"","messageMin":""}}},
          "skills": {"profile":"Profile","title":"Skills","intro":"Intro","overview":"Overview","yearsExperience":"Years","technicalSkills":"Tech","education":"Edu","experienceTitle":"Exp","languagesTitle":"Lang","profileSource":"Source","linkedInProfile":"LinkedIn","categories": {"mobile":"Mobile","ai":"AI","web":"Web","tools":"Tools"},"experience": [],"languageNames": {"english":"English","cantonese":"Cantonese","mandarin":"Mandarin"},"languageProficiency": {"fullProfessional":"Full","native":"Native"}},
          "footer": {"copyright":"Copyright","getInTouch":"Touch"},
          "projectsData": {"smartrehab": null, "airGuitar": null}
        }
        """
        let data = Data(json.utf8)
        let decoded = try JSONDecoder().decode(Translations.self, from: data)
        #expect(decoded.nav.home == "Home")
        #expect(decoded.hero.tagline == "Tagline")
        #expect(decoded.projectsData.smartrehab == nil)
    }
}

// MARK: - AppState

struct AppStateTests {

    @Test func projectsReturnsCorrectCount() {
        let state = AppState()
        let projects = state.projects()
        #expect(projects.count == 2)
    }

    @Test func tNeverThrows() {
        let state = AppState()
        _ = state.t
        _ = state.t.nav.home
        _ = state.t.common.close
    }
}
