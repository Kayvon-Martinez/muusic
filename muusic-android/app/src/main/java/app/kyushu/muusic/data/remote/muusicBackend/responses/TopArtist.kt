package app.kyushu.muusic.data.remote.muusicBackend.responses

data class TopArtist(
    val imageUrl: String,
    val itemType: String,
    val listeners: Int,
    val name: String,
    val shortDescription: Any?,
    val url: String
)