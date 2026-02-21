package com.example.willlam.whoswill

import com.example.willlam.whoswill.data.AppLocale
import com.example.willlam.whoswill.data.Project
import com.example.willlam.whoswill.data.ProjectsDataMsg
import com.example.willlam.whoswill.data.ProjectDataEntry
import com.example.willlam.whoswill.data.SkillsData
import com.example.willlam.whoswill.data.TranslationsLoader
import com.example.willlam.whoswill.data.mergeProjects
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotNull
import org.junit.Test

class ExampleUnitTest {

    @Test
    fun appLocale_fromCode() {
        assertEquals(AppLocale.EN, AppLocale.fromCode("en"))
        assertEquals(AppLocale.ZH_HANS, AppLocale.fromCode("zh-Hans"))
        assertEquals(AppLocale.ZH_HANT, AppLocale.fromCode("zh-Hant"))
        assertEquals(AppLocale.EN, AppLocale.fromCode(null))
        assertEquals(AppLocale.EN, AppLocale.fromCode("unknown"))
    }

    @Test
    fun project_baseProjects_countAndIds() {
        assertEquals(2, Project.baseProjects.size)
        assertEquals("1", Project.baseProjects[0].id)
        assertEquals("2", Project.baseProjects[1].id)
        assertEquals("SmartRehab", Project.baseProjects[0].title)
        assertEquals("Air Guitar", Project.baseProjects[1].title)
    }

    @Test
    fun mergeProjects_withNoData_returnsBaseTitles() {
        val data = ProjectsDataMsg(smartrehab = null, airGuitar = null)
        val result = mergeProjects(Project.baseProjects, data)
        assertEquals(2, result.size)
        assertEquals("SmartRehab", result[0].title)
        assertEquals("Air Guitar", result[1].title)
    }

    @Test
    fun mergeProjects_withSmartrehabData_overridesTitle() {
        val entry = ProjectDataEntry(
            title = "SmartRehab Localized",
            description = "Desc",
            features = listOf("F1"),
            awards = null
        )
        val data = ProjectsDataMsg(smartrehab = entry, airGuitar = null)
        val result = mergeProjects(Project.baseProjects, data)
        assertEquals("SmartRehab Localized", result[0].title)
        assertEquals("Air Guitar", result[1].title)
    }

    @Test
    fun skillsData_constants() {
        assertEquals(4, SkillsData.categories.size)
        assertEquals(14, SkillsData.categories.sumOf { it.items.size })
        assertEquals(3, SkillsData.languages.size)
        assertEquals(5, SkillsData.yearsExperience)
    }

    @Test
    fun translationsFallback_returnsValid() {
        val t = TranslationsLoader.fallback()
        assertNotNull(t.nav.home)
        assertNotNull(t.hero.tagline)
        assertNotNull(t.common.viewDetails)
    }
}
