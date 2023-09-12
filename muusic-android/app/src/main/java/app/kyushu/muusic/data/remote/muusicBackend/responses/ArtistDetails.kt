package app.kyushu.muusic.data.remote.muusicBackend.responses

data class ArtistDetails(
    val albums: List<app.kyushu.muusic.data.remote.muusicBackend.responses.AlbumX>,
    val allTracksUrl: String,
    val bio: String,
    val bornWhen: String,
    val bornWhere: String,
    val diedWhen: Any?,
    val eventsUrl: String,
    val externalLinks: List<app.kyushu.muusic.data.remote.muusicBackend.responses.ExternalLink>,
    val imageUrl: String,
    val isTouring: Boolean,
    val itemType: String,
    val latestRelease: app.kyushu.muusic.data.remote.muusicBackend.responses.LatestRelease,
    val listeners: Int,
    val morePhotosUrl: String,
    val name: String,
    val photoUrls: List<String>,
    val popularThisWeek: app.kyushu.muusic.data.remote.muusicBackend.responses.PopularThisWeek,
    val similarArtists: List<app.kyushu.muusic.data.remote.muusicBackend.responses.SimilarArtist>,
    val tags: List<app.kyushu.muusic.data.remote.muusicBackend.responses.Tag>,
    val topTracks: List<app.kyushu.muusic.data.remote.muusicBackend.responses.TopTrack>,
    val url: String
)