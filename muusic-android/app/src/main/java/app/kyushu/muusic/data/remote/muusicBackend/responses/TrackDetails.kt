package app.kyushu.muusic.data.remote.muusicBackend.responses

data class TrackDetails(
    val albumName: String,
    val artistName: String,
    val artistUrl: String,
    val description: String,
    val duration: Int,
    val externalLinks: List<ExternalLinkXX>,
    val featuredOnAlbums: List<FeaturedOnAlbum>,
    val imageUrl: String,
    val listeners: Int,
    val lyricsUrl: String,
    val name: String,
    val number: Any?,
    val playLinks: List<PlayLink>,
    val similarArtists: List<SimilarArtistX>,
    val similarTracks: List<SimilarTrack>,
    val source: SourceXXXX,
    val tags: List<TagXX>,
    val url: String
)