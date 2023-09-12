package app.kyushu.muusic.data.remote.muusicBackend.responses

data class AlbumDetails(
    val artistName: String,
    val artistUrl: String,
    val description: String,
    val duration: Any?,
    val externalLinks: List<app.kyushu.muusic.data.remote.muusicBackend.responses.ExternalLinkX>,
    val imageUrl: String,
    val itemType: String,
    val listeners: Int,
    val name: String,
    val numberOfTracks: Int,
    val releaseDate: String,
    val similarAlbums: List<app.kyushu.muusic.data.remote.muusicBackend.responses.SimilarAlbum>,
    val tags: List<app.kyushu.muusic.data.remote.muusicBackend.responses.TagX>,
    val tracks: List<app.kyushu.muusic.data.remote.muusicBackend.responses.TrackX>,
    val url: String
)