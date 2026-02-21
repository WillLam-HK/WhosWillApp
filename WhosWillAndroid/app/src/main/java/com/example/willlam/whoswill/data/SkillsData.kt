package com.example.willlam.whoswill.data

data class SkillItem(val name: String, val level: Int)

data class SkillCategory(val key: String, val items: List<SkillItem>)

data class LanguageItem(val nameKey: String, val proficiencyKey: String, val level: Int)

object SkillsData {
    val categories: List<SkillCategory> = listOf(
        SkillCategory("mobile", listOf(
            SkillItem("React Native", 92),
            SkillItem("Swift / iOS", 88),
            SkillItem("Kotlin / Android", 85),
            SkillItem("Flutter", 75)
        )),
        SkillCategory("ai", listOf(
            SkillItem("Computer vision (on-device)", 88),
            SkillItem("Machine learning", 75),
            SkillItem("Python", 82)
        )),
        SkillCategory("web", listOf(
            SkillItem("React / React.js", 85),
            SkillItem("Node.js", 80),
            SkillItem("Laravel", 70)
        )),
        SkillCategory("tools", listOf(
            SkillItem("Git & version control", 90),
            SkillItem("Jira & Scrum", 85),
            SkillItem("DevOps / deployment", 78),
            SkillItem("MVVM / OOP", 88)
        ))
    )

    val languages: List<LanguageItem> = listOf(
        LanguageItem("english", "fullProfessional", 90),
        LanguageItem("cantonese", "native", 100),
        LanguageItem("mandarin", "fullProfessional", 88)
    )

    const val yearsExperience = 5
}
