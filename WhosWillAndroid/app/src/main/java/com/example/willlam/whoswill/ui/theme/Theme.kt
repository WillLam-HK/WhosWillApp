package com.example.willlam.whoswill.ui.theme

import android.app.Activity
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.LocalView
import androidx.core.view.WindowCompat

private val Primary = Color(0xFF4F46E5)
private val PrimaryDark = Color(0xFF4338CA)
private val OnPrimary = Color.White
private val Surface = Color(0xFFFAFAFA)
private val OnSurface = Color(0xFF171717)
private val OnSurfaceVariant = Color(0xFF525252)
private val Outline = Color(0xFFA3A3A3)

private val DarkPrimary = Color(0xFF818CF8)
private val DarkOnPrimary = Color(0xFF1E1B4B)
private val DarkSurface = Color(0xFF0A0A0A)
private val DarkOnSurface = Color(0xFFFAFAFA)
private val DarkOnSurfaceVariant = Color(0xFFA3A3A3)

@Composable
fun WhosWillTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    content: @Composable () -> Unit
) {
    val colorScheme = if (darkTheme) {
        darkColorScheme(
            primary = DarkPrimary,
            onPrimary = DarkOnPrimary,
            surface = DarkSurface,
            onSurface = DarkOnSurface,
            onSurfaceVariant = DarkOnSurfaceVariant
        )
    } else {
        lightColorScheme(
            primary = Primary,
            onPrimary = OnPrimary,
            surface = Surface,
            onSurface = OnSurface,
            onSurfaceVariant = OnSurfaceVariant,
            outline = Outline
        )
    }

    val view = LocalView.current
    if (!view.isInEditMode) {
        SideEffect {
            (view.context as? Activity)?.window?.let { window ->
                window.statusBarColor = colorScheme.surface.toArgb()
                WindowCompat.getInsetsController(window, view).isAppearanceLightStatusBars = !darkTheme
            }
        }
    }

    MaterialTheme(
        colorScheme = colorScheme,
        typography = Typography,
        content = content
    )
}
