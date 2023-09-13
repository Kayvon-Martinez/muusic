package app.kyushu.muusic.data.remote.muusicBackend.responses

data class ExtractedSong(
    val audioCodec: String,
    val bitrate: Bitrate,
    val fileSize: FileSize,
    val qualityLabel: String,
    val streamUrl: String
)