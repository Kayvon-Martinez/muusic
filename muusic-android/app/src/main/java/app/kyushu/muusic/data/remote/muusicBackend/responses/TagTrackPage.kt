package app.kyushu.muusic.data.remote.muusicBackend.responses

data class TagTrackPage(
    val currentPageUrl: String,
    val firstPageUrl: String,
    val lastPageUrl: String,
    val nextPageUrl: String,
    val previousPageUrl: String,
    val totalPages: Int,
    val tracks: List<app.kyushu.muusic.data.remote.muusicBackend.responses.TrackXX>
)