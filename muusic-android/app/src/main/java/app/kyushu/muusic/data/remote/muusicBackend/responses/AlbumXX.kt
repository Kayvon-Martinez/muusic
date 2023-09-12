package app.kyushu.muusic.data.remote.muusicBackend.responses

data class AlbumXX(
    val artistName: String,
    val artistUrl: String,
    val imageUrl: String,
    val itemType: String,
    val listeners: Int,
    val name: String,
    val numberOfTracks: Int?,
    val releaseDate: String?,
    val url: String
)