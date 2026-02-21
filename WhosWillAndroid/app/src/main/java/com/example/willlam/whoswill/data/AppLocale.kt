package com.example.willlam.whoswill.data

enum class AppLocale(val code: String, val displayName: String) {
    EN("en", "English"),
    ZH_HANS("zh-Hans", "简体中文"),
    ZH_HANT("zh-Hant", "繁體中文");

    val assetFileName: String get() = code

    companion object {
        fun fromCode(code: String?): AppLocale =
            entries.find { it.code == code } ?: EN
    }
}
