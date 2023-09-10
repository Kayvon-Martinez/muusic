import 'dart:io';

import 'package:alfred/alfred.dart';

import 'data/providers/last_fm/last_fm_provider.dart';

dynamic detectSource(String id) {
  switch (id) {
    case 'last_fm':
      return LastFMProvider();
    default:
      return null;
  }
}

Future<void> start(
    String bindIp, int port, int version, String apiString) async {
  final app = Alfred();
  final apiPath = '$apiString/v$version';

  app.get('$apiPath/', (req, res) {
    res.headers.contentType = ContentType.json;
    res.headers.add('Access-Control-Allow-Origin', '*');
    res.json({'message': 'Welcome to the backend'});
  });

  app.get('$apiPath/:id/search/:query', (req, res) async {
    res.headers.contentType = ContentType.json;
    res.headers.add('Access-Control-Allow-Origin', '*');
    var provider = detectSource(req.params['id']);
    if (provider != null) {
      var results = await provider.search(req.params['query']);
      res.json(results.toJson());
    } else {
      res.json({'error': 'Provider not found'});
    }
  });

  app.post('$apiPath/:id/details/artist', (req, res) async {
    res.headers.contentType = ContentType.json;
    res.headers.add('Access-Control-Allow-Origin', '*');
    var provider = detectSource(req.params['id']);
    var body = await req.bodyAsJsonMap;
    if (body['url'] == null) {
      res.json({'error': 'No url provided'});
      return;
    }
    if (provider != null) {
      var results = await provider.getArtist(body['url']);
      res.json(results.toJson());
    } else {
      res.json({'error': 'Provider not found'});
    }
  });

  app.post("$apiPath/:id/details/album", (req, res) async {
    res.headers.contentType = ContentType.json;
    res.headers.add('Access-Control-Allow-Origin', '*');
    var provider = detectSource(req.params['id']);
    var body = await req.bodyAsJsonMap;
    if (body['url'] == null) {
      res.json({'error': 'No url provided'});
      return;
    }
    if (provider != null) {
      var results = await provider.getAlbum(body['url']);
      res.json(results.toJson());
    } else {
      res.json({'error': 'Provider not found'});
    }
  });

  app.post("$apiPath/:id/details/track", (req, res) async {
    res.headers.contentType = ContentType.json;
    res.headers.add('Access-Control-Allow-Origin', '*');
    var provider = detectSource(req.params['id']);
    var body = await req.bodyAsJsonMap;
    if (body['url'] == null) {
      res.json({'error': 'No url provided'});
      return;
    }
    if (provider != null) {
      var results = await provider.getTrack(body['url']);
      res.json(results.toJson());
    } else {
      res.json({'error': 'Provider not found'});
    }
  });

  await app.listen(
    port,
    bindIp,
  );
}
