package app.kyushu.muusic.screens.search.view

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import app.kyushu.muusic.data.remote.muusicBackend.responses.Album
import app.kyushu.muusic.data.remote.muusicBackend.responses.Artist
import app.kyushu.muusic.data.remote.muusicBackend.responses.Source
import app.kyushu.muusic.data.remote.muusicBackend.responses.TagDetails
import app.kyushu.muusic.data.remote.muusicBackend.responses.Track
import app.kyushu.muusic.screens.search.composables.Category
import app.kyushu.muusic.screens.search.composables.SearchBar
import app.kyushu.muusic.screens.search.composables.TopTags
import app.kyushu.muusic.screens.search.viewModel.SearchViewModel
import app.kyushu.muusic.util.hipHopTagImageUrl
import cafe.adriel.voyager.androidx.AndroidScreen
import cafe.adriel.voyager.hilt.getViewModel

object SearchScreen: AndroidScreen() {

    @Composable
    override fun Content() {
        val viewModel = getViewModel<SearchViewModel>()

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

        val items: List<Any> = listOf(
            Artist(
                imageUrl = "https://lastfm.freetls.fastly.net/i/u/300x300/d35c21d3b74c79c7f71ecb9ec13d5ec3.jpg",
                itemType = "Artist",
                listeners = 1621034,
                name = "Lil Uzi Vert",
                shortDescription = null,
                url = "https://www.last.fm/music/Lil+Uzi+Vert"
            ),
            Album(
                artistName = "Lil Uzi Vert",
                artistUrl = "https://www.last.fm/music/Lil+Uzi+Vert",
                imageUrl = "https://lastfm.freetls.fastly.net/i/u/300x300/50f8bdf6b97cce0c9edd4a46f60079e8.jpg",
                itemType = "Album",
                listeners = null,
                name = "Lil Uzi Vert vs. the World",
                numberOfTracks = null,
                releaseDate = "20 Apr 2016, 00:00",
                url = "https://www.last.fm/music/Lil+Uzi+Vert/Lil+Uzi+Vert+vs.+the+World"
            ),
            Track(
                albumName = "XO TOUR Llif3",
                artistName = "Lil Uzi Vert",
                artistUrl = "https://www.last.fm/music/Lil+Uzi+Vert",
                duration = null,
                imageUrl = "https://lastfm.freetls.fastly.net/i/u/64s/b0531f821fe3d89f0081f6de2437fbe4.jpg",
                itemType = "Track",
                listeners = null,
                name = "XO TOUR Llif3",
                number = null,
                source = Source(
                    url = "https://www.youtube.com/watch?v=WrsFXgQk5UI",
                    extractorUrl = "/api/v1/extractor",
                ),
                url = "https://www.last.fm/music/Lil+Uzi+Vert/_/XO+TOUR+Llif3"
            )
        )

        Surface(
            color = MaterialTheme.colorScheme.background,
            modifier = Modifier
                .fillMaxSize()
                .padding(vertical = 12.dp, horizontal = 8.dp)
        ) {
            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .verticalScroll(rememberScrollState())
            ) {

                    SearchBar(
                    onSearch = {
                        viewModel.searchQuery = it
                        viewModel.search()
                    }
                )
                if (viewModel.searchResults.value == null) {
                    Spacer(modifier = Modifier.padding(12.dp))
                    TopTags(tags = tags)
                    Spacer(modifier = Modifier.padding(12.dp))
                    Category(categoryName = "Recently Played", items = items)
                } else {
                    Spacer(modifier = Modifier.padding(12.dp))
                    Category(categoryName = "Artists", items = viewModel.searchResults.value!!.artists)
                    Spacer(modifier = Modifier.padding(12.dp))
                    Category(categoryName = "Albums", items = viewModel.searchResults.value!!.albums)
                    Spacer(modifier = Modifier.padding(12.dp))
                    Category(categoryName = "Tracks", items = viewModel.searchResults.value!!.tracks)
                }
            }
        }
    }
}