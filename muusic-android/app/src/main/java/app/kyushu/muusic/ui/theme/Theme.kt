package app.kyushu.muusic.ui.theme

import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color

private val DarkColorScheme = darkColorScheme(
    primary = Color(0xFF6F11DB),
    onPrimary = Color.White,
    secondary = PurpleGrey40,
    onSecondary = Color(0xFFfefefe),
    tertiary = Pink80,
    onTertiary = Color(0xFFfefefe),
    background = Color(0xFF000000),
    onBackground = Color.White,
    surface = Color(0xFF161616),
    onSurface = Color(0xFFfefefe),
    error = Color(0xFFB90000),
    onError = Color.White
)

private val LightColorScheme = lightColorScheme(
    primary = Color(0xFF6F11DB),
    secondary = PurpleGrey40,
    tertiary = Pink40,
    onTertiary = Color(0xFFfefefe),
    background = Color(0xFFFFFBFE),
    onBackground = Color.White,
    surface = Color(0xFFC2C2C2),
    onSurface = Color(0xFF131313),
    error = Color(0xFFB90000),
    onError = Color.White

    /* Other default colors to override
    background = Color(0xFFFFFBFE),
    surface = Color(0xFFFFFBFE),
    onPrimary = Color.White,
    onSecondary = Color.White,
    onTertiary = Color.White,
    onBackground = Color(0xFF1C1B1F),
    onSurface = Color(0xFF1C1B1F),
    */
)

@Composable
fun MuusicTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    // Dynamic color is available on Android 12+
    dynamicColor: Boolean = false,
    content: @Composable () -> Unit
) {
//    val colorScheme = when {
//        dynamicColor && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S -> {
//            val context = LocalContext.current
//            if (darkTheme) dynamicDarkColorScheme(context) else dynamicLightColorScheme(context)
//        }
//
//        darkTheme -> DarkColorScheme
//        else -> LightColorScheme
//    }
//    val view = LocalView.current
//    if (!view.isInEditMode) {
//        SideEffect {
//            val window = (view.context as Activity).window
//            window.statusBarColor = colorScheme.background.toArgb()
//            window.navigationBarColor = colorScheme.background.toArgb()
//            WindowCompat.getInsetsController(window, view).isAppearanceLightStatusBars = !darkTheme
//        }
//    }
    val colorScheme = if (darkTheme) DarkColorScheme else LightColorScheme

    MaterialTheme(
        colorScheme = colorScheme,
        typography = Typography,
        content = content
    )
}