package app.kyushu.muusic.data.remote.muusicBackend.responses

data class TagAlbumPage(
    val albums: List<AlbumXX>,
    val currentPageUrl: String,
    val firstPageUrl: String,
    val lastPageUrl: String,
    val nextPageUrl: String,
    val previousPageUrl: String,
    val totalPages: Int
)