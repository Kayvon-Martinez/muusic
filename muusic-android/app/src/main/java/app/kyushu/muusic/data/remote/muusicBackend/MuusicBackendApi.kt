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
    @GET("search/{query}")
    suspend fun search(
        @Path("query") query: String
    ): SearchResults

    @POST("details/artist")
    suspend fun artistDetails(
        @Body params: RequestBody
    ): ArtistDetails

    @POST("details/album")
    suspend fun albumDetails(
        @Body params: RequestBody
    ): AlbumDetails

    @POST("details/track")
    suspend fun trackDetails(
        @Body params: RequestBody
    ): TrackDetails

    @POST("details/tag")
    suspend fun tagDetails(
        @Body params: RequestBody
    ): TagDetails

    @POST("tag/artists")
    suspend fun tagArtists(
        @Body params: RequestBody
    ): TagArtistPage

    @POST("tag/albums")
    suspend fun artistAlbums(
        @Body params: RequestBody
    ): TagAlbumPage

    @POST("tag/tracks")
    suspend fun tagTracks(
        @Body params: RequestBody
    ): TagTrackPage

    @POST("lyrics")
    suspend fun lyrics(
        @Body params: RequestBody
    ): Lyrics

    @POST("events")
    suspend fun events(
        @Body params: RequestBody
    ): ArtistEventsPage

    @POST("extractor")
    suspend fun extractor(
        @Body params: RequestBody
    ): ExtractedSong
}