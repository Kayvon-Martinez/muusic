package app.kyushu.muusic.data.remote.muusicBackend.responses

data class Track(
    val albumName: String?,
    val artistName: String,
    val artistUrl: String,
    val duration: Int?,
    val imageUrl: String,
    val itemType: String,
    val listeners: Int?,
    val name: String,
    val number: Int?,
    val source: Source,
    val url: String
)