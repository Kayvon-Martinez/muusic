package app.kyushu.muusic.data.remote.muusicBackend.responses

data class SearchResults(
    val albums: List<app.kyushu.muusic.data.remote.muusicBackend.responses.Album>,
    val artists: List<app.kyushu.muusic.data.remote.muusicBackend.responses.Artist>,
    val tracks: List<app.kyushu.muusic.data.remote.muusicBackend.responses.Track>
)