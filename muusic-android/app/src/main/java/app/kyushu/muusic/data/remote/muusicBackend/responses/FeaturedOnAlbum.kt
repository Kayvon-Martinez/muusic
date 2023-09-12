package app.kyushu.muusic.data.remote.muusicBackend.responses

data class FeaturedOnAlbum(
    val artistName: String,
    val artistUrl: String,
    val imageUrl: String,
    val itemType: String,
    val listeners: Any?,
    val name: String,
    val numberOfTracks: Any?,
    val releaseDate: Any?,
    val url: String
)