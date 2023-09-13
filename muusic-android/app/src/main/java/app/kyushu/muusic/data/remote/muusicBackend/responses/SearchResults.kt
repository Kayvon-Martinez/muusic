package app.kyushu.muusic.data.remote.muusicBackend.responses

data class SearchResults(
    val albums: List<Album>,
    val artists: List<Artist>,
    val tracks: List<Track>
)