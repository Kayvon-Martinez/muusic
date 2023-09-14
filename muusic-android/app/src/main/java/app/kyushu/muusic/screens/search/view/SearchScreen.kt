package app.kyushu.muusic.screens.search.view

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import app.kyushu.muusic.data.remote.muusicBackend.responses.TagDetails
import app.kyushu.muusic.screens.search.composables.SearchBar
import app.kyushu.muusic.screens.search.composables.TopTags
import app.kyushu.muusic.util.hipHopTagImageUrl
import cafe.adriel.voyager.core.screen.Screen

object SearchScreen: Screen {
    @Composable
    override fun Content() {
        val tags: List<TagDetails> = listOf(
            TagDetails(
                description = "Hip Hop",
                imageUrl = hipHopTagImageUrl,
                itemType = "Tag",
                moreAlbumsUrl = "https://www.last.fm/tag/hip-hop/albums",
                moreArtistsUrl = "https://www.last.fm/tag/hip-hop/artists",
                moreTracksUrl = "https://www.last.fm/tag/hip-hop/tracks",
                name = "Hip Hop",
                relatedTags = listOf(),
                similarTags = listOf(),
                topAlbums = listOf(),
                topArtists = listOf(),
                topTracks = listOf(),
                url = "https://www.last.fm/tag/hip-hop"
            ),
        )

        Surface(
            color = MaterialTheme.colorScheme.background,
            modifier = Modifier
                .fillMaxSize()
                .padding(vertical = 16.dp, horizontal = 8.dp)
        ) {
            Column(
                modifier = Modifier.fillMaxSize()
            ) {
                SearchBar(
                    onSearch = {  }
                )
                Spacer(modifier = Modifier.padding(16.dp))
                TopTags(tags = tags)
            }
        }
    }
}