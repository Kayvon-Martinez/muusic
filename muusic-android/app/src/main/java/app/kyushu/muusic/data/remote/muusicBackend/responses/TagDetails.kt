package app.kyushu.muusic.data.remote.muusicBackend.responses

data class TagDetails(
    val description: String,
    val imageUrl: String,
    val itemType: String,
    val moreAlbumsUrl: String,
    val moreArtistsUrl: String,
    val moreTracksUrl: String,
    val name: String,
    val relatedTags: List<app.kyushu.muusic.data.remote.muusicBackend.responses.RelatedTag>,
    val similarTags: List<app.kyushu.muusic.data.remote.muusicBackend.responses.SimilarTag>,
    val topAlbums: List<app.kyushu.muusic.data.remote.muusicBackend.responses.TopAlbum>,
    val topArtists: List<app.kyushu.muusic.data.remote.muusicBackend.responses.TopArtist>,
    val topTracks: List<app.kyushu.muusic.data.remote.muusicBackend.responses.TopTrackX>,
    val url: String
)