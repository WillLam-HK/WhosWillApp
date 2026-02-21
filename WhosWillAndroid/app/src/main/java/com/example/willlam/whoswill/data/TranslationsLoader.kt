package com.example.willlam.whoswill.data

import com.google.gson.Gson
import java.io.InputStreamReader

object TranslationsLoader {
    private val gson = Gson()

    fun load(locale: AppLocale, assetReader: (String) -> InputStreamReader?): Translations? {
        val path = "messages/${locale.assetFileName}.json"
        return try {
            assetReader(path)?.use { reader ->
                gson.fromJson(reader, Translations::class.java)
            }
        } catch (e: Exception) {
            null
        }
    }

    fun fallback(): Translations {
        return Translations(
            nav = Nav("Home", "Skills", "Projects", "Contact"),
            common = Common(
                "Skip to main content", "View all", "View details", "Close",
                "Link", "GitHub", "Video", "Visit project", "Features", "Awards & recognition",
                "More projects will be updated later.", "More projects will be added soon."
            ),
            hero = HeroMsg("Mobile app developer — iOS, Android, cross-platform."),
            home = HomeMsg("Work", "Featured projects"),
            projects = ProjectsMsg("Portfolio", "Projects"),
            contact = ContactMsg(
                "Get in touch", "Contact",
                "For work inquiries or collaboration, email directly.",
                "Or email directly:", "Connect on",
                ContactFormMsg("Name", "Email", "Message", "Send", "Sending…", "Thanks.", "Error",
                    ContactFormErrors("", "", "", "", "", ""))
            ),
            skills = SkillsMsg(
                "Profile", "Skills & experience", "Based on my professional experience.",
                "Overview", "Years experience", "Technical skills",
                "BEng Computer Engineering · MSc Computer Science",
                "Experience", "Languages", "Profile source:", "LinkedIn",
                SkillCategories("Mobile development", "AI & computer vision", "Web & backend", "Tools & practices"),
                emptyList(),
                LanguageNames("English", "Cantonese", "Mandarin"),
                LanguageProficiency("Full professional", "Native")
            ),
            footer = FooterMsg("Mobile app developer", "Get in touch"),
            projectsData = ProjectsDataMsg(null, null)
        )
    }
}

fun mergeProjects(base: List<Project>, data: ProjectsDataMsg): List<Project> {
    val idToKey = mapOf("1" to "smartrehab", "2" to "airGuitar")
    return base.map { p ->
        val key = idToKey[p.id] ?: return@map p
        val entry = when (key) {
            "smartrehab" -> data.smartrehab
            "airGuitar" -> data.airGuitar
            else -> null
        }
        if (entry == null) p
        else p.copy(
            title = entry.title,
            description = entry.description,
            features = entry.features ?: p.features,
            awards = entry.awards ?: p.awards
        )
    }
}
