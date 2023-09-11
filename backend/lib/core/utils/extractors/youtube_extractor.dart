import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Future<List<int>> getYTVideoAudioData(String url) async {
  var videoId = url.split("v=")[1];
  var yt = YoutubeExplode();
  var manifest = await yt.videos.streamsClient.getManifest(videoId);
  // var video = await yt.videos.get(videoId);
  var streamInfo = manifest.audioOnly.withHighestBitrate();
  var stream = yt.videos.streamsClient.get(streamInfo);
  var streamBinary = List<int>.empty(growable: true);
  await for (var data in stream) {
    streamBinary.addAll(data);
  }
  yt.close();
  return streamBinary;
}
