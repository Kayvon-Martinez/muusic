package app.kyushu.muusic.data.remote.muusicBackend.responses

data class Artist(
    val imageUrl: String,
    val itemType: String,
    val listeners: Int,
    val name: String,
    val shortDescription: String?,
    val url: String
)