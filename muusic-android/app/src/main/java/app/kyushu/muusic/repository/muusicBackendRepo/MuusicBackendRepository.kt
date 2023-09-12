package app.kyushu.muusic.repository.muusicBackendRepo

import app.kyushu.muusic.data.remote.muusicBackend.responses.AlbumDetails
import app.kyushu.muusic.data.remote.muusicBackend.responses.ArtistDetails
import app.kyushu.muusic.data.remote.muusicBackend.responses.ArtistEventsPage
import app.kyushu.muusic.data.remote.muusicBackend.responses.ExtractedSong
import app.kyushu.muusic.data.remote.muusicBackend.responses.Lyrics
import app.kyushu.muusic.data.remote.muusicBackend.responses.SearchResults
import app.kyushu.muusic.data.remote.muusicBackend.responses.TagAlbumPage
import app.kyushu.muusic.data.remote.muusicBackend.responses.TagArtistPage
import app.kyushu.muusic.data.remote.muusicBackend.responses.TagDetails
import app.kyushu.muusic.data.remote.muusicBackend.responses.TagTrackPage
import app.kyushu.muusic.data.remote.muusicBackend.responses.TrackDetails
import app.kyushu.muusic.util.Resource

interface MuusicBackendRepository {
    suspend fun getSearchResults(source: String, query: String): Resource<SearchResults>
    suspend fun getArtistDetails(source: String, url: String): Resource<ArtistDetails>
    suspend fun getAlbumDetails(source: String, url: String): Resource<AlbumDetails>
    suspend fun getTrackDetails(source: String, url: String): Resource<TrackDetails>
    suspend fun getTagDetails(source: String, url: String): Resource<TagDetails>
    suspend fun getTagArtistsPage(source: String, url: String, page: Int): Resource<TagArtistPage>
    suspend fun getTagAlbumsPage(source: String, url: String, page: Int): Resource<TagAlbumPage>
    suspend fun getTagTracksPage(source: String, url: String, page: Int): Resource<TagTrackPage>
    suspend fun getLyrics(source: String, url: String): Resource<Lyrics>
    suspend fun getArtistEventsPage(source: String, url: String): Resource<ArtistEventsPage>
    suspend fun getExtractedSong(source: String, url: String): Resource<ExtractedSong>

}