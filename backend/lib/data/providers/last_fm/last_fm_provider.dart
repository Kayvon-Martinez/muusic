import 'package:backend/core/utils/date_helpers.dart';
import "package:backend/core/values/regex_patterns.dart";
import "package:backend/data/models/base_models.dart";
import "package:backend/data/network/dio/dio_client.dart";

import 'package:beautiful_soup_dart/beautiful_soup.dart';

import "../provider.dart";

class LastFMProvider implements Provider {
  @override
  String get id => "last_fm";

  @override
  String get name => "Last.fm";

  @override
  String get baseUrl => "https://www.last.fm";

  @override
  String get description =>
      "Last.fm was founded in 2002 by Felix Miller, Martin Stiksel, Michael Breidenbruecker and Thomas Willomitzer, all of them from Germany or Austria, as an Internet radio station and music community site, using similar music profiles to generate dynamic playlists.";

  BaseArtistModel _parseArtistSquare(Bs4Element element) {
    var name =
        element.find("p.grid-items-item-main-text > a")?.text ?? "Unknown";
    var url = baseUrl +
        element
            .find("p.grid-items-item-main-text > a")!
            .attributes["href"]!
            .trim();
    var imageUrl = element
        .find("div.grid-items-cover-image-image > img")!
        .attributes["src"]!
        .trim();
    var listenters = int.tryParse(element
            .find("p.grid-items-item-aux-text")
            ?.text
            .replaceFirst("listeners", "")
            .trim()
            .replaceAll(",", "") ??
        "fail");
    return BaseArtistModel(
      name: name,
      url: url,
      imageUrl: imageUrl,
      listeners: listenters,
    );
  }

  BaseAlbumModel _parseAlbumSquare(Bs4Element element) {
    var name =
        element.find("p.grid-items-item-main-text > a")?.text ?? "Unknown";
    var url = baseUrl +
        element
            .find("p.grid-items-item-main-text > a")!
            .attributes["href"]!
            .trim();
    var imageUrl = element
        .find("div.grid-items-cover-image-image > img")!
        .attributes["src"]!
        .trim();
    var artistName = element.find("p.grid-items-item-aux-text > a")!.text;
    var artistUrl = baseUrl +
        element
            .find("p.grid-items-item-aux-text > a")!
            .attributes["href"]!
            .trim();
    return BaseAlbumModel(
      name: name,
      url: url,
      imageUrl: imageUrl,
      artistName: artistName,
      artistUrl: artistUrl,
    );
  }

  BaseTrackModel _parseTrackSquare(Bs4Element element) {
    var name = element.find("td.chartlist-name > a")?.text ?? "Unknown";
    var url = baseUrl +
        element.find("td.chartlist-artist > a")!.attributes["href"]!.trim();
    var artistUrl = baseUrl +
        element.find("td.chartlist-artist > a")!.attributes["href"]!.trim();
    var sourceUrl =
        element.find("td.chartlist-play > a")?.attributes["href"]?.trim();
    String extractorUrl = "/api/v1/last_fm/extractor";
    RawSongSource? source = sourceUrl != null
        ? RawSongSource(
            url: sourceUrl,
            extractorUrl: extractorUrl,
          )
        : null;
    var imageUrl = element.find(".cover-art > img")!.attributes["src"]!.trim();
    var artistName = element.find("td.chartlist-artist > a")!.text;
    var albumName =
        element.find("a.cover-art > img")?.attributes["alt"]?.trim();
    return BaseTrackModel(
      name: name,
      url: url,
      artistUrl: artistUrl,
      source: source,
      imageUrl: imageUrl,
      artistName: artistName,
      albumName: albumName,
    );
  }

  @override
  Future<SearchResultsModel> search(String query) async {
    var response = await DioClient().client.get(
      "$baseUrl/search",
      queryParameters: {"q": Uri.encodeComponent(query)},
    );
    var soup = BeautifulSoup(response.data);
    var rawSections = soup.findAll(".col-main > section");
    var rawArtists = rawSections.firstWhere((element) =>
        element.find("h2")?.text.trim().toLowerCase() == "artists");
    var rawAlbums = rawSections.firstWhere(
        (element) => element.find("h2")?.text.trim().toLowerCase() == "albums");
    var rawTracks = rawSections.firstWhere(
        (element) => element.find("h2")?.text.trim().toLowerCase() == "tracks");
    List<BaseArtistModel> artists = [];
    List<BaseAlbumModel> albums = [];
    List<BaseTrackModel> tracks = [];
    rawArtists.findAll("li.grid-items-item").forEach((element) {
      artists.add(_parseArtistSquare(element));
    });
    rawAlbums.findAll("li.grid-items-item").forEach((element) {
      albums.add(_parseAlbumSquare(element));
    });
    rawTracks.findAll("tr.chartlist-row").forEach((element) {
      tracks.add(_parseTrackSquare(element));
    });
    return SearchResultsModel(
      artists: artists,
      albums: albums,
      tracks: tracks,
    );
  }

  BaseArtistModel _parseSimilarArtist(Bs4Element element) {
    var name = element.find("a.link-block-target")?.text ?? "Unknown";
    var url = baseUrl +
        element.find("a.link-block-target")!.attributes["href"]!.trim();
    var imageUrl = element.find(".avatar > img")!.attributes["src"]!.trim();
    var listeners = int.tryParse(element
            .find(
                "p.catalogue-overview-similar-artists-full-width-item-aux-text")
            ?.text
            .replaceFirst("listeners", "")
            .trim()
            .replaceAll(",", "") ??
        "fail");
    return BaseArtistModel(
      name: name,
      url: url,
      imageUrl: imageUrl,
      listeners: listeners,
    );
  }

  TagModel _parseTagBox(Bs4Element element) {
    var name = element.find("a")?.text.trim() ?? "Unknown";
    var url = baseUrl + element.find("a")!.attributes["href"]!.trim();
    return TagModel(
      name: name,
      url: url,
    );
  }

  BaseTrackModel _parseTrackSquareDetailScreen(
      Bs4Element element, String artistUrl, String artistName) {
    var name = element.find("td.chartlist-name > a")?.text ?? "Unknown";
    var url = baseUrl +
        element.find("td.chartlist-name > a")!.attributes["href"]!.trim();
    var sourceUrl =
        element.find("td.chartlist-play > a")?.attributes["href"]?.trim();
    String extractorUrl = "/api/v1/last_fm/extractor";
    RawSongSource? source = sourceUrl != null
        ? RawSongSource(
            url: sourceUrl,
            extractorUrl: extractorUrl,
          )
        : null;
    var imageUrl = element.find(".cover-art > img")!.attributes["src"]!.trim();
    var albumName =
        element.find("a.cover-art > img")?.attributes["alt"]?.trim();
    var listeners = int.tryParse(element
            .find("span.chartlist-count-bar-value")
            ?.text
            .replaceAll(",", "")
            .replaceFirst("listeners", "")
            .trim() ??
        "fail");
    return BaseTrackModel(
      name: name,
      url: url,
      artistUrl: artistUrl,
      source: source,
      imageUrl: imageUrl,
      artistName: artistName,
      albumName: albumName,
      listeners: listeners,
    );
  }

  BaseAlbumModel _parseAlbumSquareDetailScreen(
      Bs4Element element, String artistUrl, String artistName) {
    var name =
        element.find("h3.artist-top-albums-item-name > a")?.text ?? "Unknown";
    var url = baseUrl +
        element
            .find("h3.artist-top-albums-item-name > a")!
            .attributes["href"]!
            .trim();
    var imageUrl = element.find(".cover-art > img")!.attributes["src"]!.trim();
    var listeners = int.tryParse(element
            .find("p.artist-top-albums-item-listeners")
            ?.text
            .replaceAll(",", "")
            .replaceFirst("listeners", "")
            .trim() ??
        "fail");
    var releaseDateAndNumberOfTracksRaw = element
        .findAll("p.artist-top-albums-item-aux-text")
        .last
        .text
        .split("·");
    DateTime? releaseDate;
    int? numberOfTracks;
    if (releaseDateAndNumberOfTracksRaw.length == 2) {
      releaseDate =
          dateStringSpacesToDateTime(releaseDateAndNumberOfTracksRaw[0].trim());
      numberOfTracks = int.tryParse(releaseDateAndNumberOfTracksRaw[1]
              .replaceFirst("track", "")
              .trim()) ??
          0;
    } else if (releaseDateAndNumberOfTracksRaw[0].contains("track")) {
      numberOfTracks = int.tryParse(releaseDateAndNumberOfTracksRaw[0]
              .trim()
              .replaceFirst("tracks", "")
              .replaceFirst("track", "")
              .trim()) ??
          0;
    } else {
      releaseDate =
          dateStringSpacesToDateTime(releaseDateAndNumberOfTracksRaw[0].trim());
    }
    return BaseAlbumModel(
      name: name,
      url: url,
      artistUrl: artistUrl,
      imageUrl: imageUrl,
      artistName: artistName,
      listeners: listeners,
      releaseDate: releaseDate,
      numberOfTracks: numberOfTracks,
    );
  }

  @override
  Future<DetailedArtistModel> getArtist(String url) async {
    var response = await DioClient().client.get(Uri.decodeComponent(url));
    var soup = BeautifulSoup(response.data);
    var name = soup.find(".header-new-title")?.text ?? "Unknown";
    var imageUrl = bgImageUrlRegExp
            .firstMatch(soup
                    .find(".header-new-background-image")
                    ?.attributes["style"]
                    ?.trim() ??
                "")
            ?.group(1) ??
        "";
    var listeners = int.tryParse(soup
                .find("abbr.js-abbreviated-counter")
                ?.attributes["title"]
                ?.replaceAll(",", "") ??
            "fail") ??
        0;
    var isTouring = soup.find(".header-new-on-tour") != null;
    var latestReleaseAndPopularRaw =
        soup.findAll("li.artist-header-featured-items-item-wrap");
    Bs4Element latestReleaseRaw = latestReleaseAndPopularRaw.firstWhere(
        (element) =>
            element.find("div > h4")?.text.trim().toLowerCase() ==
            "latest release");
    BaseAlbumModel? latestRelease = latestReleaseRaw.find("div") != null
        ? BaseAlbumModel(
            name: latestReleaseRaw.find("div > h3 > a")!.text.trim(),
            url: baseUrl +
                latestReleaseRaw
                    .find("div > h3 > a")!
                    .attributes["href"]!
                    .trim(),
            artistUrl: url,
            imageUrl: latestReleaseRaw
                .find("div .cover-art > img")!
                .attributes["src"]!
                .trim(),
            artistName: name,
          )
        : null;
    Bs4Element popularThisWeekRaw = latestReleaseAndPopularRaw.firstWhere(
        (element) =>
            element.find("div > h4")?.text.trim().toLowerCase() ==
            "popular this week");
    BaseTrackModel? popularThisWeek = popularThisWeekRaw.find("div") != null
        ? BaseTrackModel(
            name: popularThisWeekRaw.find("div > h3 > a")!.text.trim(),
            url: baseUrl +
                popularThisWeekRaw
                    .find("div > h3 > a")!
                    .attributes["href"]!
                    .trim(),
            artistUrl: url,
            source: RawSongSource(
              extractorUrl: "/api/v1/last_fm/extractor",
              url: popularThisWeekRaw
                  .find("div .image-overlay-playlink-link")!
                  .attributes["href"]!
                  .trim(),
            ),
            imageUrl: popularThisWeekRaw
                .find("div .video-preview")!
                .attributes["src"]!
                .trim(),
            artistName: name,
            listeners: int.tryParse(popularThisWeekRaw
                    .find(".artist-header-featured-items-item-listeners")!
                    .text
                    .replaceAll(",", "")
                    .replaceFirst("listeners", "")
                    .trim()) ??
                0,
          )
        : null;
    List<BaseArtistModel> similarArtists = [];
    for (var element in soup
        .findAll(".catalogue-overview-similar-artists-full-width > li > div")) {
      similarArtists.add(_parseSimilarArtist(element));
    }
    var bio = soup
        .findAll("div.wiki-block")
        .last
        .text
        .replaceFirst("read more", "")
        .replaceAll("\n", "")
        .replaceAll("\t", "")
        .replaceAll("\r", "")
        .replaceAll('\\"', "")
        .replaceFirst("View wiki", "")
        .replaceAll("  ", " ")
        .trim();
    var whenAndWheresRaw = soup.findAll("dd.catalogue-metadata-description");
    DateTime? bornWhen;
    String? bornWhere;
    DateTime? diedWhen;
    if (whenAndWheresRaw.length >= 2) {
      bornWhen = dateStringSpacesToDateTime(
          whenAndWheresRaw[0].text.trim().split("(")[0]);
      bornWhere = whenAndWheresRaw[1].text.trim();
      if (whenAndWheresRaw.length == 3) {
        diedWhen = dateStringSpacesToDateTime(
            whenAndWheresRaw[2].text.trim().split("(")[0]);
      }
    }
    List<TagModel> tags = [];
    for (var element in soup.find("ul.tags-list")!.findAll("li")) {
      tags.add(_parseTagBox(element));
    }
    List<BaseTrackModel> topTracks = [];
    for (var element in soup.findAll("tr.chartlist-row")) {
      topTracks.add(_parseTrackSquareDetailScreen(element, url, name));
    }
    var allTracksUrl = baseUrl +
        soup
            .find(".more-link-fullwidth--no-border > a")!
            .attributes["href"]!
            .trim();
    List<String> photoUrls = [];
    for (var element
        in soup.findAll("ul.sidebar-image-list").last.findAll("img")) {
      photoUrls.add(baseUrl + element.attributes["src"]!.trim());
    }
    String? morePhotosUrl = soup
                .findAll("p.more-link-with-action > a")
                .last
                .attributes["href"]
                ?.trim() !=
            null
        ? baseUrl +
            soup
                .findAll("p.more-link-with-action > a")
                .last
                .attributes["href"]!
                .trim()
        : null;
    List<BaseAlbumModel> albums = [];
    for (var element in soup.findAll("li.artist-top-albums-item-wrap > div")) {
      albums.add(_parseAlbumSquareDetailScreen(element, url, name));
    }
    List<ExternalLinksModel> externalLinks = [];
    for (var element
        in soup.find("ul.resource-external-links")!.findAll("li > a")) {
      externalLinks.add(ExternalLinksModel(
        type: element.text.split("(")[0].trim().externalLinksType,
        url: element.attributes["href"]!.trim(),
      ));
    }
    var eventsUrl = soup
                .findAll(
                    "section.section-with-control > div > p.more-link-with-action")
                .last
                .findAll("a")
                .last
                .attributes["href"]
                ?.trim() !=
            null
        ? baseUrl +
            soup
                .findAll(
                    "section.section-with-control > div > p.more-link-with-action")
                .last
                .findAll("a")
                .last
                .attributes["href"]!
                .trim()
        : null;
    return DetailedArtistModel(
      name: name,
      url: url,
      imageUrl: imageUrl,
      listeners: listeners,
      isTouring: isTouring,
      latestRelease: latestRelease,
      popularThisWeek: popularThisWeek,
      similarArtists: similarArtists,
      bio: bio,
      bornWhen: bornWhen,
      bornWhere: bornWhere,
      diedWhen: diedWhen,
      tags: tags,
      topTracks: topTracks,
      allTracksUrl: allTracksUrl,
      photoUrls: photoUrls,
      morePhotosUrl: morePhotosUrl,
      albums: albums,
      externalLinks: externalLinks,
      eventsUrl: eventsUrl,
    );
  }

  BaseTrackModel _parseAlbumPageTrackListItem(Bs4Element element,
      String artistUrl, String imageUrl, String artistName, String albumName) {
    var name = element.find("td.chartlist-name > a")?.text ?? "Unknown";
    var number =
        int.tryParse(element.find("td.chartlist-index")?.text.trim() ?? "fail");
    Duration? duration = durationStringColonsToDuration(
        element.find("td.chartlist-duration")?.text.trim());
    var url = baseUrl +
        element.find("td.chartlist-name > a")!.attributes["href"]!.trim();
    var sourceUrl =
        element.find("td.chartlist-play > a")?.attributes["href"]?.trim();
    String extractorUrl = "/api/v1/last_fm/extractor";
    RawSongSource? source = sourceUrl != null
        ? RawSongSource(
            url: sourceUrl,
            extractorUrl: extractorUrl,
          )
        : null;
    var listeners = int.tryParse(element
            .find("span.chartlist-count-bar-value")
            ?.text
            .replaceAll(",", "")
            .replaceFirst("listeners", "")
            .trim() ??
        "fail");
    return BaseTrackModel(
      name: name,
      url: url,
      artistUrl: artistUrl,
      source: source,
      imageUrl: imageUrl,
      artistName: artistName,
      albumName: albumName,
      listeners: listeners,
      number: number,
      duration: duration,
    );
  }

  BaseAlbumModel _parseAlbumPageSimilarAlbumSquare(Bs4Element element) {
    var name = element.find("a.link-block-target")?.text.trim() ?? "Unknown";
    var url = baseUrl +
        element.find("a.link-block-target")!.attributes["href"]!.trim();
    var artistUrl =
        url.split("/").sublist(0, url.split("/").length - 1).join("/");
    var imageUrl = element.find(".cover-art > img")!.attributes["src"]!.trim();
    var artistName = element
        .find("span", attrs: {"itemprop": "name"})!
        .find("a")!
        .text
        .trim();
    var listeners = int.tryParse(element
            .find("p.similar-albums-item-listeners")
            ?.text
            .replaceFirst("listeners", "")
            .trim()
            .replaceAll(",", "") ??
        "fail");
    return BaseAlbumModel(
      name: name,
      url: url,
      artistUrl: artistUrl,
      imageUrl: imageUrl,
      artistName: artistName,
      listeners: listeners,
    );
  }

  @override
  Future<DetailedAlbumModel> getAlbum(String url) async {
    var response = await DioClient().client.get(Uri.decodeComponent(url));
    var soup = BeautifulSoup(response.data);
    var name = soup.find(".header-new-title")?.text ?? "Unknown";
    var artistUrl =
        baseUrl + soup.find("a.header-new-crumb")!.attributes["href"]!;
    var imageUrl = soup.find("a.cover-art > img")!.attributes["src"]!.trim();
    var artistName = soup.find(".header-new-crumb > span")?.text ?? "Unknown";
    var listeners = int.tryParse(soup
                .find(".header-metadata-tnew-display > p > abbr")
                ?.attributes["title"]
                ?.replaceAll(",", "")
                .trim() ??
            "fail") ??
        0;
    var releaseDate = dateStringSpacesToDateTime(
        soup.findAll("div.metadata-column > dl > dd").last.text.trim());
    var numberOfTracks = int.tryParse(soup
            .findAll("div.metadata-column > dl > dd")[
                soup.findAll("div.metadata-column > dl > dd").length - 2]
            .text
            .split("track")[0]
            .trim()) ??
        0;
    var description = soup
        .findAll("div.wiki-block")
        .last
        .text
        .replaceFirst("read more", "")
        .replaceAll("\n", "")
        .replaceAll("\t", "")
        .replaceAll("\r", "")
        .replaceAll('\\"', "")
        .replaceFirst("View wiki", "")
        .replaceAll("  ", " ")
        .trim();
    Duration duration = durationStringColonsToDuration(soup
        .findAll("div.metadata-column > dl > dd")[
            soup.findAll("div.metadata-column > dl > dd").length - 2]
        .text
        .split(",")[1]
        .trim());
    List<BaseTrackModel> tracks = [];
    for (var element in soup.findAll("tr.chartlist-row")) {
      tracks.add(_parseAlbumPageTrackListItem(
          element, artistUrl, imageUrl, artistName, name));
    }
    List<TagModel> tags = [];
    for (var element in soup.find("ul.tags-list")!.findAll("li")) {
      tags.add(_parseTagBox(element));
    }
    List<BaseAlbumModel> similarAlbums = [];
    for (var element in soup.findAll(
        "ol.similar-albums--with-12 > li.similar-albums-item-wrap > div")) {
      similarAlbums.add(_parseAlbumPageSimilarAlbumSquare(element));
    }
    List<ExternalLinksModel> externalLinks = [];
    for (var element
        in soup.find("ul.resource-external-links")!.findAll("li > a")) {
      externalLinks.add(ExternalLinksModel(
        type: element.text.split("(")[0].trim().externalLinksType,
        url: element.attributes["href"]!.trim(),
      ));
    }
    return DetailedAlbumModel(
      name: name,
      url: url,
      artistName: artistName,
      listeners: listeners,
      releaseDate: releaseDate,
      duration: duration,
      tracks: tracks,
      tags: tags,
      similarAlbums: similarAlbums,
      externalLinks: externalLinks,
      imageUrl: imageUrl,
      artistUrl: artistUrl,
      description: description,
      numberOfTracks: numberOfTracks,
    );
  }

  BaseAlbumModel _parseTrackPageSimilarAlbumSquare(Bs4Element element) {
    var name = element.find("a.link-block-target")?.text.trim() ?? "Unknown";
    var url = baseUrl +
        element.find("a.link-block-target")!.attributes["href"]!.trim();
    var artistUrl =
        url.split("/").sublist(0, url.split("/").length - 1).join("/");
    var imageUrl = element.find(".cover-art > img")!.attributes["src"]!.trim();
    var artistName = element
        .find("span", attrs: {"itemprop": "name"})!
        .find("a")!
        .text
        .trim();
    var listeners = int.tryParse(element
            .find("p.similar-albums-item-listeners")
            ?.text
            .replaceFirst("listeners", "")
            .trim()
            .replaceAll(",", "") ??
        "fail");
    return BaseAlbumModel(
      name: name,
      url: url,
      artistUrl: artistUrl,
      imageUrl: imageUrl,
      artistName: artistName,
      listeners: listeners,
    );
  }

  BaseTrackModel _parseTrackPageSimilarTrackSquare(Bs4Element element) {
    var name = element.find("a.link-block-target")?.text.trim() ?? "Unknown";
    var url = baseUrl +
        element.find("a.link-block-target")!.attributes["href"]!.trim();
    var artistUrl = baseUrl +
        element
            .find("span", attrs: {"itemprop": "name"})!
            .find("a")!
            .attributes["href"]!
            .trim();
    var sourceUrl = element
        .find("a.track-similar-tracks-item-playlink")
        ?.attributes["href"]
        ?.trim();
    String extractorUrl = "/api/v1/last_fm/extractor";
    RawSongSource? source = sourceUrl != null
        ? RawSongSource(
            url: sourceUrl,
            extractorUrl: extractorUrl,
          )
        : null;
    var imageUrl = element.find(".cover-art > img")!.attributes["src"]!.trim();
    var artistName = element
        .find("span", attrs: {"itemprop": "name"})!
        .find("a")!
        .text
        .trim();
    return BaseTrackModel(
      name: name,
      url: url,
      artistUrl: artistUrl,
      source: source,
      imageUrl: imageUrl,
      artistName: artistName,
    );
  }

  BaseArtistModel _parseTrackPageSimilarArtist(Bs4Element element) {
    var name = element.find("a.link-block-target")?.text ?? "Unknown";
    var url = baseUrl +
        element.find("a.link-block-target")!.attributes["href"]!.trim();
    var imageUrl = element.find(".avatar > img")!.attributes["src"]!.trim();
    var listeners = int.tryParse(element
            .find("p.catalogue-overview-similar-artists-item-listeners")
            ?.text
            .replaceFirst("listeners", "")
            .trim()
            .replaceAll(",", "") ??
        "fail");
    return BaseArtistModel(
      name: name,
      url: url,
      imageUrl: imageUrl,
      listeners: listeners,
    );
  }

  @override
  Future<DetailedTrackModel> getTrack(String url) async {
    var response = await DioClient().client.get(Uri.decodeComponent(url));
    var soup = BeautifulSoup(response.data);
    var name = soup.find(".header-new-title")?.text ?? "Unknown";
    Duration? duration = durationStringColonsToDuration(
        soup.find("dl.catalogue-metadata > dd")?.text.trim());
    var artistUrl =
        url.split("/").sublist(0, url.split("/").length - 2).join("/");
    var sourceUrl =
        soup.find("a.header-new-playlink")?.attributes["href"]?.trim();
    String extractorUrl = "/api/v1/last_fm/extractor";
    RawSongSource? source = sourceUrl != null
        ? RawSongSource(
            url: sourceUrl,
            extractorUrl: extractorUrl,
          )
        : null;
    // var imageUrl = soup.find("img.video-preview")?.attributes["src"]?.trim();
    String imageUrl = "";
    var artistName =
        soup.find("span", attrs: {"itemprop": "name"})?.text ?? "Unknown";
    String? albumName;
    var listeners = int.tryParse(soup
                .find(".header-metadata-tnew-display > p > abbr")
                ?.attributes["title"]
                ?.replaceAll(",", "")
                .trim() ??
            "fail") ??
        0;
    var description = soup
        .find(
            "div.wiki-block > div.wiki-block-inner > div.wiki-truncate-4-lines")!
        .text
        .replaceFirst("read more", "")
        .replaceAll("\n", "")
        .replaceAll("\t", "")
        .replaceAll("\r", "")
        .replaceAll('\\"', "")
        .replaceFirst("View wiki", "")
        .replaceAll("  ", " ")
        .trim();
    List<TagModel> tags = [];
    for (var element in soup.find("ul.tags-list")!.findAll("li")) {
      tags.add(_parseTagBox(element));
    }
    String? lyricsUrl = soup
                .find("dd.catalogue-metadata-description > p > a")
                ?.attributes["href"]
                ?.trim() !=
            null
        ? baseUrl +
            soup
                .find("dd.catalogue-metadata-description > p > a")!
                .attributes["href"]!
                .trim()
        : null;
    List<BaseAlbumModel> featuredOnAlbums = [];
    for (var element in soup.findAll("div.album-and-lyrics-row > section")) {
      featuredOnAlbums.add(_parseTrackPageSimilarAlbumSquare(element));
    }
    imageUrl = featuredOnAlbums.first.imageUrl;
    albumName = featuredOnAlbums.first.name;
    List<BaseTrackModel> similarTracks = [];
    for (var element
        in soup.findAll("ol.track-similar-tracks--with-6 > li > div")) {
      similarTracks.add(_parseTrackPageSimilarTrackSquare(element));
    }
    List<ExternalLinksModel> playLinks = [];
    for (var element
        in soup.findAll("ul.play-this-track-playlinks").last.findAll("li")) {
      playLinks.add(ExternalLinksModel(
        type: element.find("a")!.text.split("(")[0].trim().externalLinksType,
        url: element.find("a")!.attributes["href"]!.trim(),
      ));
    }
    List<ExternalLinksModel> externalLinks = [];
    for (var element
        in soup.find("ul.resource-external-links")!.findAll("li > a")) {
      externalLinks.add(ExternalLinksModel(
        type: element.text.split("(")[0].trim().externalLinksType,
        url: element.attributes["href"]!.trim(),
      ));
    }
    List<BaseArtistModel> similarArtists = [];
    for (var element in soup.findAll(
        "ol.catalogue-overview-similar-artists--with-6 > li.catalogue-overview-similar-artists-item-wrap > div")) {
      similarArtists.add(_parseTrackPageSimilarArtist(element));
    }
    return DetailedTrackModel(
      name: name,
      url: url,
      artistName: artistName,
      listeners: listeners,
      duration: duration,
      source: source,
      imageUrl: imageUrl,
      artistUrl: artistUrl,
      albumName: albumName,
      description: description,
      tags: tags,
      lyricsUrl: lyricsUrl,
      featuredOnAlbums: featuredOnAlbums,
      similarTracks: similarTracks,
      playLinks: playLinks,
      externalLinks: externalLinks,
      similarArtists: similarArtists,
    );
  }

  @override
  Future<TagPageModel> getTag(String url) async {
    throw UnimplementedError();
  }

  @override
  Future<List<BaseArtistModel>> getTagArtists(String url) async {
    throw UnimplementedError();
  }

  @override
  Future<List<BaseAlbumModel>> getTagAlbums(String url) async {
    throw UnimplementedError();
  }

  @override
  Future<List<BaseTrackModel>> getTagTracks(String url) async {
    throw UnimplementedError();
  }

  @override
  Future<List<EventModel>> getEvents(String url) async {
    throw UnimplementedError();
  }

  @override
  Future<String> extractor(String url) async {
    throw UnimplementedError();
  }
}
