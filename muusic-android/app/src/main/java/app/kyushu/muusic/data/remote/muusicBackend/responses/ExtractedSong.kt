package app.kyushu.muusic.data.remote.muusicBackend.responses

data class ExtractedSong(
    val audioCodec: String,
    val bitrate: app.kyushu.muusic.data.remote.muusicBackend.responses.Bitrate,
    val fileSize: app.kyushu.muusic.data.remote.muusicBackend.responses.FileSize,
    val qualityLabel: String,
    val streamUrl: String
)