package app.kyushu.muusic.data.remote.muusicBackend.responses

data class TopAlbum(
    val artistName: String,
    val artistUrl: String,
    val imageUrl: String,
    val itemType: String,
    val listeners: Int,
    val name: String,
    val numberOfTracks: Any?,
    val releaseDate: Any?,
    val url: String
)