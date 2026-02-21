package com.example.willlam.whoswill.data

import com.google.gson.annotations.SerializedName

data class Translations(
    val nav: Nav,
    val common: Common,
    val hero: HeroMsg,
    val home: HomeMsg,
    val projects: ProjectsMsg,
    val contact: ContactMsg,
    val skills: SkillsMsg,
    val footer: FooterMsg,
    @SerializedName("projectsData") val projectsData: ProjectsDataMsg
)

data class Nav(
    val home: String,
    val skills: String,
    val projects: String,
    val contact: String
)

data class Common(
    @SerializedName("skipToContent") val skipToContent: String,
    @SerializedName("viewAll") val viewAll: String,
    @SerializedName("viewDetails") val viewDetails: String,
    val close: String,
    val link: String,
    val github: String,
    val video: String,
    @SerializedName("visitProject") val visitProject: String,
    @SerializedName("featuresSection") val featuresSection: String,
    @SerializedName("awardsSection") val awardsSection: String,
    @SerializedName("moreProjectsLater") val moreProjectsLater: String,
    @SerializedName("moreProjectsSoon") val moreProjectsSoon: String
)

data class HeroMsg(val tagline: String)

data class HomeMsg(val work: String, @SerializedName("featuredProjects") val featuredProjects: String)

data class ProjectsMsg(val portfolio: String, val title: String)

data class ContactMsg(
    @SerializedName("getInTouch") val getInTouch: String,
    val title: String,
    val intro: String,
    @SerializedName("orEmail") val orEmail: String,
    @SerializedName("connectLinkedIn") val connectLinkedIn: String,
    val form: ContactFormMsg
)

data class ContactFormMsg(
    val name: String,
    val email: String,
    val message: String,
    val send: String,
    val sending: String,
    val success: String,
    val error: String,
    val errors: ContactFormErrors
)

data class ContactFormErrors(
    @SerializedName("nameRequired") val nameRequired: String,
    @SerializedName("nameMin") val nameMin: String,
    @SerializedName("emailRequired") val emailRequired: String,
    @SerializedName("emailInvalid") val emailInvalid: String,
    @SerializedName("messageRequired") val messageRequired: String,
    @SerializedName("messageMin") val messageMin: String
)

data class FooterMsg(val copyright: String, @SerializedName("getInTouch") val getInTouch: String)

data class SkillsMsg(
    val profile: String,
    val title: String,
    val intro: String,
    val overview: String,
    @SerializedName("yearsExperience") val yearsExperience: String,
    @SerializedName("technicalSkills") val technicalSkills: String,
    val education: String,
    @SerializedName("experienceTitle") val experienceTitle: String,
    @SerializedName("languagesTitle") val languagesTitle: String,
    @SerializedName("profileSource") val profileSource: String,
    @SerializedName("linkedInProfile") val linkedInProfile: String,
    val categories: SkillCategories,
    val experience: List<ExperienceEntry>,
    @SerializedName("languageNames") val languageNames: LanguageNames,
    @SerializedName("languageProficiency") val languageProficiency: LanguageProficiency
)

data class SkillCategories(
    val mobile: String,
    val ai: String,
    val web: String,
    val tools: String
)

data class ExperienceEntry(
    val role: String,
    val company: String,
    val period: String,
    val duration: String
)

data class LanguageNames(
    val english: String,
    val cantonese: String,
    val mandarin: String
)

data class LanguageProficiency(
    @SerializedName("fullProfessional") val fullProfessional: String,
    val native: String
)

data class ProjectsDataMsg(
    val smartrehab: ProjectDataEntry?,
    val airGuitar: ProjectDataEntry?
)

data class ProjectDataEntry(
    val title: String,
    val description: String,
    val features: List<String>?,
    val awards: List<String>?
)
