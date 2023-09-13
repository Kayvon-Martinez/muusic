package app.kyushu.muusic.data.remote.muusicBackend.responses

data class ArtistDetails(
    val albums: List<AlbumX>,
    val allTracksUrl: String,
    val bio: String,
    val bornWhen: String,
    val bornWhere: String,
    val diedWhen: Any?,
    val eventsUrl: String,
    val externalLinks: List<ExternalLink>,
    val imageUrl: String,
    val isTouring: Boolean,
    val itemType: String,
    val latestRelease: LatestRelease,
    val listeners: Int,
    val morePhotosUrl: String,
    val name: String,
    val photoUrls: List<String>,
    val popularThisWeek: PopularThisWeek,
    val similarArtists: List<SimilarArtist>,
    val tags: List<Tag>,
    val topTracks: List<TopTrack>,
    val url: String
)