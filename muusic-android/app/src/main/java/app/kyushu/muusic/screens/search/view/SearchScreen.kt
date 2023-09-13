package app.kyushu.muusic.screens.search.view

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import app.kyushu.muusic.screens.search.composables.SearchBar
import cafe.adriel.voyager.core.screen.Screen

object SearchScreen: Screen {
    @Composable
    override fun Content() {
        Surface(
            color = MaterialTheme.colorScheme.background,
            modifier = Modifier
                .fillMaxSize()
                .padding(vertical = 16.dp, horizontal = 8.dp)
        ) {
            Column(
                modifier = Modifier.fillMaxSize(),
            ) {
                SearchBar(
                    onSearch = {  }
                )
            }
        }
    }
}