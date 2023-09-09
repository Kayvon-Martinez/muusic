import 'package:backend/data/models/base_models.dart';

abstract class Provider {
  String get id;
  String get name;
  String get baseUrl;
  String get description;
  Future<SearchResultsModel> search(String query);
  Future<DetailedArtistModel> getArtist(String url);
  Future<DetailedAlbumModel> getAlbum(String url);
  Future<TagPageModel> getTag(String url);
  Future<List<BaseArtistModel>> getTagArtists(String url);
  Future<List<BaseAlbumModel>> getTagAlbums(String url);
  Future<List<BaseTrackModel>> getTagTracks(String url);
  Future<String> extractor(String url);
}
