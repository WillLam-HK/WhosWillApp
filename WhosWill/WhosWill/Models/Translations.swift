//
//  Translations.swift
//  WhosWill
//
//  Decodes en.json / zh-Hans.json / zh-Hant.json from bundle.
//

import Foundation

enum AppLocale: String, CaseIterable, Identifiable {
    case en = "en"
    case zhHans = "zh-Hans"
    case zhHant = "zh-Hant"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .en: return "English"
        case .zhHans: return "简体中文"
        case .zhHant: return "繁體中文"
        }
    }
    
    var bundleFileName: String {
        switch self {
        case .en: return "en"
        case .zhHans: return "zh-Hans"
        case .zhHant: return "zh-Hant"
        }
    }
}

// MARK: - Top-level messages

struct Translations: Codable {
    let nav: Nav
    let common: Common
    let hero: HeroMsg
    let home: HomeMsg
    let projects: ProjectsMsg
    let contact: ContactMsg
    let skills: SkillsMsg
    let footer: FooterMsg
    let projectsData: ProjectsDataMsg
}

struct Nav: Codable {
    let home: String
    let skills: String
    let projects: String
    let contact: String
}

struct Common: Codable {
    let skipToContent: String
    let viewAll: String
    let viewDetails: String
    let close: String
    let link: String
    let github: String
    let video: String
    let visitProject: String
    let featuresSection: String
    let awardsSection: String
    let moreProjectsLater: String
    let moreProjectsSoon: String
}

struct HeroMsg: Codable {
    let tagline: String
}

struct HomeMsg: Codable {
    let work: String
    let featuredProjects: String
}

struct ProjectsMsg: Codable {
    let portfolio: String
    let title: String
}

struct ContactMsg: Codable {
    let getInTouch: String
    let title: String
    let intro: String
    let orEmail: String
    let connectLinkedIn: String
    let form: ContactFormMsg
}

struct ContactFormMsg: Codable {
    let name: String
    let email: String
    let message: String
    let send: String
    let sending: String
    let success: String
    let error: String
    let errors: ContactFormErrors
}

struct ContactFormErrors: Codable {
    let nameRequired: String
    let nameMin: String
    let emailRequired: String
    let emailInvalid: String
    let messageRequired: String
    let messageMin: String
}

struct FooterMsg: Codable {
    let copyright: String
    let getInTouch: String
}

struct SkillsMsg: Codable {
    let profile: String
    let title: String
    let intro: String
    let overview: String
    let yearsExperience: String
    let technicalSkills: String
    let education: String
    let experienceTitle: String
    let languagesTitle: String
    let profileSource: String
    let linkedInProfile: String
    let categories: SkillCategories
    let experience: [ExperienceEntry]
    let languageNames: LanguageNames
    let languageProficiency: LanguageProficiency
}

struct SkillCategories: Codable {
    let mobile: String
    let ai: String
    let web: String
    let tools: String
}

struct ExperienceEntry: Codable {
    let role: String
    let company: String
    let period: String
    let duration: String
}

struct LanguageNames: Codable {
    let english: String
    let cantonese: String
    let mandarin: String
}

struct LanguageProficiency: Codable {
    let fullProfessional: String
    let native: String
}

struct ProjectsDataMsg: Codable {
    let smartrehab: ProjectDataEntry?
    let airGuitar: ProjectDataEntry?
}

struct ProjectDataEntry: Codable {
    let title: String
    let description: String
    let features: [String]?
    let awards: [String]?
}

// MARK: - Loader

enum TranslationsLoader {
    static func load(_ locale: AppLocale, from bundle: Bundle = .main) -> Translations? {
        let candidates = [
            bundle.url(forResource: locale.bundleFileName, withExtension: "json", subdirectory: "messages"),
            bundle.url(forResource: locale.bundleFileName, withExtension: "json", subdirectory: nil),
        ]
        guard let url = candidates.compactMap({ $0 }).first else { return nil }
        let data = try? Data(contentsOf: url)
        return data.flatMap { try? JSONDecoder().decode(Translations.self, from: $0) }
    }
}

// MARK: - Fallback (deploy-safe when bundle JSON is missing)

extension Translations {
    /// Minimal fallback so the app never crashes when translations fail to load.
    static func fallback() -> Translations {
        let nav = Nav(home: "Home", skills: "Skills", projects: "Projects", contact: "Contact")
        let common = Common(
            skipToContent: "Skip to main content",
            viewAll: "View all",
            viewDetails: "View details",
            close: "Close",
            link: "Link",
            github: "GitHub",
            video: "Video",
            visitProject: "Visit project",
            featuresSection: "Features",
            awardsSection: "Awards & recognition",
            moreProjectsLater: "More projects will be updated later.",
            moreProjectsSoon: "More projects will be added soon."
        )
        let hero = HeroMsg(tagline: "Mobile app developer — iOS, Android, cross-platform.")
        let home = HomeMsg(work: "Work", featuredProjects: "Featured projects")
        let projects = ProjectsMsg(portfolio: "Portfolio", title: "Projects")
        let formErrors = ContactFormErrors(
            nameRequired: "Name is required.",
            nameMin: "Name must be at least 2 characters.",
            emailRequired: "Email is required.",
            emailInvalid: "Please enter a valid email address.",
            messageRequired: "Message is required.",
            messageMin: "Message must be at least 10 characters."
        )
        let form = ContactFormMsg(
            name: "Name",
            email: "Email",
            message: "Message",
            send: "Send message",
            sending: "Sending…",
            success: "Thanks — your message was sent.",
            error: "Something went wrong.",
            errors: formErrors
        )
        let contact = ContactMsg(
            getInTouch: "Get in touch",
            title: "Contact",
            intro: "For work inquiries or collaboration, email directly.",
            orEmail: "Or email directly:",
            connectLinkedIn: "Connect on",
            form: form
        )
        let categories = SkillCategories(
            mobile: "Mobile development",
            ai: "AI & computer vision",
            web: "Web & backend",
            tools: "Tools & practices"
        )
        let experience: [ExperienceEntry] = []
        let languageNames = LanguageNames(english: "English", cantonese: "Cantonese", mandarin: "Mandarin")
        let proficiency = LanguageProficiency(fullProfessional: "Full professional", native: "Native")
        let skills = SkillsMsg(
            profile: "Profile",
            title: "Skills & experience",
            intro: "Based on my professional experience.",
            overview: "Overview",
            yearsExperience: "Years experience",
            technicalSkills: "Technical skills",
            education: "BEng Computer Engineering · MSc Computer Science",
            experienceTitle: "Experience",
            languagesTitle: "Languages",
            profileSource: "Profile source:",
            linkedInProfile: "LinkedIn",
            categories: categories,
            experience: experience,
            languageNames: languageNames,
            languageProficiency: proficiency
        )
        let footer = FooterMsg(copyright: "Mobile app developer", getInTouch: "Get in touch")
        let projectsData = ProjectsDataMsg(smartrehab: nil, airGuitar: nil)
        return Translations(
            nav: nav,
            common: common,
            hero: hero,
            home: home,
            projects: projects,
            contact: contact,
            skills: skills,
            footer: footer,
            projectsData: projectsData
        )
    }
}
