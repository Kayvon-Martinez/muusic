package app.kyushu.muusic.data.remote.muusicBackend.responses

data class ArtistEventsPageItem(
    val address: String,
    val date: String,
    val performers: List<String>,
    val title: String,
    val venue: String
)