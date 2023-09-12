package app.kyushu.muusic.repository.muusicBackendRepo

import app.kyushu.muusic.data.remote.muusicBackend.MuusicBackendApi
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
import dagger.hilt.android.scopes.ActivityScoped
import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.RequestBody
import okhttp3.RequestBody.Companion.toRequestBody
import org.json.JSONObject
import javax.inject.Inject

@ActivityScoped
class MuusicBackendRepositoryImpl @Inject constructor(
    private val muusicBackendApi: MuusicBackendApi
) : MuusicBackendRepository {
    private fun createJsonRequestBody(vararg pairs: Pair<String, Any>): RequestBody {
        val json = JSONObject()
        pairs.forEach { json.put(it.first, it.second) }
        return json.toString().toRequestBody("application/json; charset=utf-8".toMediaTypeOrNull())
    }

    override suspend fun getSearchResults(source: String, query: String): Resource<SearchResults> {
        return try {
            val response = muusicBackendApi.search(source, query)
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getArtistDetails(source: String, url: String): Resource<ArtistDetails> {
        return try {
            val response = muusicBackendApi.artistDetails(source, createJsonRequestBody("url" to url))
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getAlbumDetails(source: String, url: String): Resource<AlbumDetails> {
        return try {
            val response = muusicBackendApi.albumDetails(source, createJsonRequestBody("url" to url))
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getTrackDetails(source: String, url: String): Resource<TrackDetails> {
        return try {
            val response = muusicBackendApi.trackDetails(source, createJsonRequestBody("url" to url))
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getTagDetails(source: String, url: String): Resource<TagDetails> {
        return try {
            val response = muusicBackendApi.tagDetails(source, createJsonRequestBody("url" to url))
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getTagArtistsPage(
        source: String,
        url: String,
        page: Int
    ): Resource<TagArtistPage> {
        return try {
            val response = muusicBackendApi.tagArtists(
                source,
                createJsonRequestBody("url" to url, "page" to page)
            )
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getTagAlbumsPage(
        source: String,
        url: String,
        page: Int
    ): Resource<TagAlbumPage> {
        return try {
            val response = muusicBackendApi.artistAlbums(
                source,
                createJsonRequestBody("url" to url, "page" to page)
            )
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getTagTracksPage(
        source: String,
        url: String,
        page: Int
    ): Resource<TagTrackPage> {
        return try {
            val response = muusicBackendApi.tagTracks(
                source,
                createJsonRequestBody("url" to url, "page" to page)
            )
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getLyrics(source: String, url: String): Resource<Lyrics> {
        return try {
            val response = muusicBackendApi.lyrics(source, createJsonRequestBody("url" to url))
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getArtistEventsPage(
        source: String,
        url: String,
    ): Resource<ArtistEventsPage> {
        return try {
            val response = muusicBackendApi.events(
                source,
                createJsonRequestBody("url" to url)
            )
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getExtractedSong(source: String, url: String): Resource<ExtractedSong> {
        return try {
            val response = muusicBackendApi.extractor(source, createJsonRequestBody("url" to url))
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }
}