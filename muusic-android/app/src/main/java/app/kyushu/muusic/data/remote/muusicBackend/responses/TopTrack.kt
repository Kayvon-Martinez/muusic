package app.kyushu.muusic.data.remote.muusicBackend.responses

data class TopTrack(
    val albumName: String?,
    val artistName: String,
    val artistUrl: String,
    val duration: Any?,
    val imageUrl: String,
    val itemType: String,
    val listeners: Int,
    val name: String,
    val number: Any?,
    val source: SourceX,
    val url: String
)