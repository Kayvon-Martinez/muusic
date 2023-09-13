package app.kyushu.muusic.data.remote.muusicBackend.responses

data class TagDetails(
    val description: String,
    val imageUrl: String,
    val itemType: String,
    val moreAlbumsUrl: String,
    val moreArtistsUrl: String,
    val moreTracksUrl: String,
    val name: String,
    val relatedTags: List<RelatedTag>,
    val similarTags: List<SimilarTag>,
    val topAlbums: List<TopAlbum>,
    val topArtists: List<TopArtist>,
    val topTracks: List<TopTrackX>,
    val url: String
)