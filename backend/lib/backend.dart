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
    res.json({'message': 'Welcome to the Muusic backend'});
  });

  app.get('$apiPath/:id/search/:query', (req, res) async {
    res.headers.contentType = ContentType.json;
    res.headers.add('Access-Control-Allow-Origin', '*');
    var provider = detectSource(req.params['id']);
    try {
      if (provider != null) {
        var results = await provider.search(req.params['query']);
        res.json(results.toJson());
      } else {
        res.json({'error': 'Provider not found'});
      }
    } catch (e) {
      res.statusCode = 500;
      res.json({'error': e.toString()});
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
    try {
      if (provider != null) {
        var results = await provider.getArtist(body['url']);
        res.json(results.toJson());
      } else {
        res.json({'error': 'Provider not found'});
      }
    } catch (e) {
      res.statusCode = 500;
      res.json({'error': e.toString()});
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
    try {
      if (provider != null) {
        var results = await provider.getAlbum(body['url']);
        res.json(results.toJson());
      } else {
        res.json({'error': 'Provider not found'});
      }
    } catch (e) {
      res.statusCode = 500;
      res.json({'error': e.toString()});
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
    // try {
    if (provider != null) {
      var results = await provider.getTrack(body['url']);
      res.json(results.toJson());
    } else {
      res.json({'error': 'Provider not found'});
    }
    // } catch (e) {
    //   res.statusCode = 500;
    //   res.json({'error': e.toString()});
    // }
  });

  app.post("$apiPath/:id/details/tag", (req, res) async {
    res.headers.contentType = ContentType.json;
    res.headers.add('Access-Control-Allow-Origin', '*');
    var provider = detectSource(req.params['id']);
    var body = await req.bodyAsJsonMap;
    if (body['url'] == null) {
      res.json({'error': 'No url provided'});
      return;
    }
    try {
      if (provider != null) {
        var results = await provider.getTag(body['url']);
        res.json(results.toJson());
      } else {
        res.json({'error': 'Provider not found'});
      }
    } catch (e) {
      res.statusCode = 500;
      res.json({'error': e.toString()});
    }
  });

  app.post("$apiPath/:id/tag/artists", (req, res) async {
    res.headers.contentType = ContentType.json;
    res.headers.add('Access-Control-Allow-Origin', '*');
    var provider = detectSource(req.params['id']);
    var body = await req.bodyAsJsonMap;
    if (body['url'] == null) {
      res.json({'error': 'No url provided'});
      return;
    }
    try {
      if (provider != null) {
        var results = await provider.getTagArtists(body['url'], body['page']);
        res.json(results.toJson());
      } else {
        res.json({'error': 'Provider not found'});
      }
    } catch (e) {
      res.statusCode = 500;
      res.json({'error': e.toString()});
    }
  });

  app.post("$apiPath/:id/tag/albums", (req, res) async {
    res.headers.contentType = ContentType.json;
    res.headers.add('Access-Control-Allow-Origin', '*');
    var provider = detectSource(req.params['id']);
    var body = await req.bodyAsJsonMap;
    if (body['url'] == null) {
      res.json({'error': 'No url provided'});
      return;
    }
    try {
      if (provider != null) {
        var results = await provider.getTagAlbums(body['url'], body['page']);
        res.json(results.toJson());
      } else {
        res.json({'error': 'Provider not found'});
      }
    } catch (e) {
      res.statusCode = 500;
      res.json({'error': e.toString()});
    }
  });

  app.post("$apiPath/:id/tag/tracks", (req, res) async {
    res.headers.contentType = ContentType.json;
    res.headers.add('Access-Control-Allow-Origin', '*');
    var provider = detectSource(req.params['id']);
    var body = await req.bodyAsJsonMap;
    if (body['url'] == null) {
      res.json({'error': 'No url provided'});
      return;
    }
    try {
      if (provider != null) {
        var results = await provider.getTagTracks(body['url'], body['page']);
        res.json(results.toJson());
      } else {
        res.json({'error': 'Provider not found'});
      }
    } catch (e) {
      res.statusCode = 500;
      res.json({'error': e.toString()});
    }
  });

  app.post("$apiPath/:id/lyrics", (req, res) async {
    res.headers.contentType = ContentType.json;
    res.headers.add('Access-Control-Allow-Origin', '*');
    var provider = detectSource(req.params['id']);
    var body = await req.bodyAsJsonMap;
    if (body['url'] == null) {
      res.json({'error': 'No url provided'});
      return;
    }
    try {
      if (provider != null) {
        var results = await provider.getLyrics(body['url']);
        res.json({'lyrics': results});
      } else {
        res.json({'error': 'Provider not found'});
      }
    } catch (e) {
      res.statusCode = 500;
      res.json({'error': e.toString()});
    }
  });

  app.post("$apiPath/:id/events", (req, res) async {
    res.headers.contentType = ContentType.json;
    res.headers.add('Access-Control-Allow-Origin', '*');
    var body = await req.bodyAsJsonMap;
    var provider = detectSource(req.params['id']);
    if (body['url'] == null) {
      res.json({'error': 'No url provided'});
      return;
    }
    try {
      if (provider != null) {
        var results = await provider.getEvents(body['url']);
        res.json(results.map((e) => e.toJson()).toList());
      } else {
        res.json({'error': 'Provider not found'});
      }
    } catch (e) {
      res.statusCode = 500;
      res.json({'error': e.toString()});
    }
  });

  app.post("$apiPath/:id/extractor", (req, res) async {
    res.headers.contentType = ContentType.binary;
    res.headers.add('Access-Control-Allow-Origin', '*');
    var body = await req.bodyAsJsonMap;
    var provider = detectSource(req.params['id']);
    if (body['url'] == null) {
      res.json({'error': 'No url provided'});
      return null;
    }
    try {
      if (provider != null) {
        var data = await provider.extractor(body['url']) as List<int>;
        res.setDownload(filename: 'audio.webm');
        res.add(data);
      } else {
        res.json({'error': 'Provider not found'});
      }
    } catch (e) {
      res.statusCode = 500;
      res.json({'error': e.toString()});
    }
  });

  await app.listen(
    port,
    bindIp,
  );
}
