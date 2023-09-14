package app.kyushu.muusic

import android.annotation.SuppressLint
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.RowScope
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.NavigationBarItemDefaults
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import app.kyushu.muusic.screens.home.view.HomeScreen
import app.kyushu.muusic.screens.search.view.SearchScreen
import app.kyushu.muusic.ui.theme.MuusicTheme
import cafe.adriel.voyager.core.screen.Screen
import cafe.adriel.voyager.navigator.CurrentScreen
import cafe.adriel.voyager.navigator.LocalNavigator
import cafe.adriel.voyager.navigator.Navigator

@OptIn(ExperimentalMaterial3Api::class)
class MainActivity : ComponentActivity() {
    @SuppressLint("UnusedMaterial3ScaffoldPaddingParameter")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MuusicTheme {
                // A surface container using the 'background' color from the theme
                Navigator(
                    screens = listOf(
                        SearchScreen,
                        HomeScreen,
                    )
                ) { _ ->
                    Scaffold(
                        content = {
                            CurrentScreen()
                        },
                        bottomBar = {
                            NavigationBar(
                                containerColor = MaterialTheme.colorScheme.surface,
                                modifier = Modifier,
                            ) {
                                BottomNavigationBarItem(
                                    screen = HomeScreen,
                                    imageVector = Icons.Default.Home,
                                    label = "Home"
                                )
                                BottomNavigationBarItem(
                                    screen = SearchScreen,
                                    imageVector = Icons.Default.Search,
                                    label = "Search"
                                )
                            }
                        }
                    )
                }
            }
        }
    }
}

@Composable
private fun RowScope.BottomNavigationBarItem(screen: Screen, imageVector: ImageVector, label: String) {
    val navigator = LocalNavigator.current!!
    val selected = navigator.lastItem.key == screen.key

    NavigationBarItem(
        selected = selected,
        onClick = { if (!selected) navigator.push(screen) },
        icon = { Icon(imageVector = imageVector, contentDescription = label) },
        label = { Text(text = label) },
        colors = NavigationBarItemDefaults.colors(
            indicatorColor = MaterialTheme.colorScheme.primary,
        )
    )
}