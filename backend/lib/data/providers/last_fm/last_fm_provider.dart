import "package:backend/data/models/base_models.dart";
import "package:backend/data/network/dio/dio_client.dart";

import "../provider.dart";

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

  // @override
  // Future<DetailedArtistModel> getArtist(String url) async {

  // }
}
