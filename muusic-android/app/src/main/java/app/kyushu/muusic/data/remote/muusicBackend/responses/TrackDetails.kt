package app.kyushu.muusic.data.remote.muusicBackend.responses

data class TrackDetails(
    val albumName: String,
    val artistName: String,
    val artistUrl: String,
    val description: String,
    val duration: Int,
    val externalLinks: List<app.kyushu.muusic.data.remote.muusicBackend.responses.ExternalLinkXX>,
    val featuredOnAlbums: List<app.kyushu.muusic.data.remote.muusicBackend.responses.FeaturedOnAlbum>,
    val imageUrl: String,
    val listeners: Int,
    val lyricsUrl: String,
    val name: String,
    val number: Any?,
    val playLinks: List<app.kyushu.muusic.data.remote.muusicBackend.responses.PlayLink>,
    val similarArtists: List<app.kyushu.muusic.data.remote.muusicBackend.responses.SimilarArtistX>,
    val similarTracks: List<app.kyushu.muusic.data.remote.muusicBackend.responses.SimilarTrack>,
    val source: app.kyushu.muusic.data.remote.muusicBackend.responses.SourceXXXX,
    val tags: List<app.kyushu.muusic.data.remote.muusicBackend.responses.TagXX>,
    val url: String
)