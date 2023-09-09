import "package:backend/core/utils/last_fm_birth_date_helper.dart";
import "package:backend/core/values/regex_patterns.dart";
import "package:backend/data/models/base_models.dart";
import "package:backend/data/network/dio/dio_client.dart";

// import "../provider.dart";

import 'package:beautiful_soup_dart/beautiful_soup.dart';

class LastFMProvider {
  // implements Provider {
  // @override
  String get id => "last_fm";

  // @override
  String get name => "Last.fm";

  // @override
  String get baseUrl => "https://www.last.fm";

  // @override
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
        element.find("td.chartlist-name > a")!.attributes["href"]!.trim();
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

  // @override
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
          lastFMBirthDateToDateTime(releaseDateAndNumberOfTracksRaw[0].trim());
      numberOfTracks = int.tryParse(releaseDateAndNumberOfTracksRaw[1]
              .trim()
              .replaceFirst("tracks", "")
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
          lastFMBirthDateToDateTime(releaseDateAndNumberOfTracksRaw[0].trim());
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

  // @override
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
      bornWhen = lastFMBirthDateToDateTime(
          whenAndWheresRaw[0].text.trim().split("(")[0]);
      bornWhere = whenAndWheresRaw[1].text.trim();
      if (whenAndWheresRaw.length == 3) {
        diedWhen = lastFMBirthDateToDateTime(
            whenAndWheresRaw[2].text.trim().split("(")[0]);
      }
    }
    List<TagModel> tags = [];
    for (var element in soup.findAll(".tags-list > li")) {
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
    for (var element in soup.findAll("ul.resource-external-links > li > a")) {
      externalLinks.add(ExternalLinksModel(
        type: element.text.trim().externalLinksType,
        url: element.attributes["href"]!.trim(),
      ));
    }
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
    );
  }
}
