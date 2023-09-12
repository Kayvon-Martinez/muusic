package app.kyushu.muusic.data.remote.muusicBackend.responses

data class TagArtistPage(
    val artists: List<app.kyushu.muusic.data.remote.muusicBackend.responses.ArtistX>,
    val currentPageUrl: String,
    val firstPageUrl: String,
    val lastPageUrl: String,
    val nextPageUrl: String,
    val previousPageUrl: Any?,
    val totalPages: Int
)