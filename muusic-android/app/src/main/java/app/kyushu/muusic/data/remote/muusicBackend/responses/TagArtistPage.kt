package app.kyushu.muusic.data.remote.muusicBackend.responses

data class TagArtistPage(
    val artists: List<ArtistX>,
    val currentPageUrl: String,
    val firstPageUrl: String,
    val lastPageUrl: String,
    val nextPageUrl: String,
    val previousPageUrl: Any?,
    val totalPages: Int
)