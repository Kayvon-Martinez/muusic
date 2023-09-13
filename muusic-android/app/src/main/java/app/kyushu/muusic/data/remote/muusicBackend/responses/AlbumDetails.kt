package app.kyushu.muusic.data.remote.muusicBackend.responses

data class AlbumDetails(
    val artistName: String,
    val artistUrl: String,
    val description: String,
    val duration: Any?,
    val externalLinks: List<ExternalLinkX>,
    val imageUrl: String,
    val itemType: String,
    val listeners: Int,
    val name: String,
    val numberOfTracks: Int,
    val releaseDate: String,
    val similarAlbums: List<SimilarAlbum>,
    val tags: List<TagX>,
    val tracks: List<TrackX>,
    val url: String
)