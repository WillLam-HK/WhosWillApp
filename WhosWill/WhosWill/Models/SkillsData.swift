//
//  SkillsData.swift
//  WhosWill
//
//  Static skill categories and languages (labels come from translations).
//

import Foundation

struct SkillItem: Identifiable {
    let id = UUID()
    let name: String
    let level: Int // 0–100
}

struct SkillCategory: Identifiable {
    let id = UUID()
    let key: String // "mobile" | "ai" | "web" | "tools"
    let items: [SkillItem]
}

struct LanguageItem: Identifiable {
    let id = UUID()
    let nameKey: String
    let proficiencyKey: String
    let level: Int
}

enum SkillsData {
    static let categories: [SkillCategory] = [
        SkillCategory(key: "mobile", items: [
            SkillItem(name: "React Native", level: 92),
            SkillItem(name: "Swift / iOS", level: 88),
            SkillItem(name: "Kotlin / Android", level: 85),
            SkillItem(name: "Flutter", level: 75),
        ]),
        SkillCategory(key: "ai", items: [
            SkillItem(name: "Computer vision (on-device)", level: 88),
            SkillItem(name: "Machine learning", level: 75),
            SkillItem(name: "Python", level: 82),
        ]),
        SkillCategory(key: "web", items: [
            SkillItem(name: "React / React.js", level: 85),
            SkillItem(name: "Node.js", level: 80),
            SkillItem(name: "Laravel", level: 70),
        ]),
        SkillCategory(key: "tools", items: [
            SkillItem(name: "Git & version control", level: 90),
            SkillItem(name: "Jira & Scrum", level: 85),
            SkillItem(name: "DevOps / deployment", level: 78),
            SkillItem(name: "MVVM / OOP", level: 88),
        ]),
    ]
    
    static let languages: [LanguageItem] = [
        LanguageItem(nameKey: "english", proficiencyKey: "fullProfessional", level: 90),
        LanguageItem(nameKey: "cantonese", proficiencyKey: "native", level: 100),
        LanguageItem(nameKey: "mandarin", proficiencyKey: "fullProfessional", level: 88),
    ]
    
    static let yearsExperience = 5
}
