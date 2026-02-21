package com.example.willlam.whoswill.ui

import android.content.Context
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.example.willlam.whoswill.data.AppLocale
import com.example.willlam.whoswill.data.Project
import com.example.willlam.whoswill.data.Translations
import com.example.willlam.whoswill.data.TranslationsLoader
import com.example.willlam.whoswill.data.mergeProjects
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import java.io.InputStreamReader

private const val PREFS_NAME = "whoswill"
private const val KEY_LOCALE = "app_locale"

class AppViewModel(private val context: Context) : ViewModel() {

    private val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)

    private val _locale = MutableStateFlow(loadSavedLocale())
    val locale: StateFlow<AppLocale> = _locale.asStateFlow()

    private val _translations = MutableStateFlow<Translations?>(null)
    val translations: StateFlow<Translations?> = _translations.asStateFlow()

    val t: Translations
        get() = _translations.value ?: TranslationsLoader.load(AppLocale.EN, assetReader)
            ?: TranslationsLoader.fallback()

    private val assetReader: (String) -> InputStreamReader? = { path ->
        try {
            context.assets.open(path).reader(Charsets.UTF_8)
        } catch (_: Exception) {
            null
        }
    }

    init {
        _translations.value = TranslationsLoader.load(_locale.value, assetReader)
            ?: TranslationsLoader.fallback()
    }

    private fun loadSavedLocale(): AppLocale {
        val code = prefs.getString(KEY_LOCALE, null)
        return AppLocale.fromCode(code)
    }

    fun setLocale(newLocale: AppLocale) {
        if (_locale.value == newLocale) return
        prefs.edit().putString(KEY_LOCALE, newLocale.code).apply()
        _locale.value = newLocale
        _translations.value = TranslationsLoader.load(newLocale, assetReader)
            ?: TranslationsLoader.fallback()
    }

    fun projects(): List<Project> =
        mergeProjects(Project.baseProjects, t.projectsData)
}

class AppViewModelFactory(private val context: Context) : ViewModelProvider.Factory {
    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        if (modelClass == AppViewModel::class.java) {
            return AppViewModel(context.applicationContext) as T
        }
        throw IllegalArgumentException("Unknown ViewModel")
    }
}
