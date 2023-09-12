package app.kyushu.muusic.data.remote.muusicBackend

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
import okhttp3.RequestBody
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Path

interface MuusicBackendApi {
    @GET("{source}/search/{query}")
    suspend fun search(
        @Path("source") source: String,
        @Path("query") query: String
    ): SearchResults

    @POST("{source}/details/artist")
    suspend fun artistDetails(
        @Path("source") source: String,
        @Body params: RequestBody
    ): ArtistDetails

    @POST("{source}/details/album")
    suspend fun albumDetails(
        @Path("source") source: String,
        @Body params: RequestBody
    ): AlbumDetails

    @POST("{source}/details/track")
    suspend fun trackDetails(
        @Path("source") source: String,
        @Body params: RequestBody
    ): TrackDetails

    @POST("{source}/details/tag")
    suspend fun tagDetails(
        @Path("source") source: String,
        @Body params: RequestBody
    ): TagDetails

    @POST("{source}/tag/artists")
    suspend fun tagArtists(
        @Path("source") source: String,
        @Body params: RequestBody
    ): TagArtistPage

    @POST("{source}/tag/albums")
    suspend fun artistAlbums(
        @Path("source") source: String,
        @Body params: RequestBody
    ): TagAlbumPage

    @POST("{source}/tag/tracks")
    suspend fun tagTracks(
        @Path("source") source: String,
        @Body params: RequestBody
    ): TagTrackPage

    @POST("{source}/lyrics")
    suspend fun lyrics(
        @Path("source") source: String,
        @Body params: RequestBody
    ): Lyrics

    @POST("{source}/events")
    suspend fun events(
        @Path("source") source: String,
        @Body params: RequestBody
    ): ArtistEventsPage

    @POST("{source}/extractor")
    suspend fun extractor(
        @Path("source") source: String,
        @Body params: RequestBody
    ): ExtractedSong
}