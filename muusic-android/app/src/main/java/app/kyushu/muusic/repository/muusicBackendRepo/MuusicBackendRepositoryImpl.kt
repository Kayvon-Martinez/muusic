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

    override suspend fun getSearchResults(query: String): Resource<SearchResults> {
        return try {
            val response = muusicBackendApi.search(query)
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getArtistDetails(url: String): Resource<ArtistDetails> {
        return try {
            val response = muusicBackendApi.artistDetails(createJsonRequestBody("url" to url))
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getAlbumDetails(url: String): Resource<AlbumDetails> {
        return try {
            val response = muusicBackendApi.albumDetails(createJsonRequestBody("url" to url))
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getTrackDetails(url: String): Resource<TrackDetails> {
        return try {
            val response = muusicBackendApi.trackDetails(createJsonRequestBody("url" to url))
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getTagDetails(url: String): Resource<TagDetails> {
        return try {
            val response = muusicBackendApi.tagDetails(createJsonRequestBody("url" to url))
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getTagArtistsPage(
        url: String,
        page: Int
    ): Resource<TagArtistPage> {
        return try {
            val response = muusicBackendApi.tagArtists(

                createJsonRequestBody("url" to url, "page" to page)
            )
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getTagAlbumsPage(
        url: String,
        page: Int
    ): Resource<TagAlbumPage> {
        return try {
            val response = muusicBackendApi.artistAlbums(

                createJsonRequestBody("url" to url, "page" to page)
            )
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getTagTracksPage(
        url: String,
        page: Int
    ): Resource<TagTrackPage> {
        return try {
            val response = muusicBackendApi.tagTracks(

                createJsonRequestBody("url" to url, "page" to page)
            )
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getLyrics(url: String): Resource<Lyrics> {
        return try {
            val response = muusicBackendApi.lyrics(createJsonRequestBody("url" to url))
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getArtistEventsPage(
        url: String,
    ): Resource<ArtistEventsPage> {
        return try {
            val response = muusicBackendApi.events(

                createJsonRequestBody("url" to url)
            )
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }

    override suspend fun getExtractedSong(url: String): Resource<ExtractedSong> {
        return try {
            val response = muusicBackendApi.extractor(createJsonRequestBody("url" to url))
            Resource.Success(response)
        } catch (e: Exception) {
            Resource.Error(e.message ?: "An error occurred")
        }
    }
}