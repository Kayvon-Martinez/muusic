package app.kyushu.muusic.data.remote.muusicBackend.responses

data class Track(
    val albumName: String?,
    val artistName: String,
    val artistUrl: String,
    val duration: Any?,
    val imageUrl: String,
    val itemType: String,
    val listeners: Any?,
    val name: String,
    val number: Any?,
    val source: app.kyushu.muusic.data.remote.muusicBackend.responses.Source,
    val url: String
)