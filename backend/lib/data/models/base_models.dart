enum ItemType {
  artist,
  album,
  track,
  tag,
  detailArtist,
  detailAlbum,
  detailTag,
  tagPage,
}

extension ItemTypeExtension on ItemType {
  String get name {
    switch (this) {
      case ItemType.artist:
        return 'Artist';
      case ItemType.album:
        return 'Album';
      case ItemType.track:
        return 'Track';
      case ItemType.tag:
        return 'Tag';
      case ItemType.detailArtist:
        return 'DetailArtist';
      case ItemType.detailAlbum:
        return 'DetailAlbum';
      case ItemType.detailTag:
        return 'DetailTag';
      case ItemType.tagPage:
        return 'TagPage';
    }
  }
}

extension StringExtension on String {
  ItemType get itemType {
    switch (toLowerCase()) {
      case 'artist':
        return ItemType.artist;
      case 'album':
        return ItemType.album;
      case 'track':
        return ItemType.track;
      case 'tag':
        return ItemType.tag;
      case 'detailArtist':
        return ItemType.detailArtist;
      case 'detailAlbum':
        return ItemType.detailAlbum;
      case 'detailTag':
        return ItemType.detailTag;
      case 'tagPage':
        return ItemType.tagPage;
      default:
        return ItemType.artist;
    }
  }
}

class BaseArtistModel {
  final String name;
  final String url;
  final String imageUrl;
  final int? listeners;
  final ItemType itemType;

  BaseArtistModel({
    required this.name,
    required this.url,
    required this.imageUrl,
    this.listeners,
    this.itemType = ItemType.artist,
  });

  factory BaseArtistModel.fromJson(Map<String, dynamic> json) {
    return BaseArtistModel(
      name: json['name'],
      url: json['url'],
      imageUrl: json['imageUrl'],
      listeners: int.tryParse(json['listeners']),
      itemType: json['itemType'].toString().itemType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'imageUrl': imageUrl,
      'listeners': listeners,
      'itemType': itemType.name,
    };
  }
}

class BaseAlbumModel {
  final String name;
  final String url;
  final String artistUrl;
  final String imageUrl;
  final String artistName;
  final ItemType itemType;
  final int? listeners;
  final DateTime? releaseDate;
  final int? numberOfTracks;

  BaseAlbumModel({
    required this.name,
    required this.url,
    required this.artistUrl,
    required this.imageUrl,
    required this.artistName,
    this.listeners,
    this.releaseDate,
    this.numberOfTracks,
    this.itemType = ItemType.album,
  });

  factory BaseAlbumModel.fromJson(Map<String, dynamic> json) {
    return BaseAlbumModel(
      name: json['name'],
      url: json['url'],
      artistUrl: json['artistUrl'],
      imageUrl: json['imageUrl'],
      artistName: json['artist'],
      listeners: int.tryParse(json['listeners']),
      releaseDate: json['releaseDate'] != null
          ? DateTime.tryParse(json['releaseDate'])
          : null,
      numberOfTracks: int.tryParse(json['numberOfTracks']),
      itemType: json['itemType'].toString().itemType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'artistUrl': artistUrl,
      'imageUrl': imageUrl,
      'artistName': artistName,
      'listeners': listeners,
      'releaseDate': releaseDate?.toIso8601String(),
      'numberOfTracks': numberOfTracks,
      'itemType': itemType.name,
    };
  }
}

class RawSongSource {
  final String url;
  final String extractorUrl;

  RawSongSource({
    required this.url,
    required this.extractorUrl,
  });

  factory RawSongSource.fromJson(Map<String, dynamic> json) {
    return RawSongSource(
      url: json['url'],
      extractorUrl: json['extractor_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'extractorUrl': extractorUrl,
    };
  }
}

class BaseTrackModel {
  final String name;
  final String url;
  final String artistUrl;
  final RawSongSource? source;
  final String imageUrl;
  final String artistName;
  final String? albumName;
  final int? listeners;
  final ItemType itemType;

  BaseTrackModel({
    required this.name,
    required this.url,
    required this.artistUrl,
    this.source,
    required this.imageUrl,
    required this.artistName,
    this.albumName,
    this.listeners,
    this.itemType = ItemType.track,
  });

  factory BaseTrackModel.fromJson(Map<String, dynamic> json) {
    return BaseTrackModel(
      name: json['name'],
      url: json['url'],
      artistUrl: json['artistUrl'],
      source: json['source'] != null
          ? RawSongSource.fromJson(json['source'])
          : null,
      imageUrl: json['imageUrl'],
      artistName: json['artistName'],
      albumName: json['albumName'],
      listeners: int.tryParse(json['listeners']),
      itemType: json['itemType'].toString().itemType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'artistUrl': artistUrl,
      'source': source?.toJson(),
      'imageUrl': imageUrl,
      'artistName': artistName,
      'albumName': albumName,
      'listeners': listeners,
      'itemType': itemType.name,
    };
  }
}

class SearchResultsModel {
  final List<BaseArtistModel>? artists;
  final List<BaseAlbumModel>? albums;
  final List<BaseTrackModel>? tracks;

  SearchResultsModel({
    this.artists,
    this.albums,
    this.tracks,
  });

  factory SearchResultsModel.fromJson(Map<String, dynamic> json) {
    return SearchResultsModel(
      artists: json['artists'] != null
          ? (json['artists'] as List)
              .map((e) => BaseArtistModel.fromJson(e))
              .toList()
          : null,
      albums: json['albums'] != null
          ? (json['albums'] as List)
              .map((e) => BaseAlbumModel.fromJson(e))
              .toList()
          : null,
      tracks: json['tracks'] != null
          ? (json['tracks'] as List)
              .map((e) => BaseTrackModel.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artists': artists?.map((e) => e.toJson()).toList(),
      'albums': albums?.map((e) => e.toJson()).toList(),
      'tracks': tracks?.map((e) => e.toJson()).toList(),
    };
  }
}

class TagModel {
  final String name;
  final String url;
  final ItemType itemType;

  TagModel({
    required this.name,
    required this.url,
    this.itemType = ItemType.tag,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      name: json['name'],
      url: json['url'],
      itemType: json['itemType'].toString().itemType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'itemType': itemType.name,
    };
  }
}

enum ExternalLinksType {
  website,
  twitter,
  facebook,
  soundcloud,
  instagram,
  youtube,
  spotify,
  bandcamp,
  artimage,
}

extension ExternalLinksTypeExtension on ExternalLinksType {
  String get name {
    switch (this) {
      case ExternalLinksType.website:
        return 'Website';
      case ExternalLinksType.twitter:
        return 'Twitter';
      case ExternalLinksType.facebook:
        return 'Facebook';
      case ExternalLinksType.soundcloud:
        return 'SoundCloud';
      case ExternalLinksType.instagram:
        return 'Instagram';
      case ExternalLinksType.youtube:
        return 'YouTube';
      case ExternalLinksType.spotify:
        return 'Spotify';
      case ExternalLinksType.bandcamp:
        return 'Bandcamp';
      case ExternalLinksType.artimage:
        return 'ArtImage';
      default:
        return 'Website';
    }
  }
}

extension ExternalLinksTypeStringExtension on String {
  ExternalLinksType get externalLinksType {
    switch (toLowerCase()) {
      case 'website':
        return ExternalLinksType.website;
      case 'twitter':
        return ExternalLinksType.twitter;
      case 'facebook':
        return ExternalLinksType.facebook;
      case 'soundcloud':
        return ExternalLinksType.soundcloud;
      case 'instagram':
        return ExternalLinksType.instagram;
      case 'youtube':
        return ExternalLinksType.youtube;
      case 'spotify':
        return ExternalLinksType.spotify;
      case 'bandcamp':
        return ExternalLinksType.bandcamp;
      case 'artimage':
        return ExternalLinksType.artimage;
      default:
        return ExternalLinksType.website;
    }
  }
}

class ExternalLinksModel {
  final ExternalLinksType type;
  final String url;

  ExternalLinksModel({
    required this.type,
    required this.url,
  });

  factory ExternalLinksModel.fromJson(Map<String, dynamic> json) {
    return ExternalLinksModel(
      type: ExternalLinksType.values.firstWhere(
        (e) => e.toString() == 'ExternalLinksType.${json['type']}',
      ),
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'url': url,
    };
  }
}

class EventModel {
  final DateTime date;
  final String title;
  final String subtitle;
  final String locationName;
  final String location;

  EventModel({
    required this.date,
    required this.title,
    required this.subtitle,
    required this.locationName,
    required this.location,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      date: DateTime.tryParse(json['date']) ?? DateTime.now(),
      title: json['title'],
      subtitle: json['subtitle'],
      locationName: json['locationName'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'title': title,
      'subtitle': subtitle,
      'locationName': locationName,
      'location': location,
    };
  }
}

class DetailedArtistModel extends BaseArtistModel {
  final bool isTouring;
  final BaseAlbumModel? latestRelease;
  final BaseTrackModel? popularThisWeek;
  final List<BaseArtistModel> similarArtists;
  final String bio;
  final DateTime? bornWhen;
  final String? bornWhere;
  final DateTime? diedWhen;
  final List<TagModel> tags;
  final List<BaseTrackModel> topTracks;
  final String allTracksUrl;
  final List<String> photoUrls;
  final String? morePhotosUrl;
  final List<BaseAlbumModel> albums;
  final List<ExternalLinksModel> externalLinks;
  @override
  final ItemType itemType;

  DetailedArtistModel({
    required this.isTouring,
    required String name,
    required String url,
    required String imageUrl,
    required int? listeners,
    this.latestRelease,
    this.popularThisWeek,
    required this.similarArtists,
    required this.bio,
    this.bornWhen,
    this.bornWhere,
    this.diedWhen,
    required this.tags,
    required this.topTracks,
    required this.allTracksUrl,
    required this.photoUrls,
    this.morePhotosUrl,
    required this.albums,
    required this.externalLinks,
    this.itemType = ItemType.detailArtist,
  }) : super(
          name: name,
          url: url,
          imageUrl: imageUrl,
          listeners: listeners,
        );

  factory DetailedArtistModel.fromJson(Map<String, dynamic> json) {
    return DetailedArtistModel(
      isTouring: json['isTouring'],
      name: json['name'],
      url: json['url'],
      imageUrl: json['imageUrl'],
      listeners: int.tryParse(json['listeners']),
      latestRelease: json['latestRelease'] != null
          ? BaseAlbumModel.fromJson(json['latestRelease'])
          : null,
      popularThisWeek: json['popularThisWeek'] != null
          ? BaseTrackModel.fromJson(json['popularThisWeek'])
          : null,
      similarArtists: (json['similarArtists'] as List)
          .map((e) => BaseArtistModel.fromJson(e))
          .toList(),
      bio: json['bio'],
      bornWhen:
          json['bornWhen'] != null ? DateTime.tryParse(json['bornWhen']) : null,
      bornWhere: json['bornWhere'],
      diedWhen:
          json['diedWhen'] != null ? DateTime.tryParse(json['diedWhen']) : null,
      tags: (json['tags'] as List).map((e) => TagModel.fromJson(e)).toList(),
      topTracks: (json['topTracks'] as List)
          .map((e) => BaseTrackModel.fromJson(e))
          .toList(),
      allTracksUrl: json['allTracksUrl'],
      photoUrls: (json['photoUrls'] as List).cast<String>(),
      morePhotosUrl: json['morePhotosUrl'],
      albums: (json['albums'] as List)
          .map((e) => BaseAlbumModel.fromJson(e))
          .toList(),
      externalLinks: (json['externalLinks'] as List)
          .map((e) => ExternalLinksModel.fromJson(e))
          .toList(),
      itemType: json['itemType'].toString().itemType,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'isTouring': isTouring,
      'name': name,
      'url': url,
      'imageUrl': imageUrl,
      'listeners': listeners,
      'latestRelease': latestRelease?.toJson(),
      'popularThisWeek': popularThisWeek?.toJson(),
      'similarArtists': similarArtists.map((e) => e.toJson()).toList(),
      'bio': bio,
      'bornWhen': bornWhen?.toIso8601String(),
      'bornWhere': bornWhere,
      'diedWhen': diedWhen?.toIso8601String(),
      'tags': tags.map((e) => e.toJson()).toList(),
      'topTracks': topTracks.map((e) => e.toJson()).toList(),
      'allTracksUrl': allTracksUrl,
      'photoUrls': photoUrls,
      'morePhotosUrl': morePhotosUrl,
      'albums': albums.map((e) => e.toJson()).toList(),
      'externalLinks': externalLinks.map((e) => e.toJson()).toList(),
      'itemType': itemType.name,
    };
  }
}

class DetailedAlbumModel extends BaseAlbumModel {
  final String? description;
  final int numberOfTracks;
  final Duration duration;
  final DateTime? releaseDate;
  final List<BaseTrackModel> tracks;
  final List<TagModel> tags;
  final List<BaseAlbumModel> similarAlbums;
  final List<ExternalLinksModel> externalLinks;
  @override
  final ItemType itemType;

  DetailedAlbumModel({
    required String name,
    required String url,
    required String artistUrl,
    required String imageUrl,
    required String artistName,
    this.description,
    required this.numberOfTracks,
    required this.duration,
    this.releaseDate,
    required this.tracks,
    required this.tags,
    required this.similarAlbums,
    required this.externalLinks,
    this.itemType = ItemType.detailAlbum,
  }) : super(
          name: name,
          url: url,
          artistUrl: artistUrl,
          imageUrl: imageUrl,
          artistName: artistName,
        );

  factory DetailedAlbumModel.fromJson(Map<String, dynamic> json) {
    return DetailedAlbumModel(
      name: json['name'],
      url: json['url'],
      artistUrl: json['artistUrl'],
      imageUrl: json['imageUrl'],
      artistName: json['artist'],
      description: json['description'],
      numberOfTracks: int.tryParse(json['numberOfTracks']) ?? 0,
      duration: Duration(seconds: int.tryParse(json['duration']) ?? 0),
      releaseDate: json['releaseDate'] != null
          ? DateTime.tryParse(json['releaseDate'])
          : null,
      tracks: (json['tracks'] as List)
          .map((e) => BaseTrackModel.fromJson(e))
          .toList(),
      tags: (json['tags'] as List).map((e) => TagModel.fromJson(e)).toList(),
      similarAlbums: (json['similarAlbums'] as List)
          .map((e) => BaseAlbumModel.fromJson(e))
          .toList(),
      externalLinks: (json['externalLinks'] as List)
          .map((e) => ExternalLinksModel.fromJson(e))
          .toList(),
      itemType: json['itemType'].toString().itemType,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'artistUrl': artistUrl,
      'imageUrl': imageUrl,
      'artistName': artistName,
      'description': description,
      'numberOfTracks': numberOfTracks,
      'duration': duration.inSeconds,
      'releaseDate': releaseDate?.toIso8601String(),
      'tracks': tracks.map((e) => e.toJson()).toList(),
      'tags': tags.map((e) => e.toJson()).toList(),
      'similarAlbums': similarAlbums.map((e) => e.toJson()).toList(),
      'externalLinks': externalLinks.map((e) => e.toJson()).toList(),
      'itemType': itemType.name,
    };
  }
}

class DetailedTagModel extends TagModel {
  final String imageUrl;
  @override
  final ItemType itemType;

  DetailedTagModel({
    required String name,
    required String url,
    required this.imageUrl,
    this.itemType = ItemType.detailTag,
  }) : super(
          name: name,
          url: url,
        );

  factory DetailedTagModel.fromJson(Map<String, dynamic> json) {
    return DetailedTagModel(
      name: json['name'],
      url: json['url'],
      imageUrl: json['imageUrl'],
      itemType: json['itemType'].toString().itemType,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'imageUrl': imageUrl,
      'itemType': itemType.name,
    };
  }
}

class TagPageModel extends TagModel {
  final List<TagModel> similarTags;
  final String description;
  final List<BaseArtistModel> topArtists;
  final String moreArtistsUrl;
  final List<BaseTrackModel> topTracks;
  final List<BaseAlbumModel> topAlbums;
  final List<DetailedTagModel> relatedTags;
  @override
  final ItemType itemType;

  TagPageModel({
    required String name,
    required String url,
    required this.similarTags,
    required this.description,
    required this.topArtists,
    required this.moreArtistsUrl,
    required this.topTracks,
    required this.topAlbums,
    required this.relatedTags,
    this.itemType = ItemType.tagPage,
  }) : super(
          name: name,
          url: url,
        );

  factory TagPageModel.fromJson(Map<String, dynamic> json) {
    return TagPageModel(
      name: json['name'],
      url: json['url'],
      similarTags: (json['similarTags'] as List)
          .map((e) => TagModel.fromJson(e))
          .toList(),
      description: json['description'],
      topArtists: (json['topArtists'] as List)
          .map((e) => BaseArtistModel.fromJson(e))
          .toList(),
      moreArtistsUrl: json['moreArtistsUrl'],
      topTracks: (json['topTracks'] as List)
          .map((e) => BaseTrackModel.fromJson(e))
          .toList(),
      topAlbums: (json['topAlbums'] as List)
          .map((e) => BaseAlbumModel.fromJson(e))
          .toList(),
      relatedTags: (json['relatedTags'] as List)
          .map((e) => DetailedTagModel.fromJson(e))
          .toList(),
      itemType: json['itemType'].toString().itemType,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'similarTags': similarTags.map((e) => e.toJson()).toList(),
      'description': description,
      'topArtists': topArtists.map((e) => e.toJson()).toList(),
      'moreArtistsUrl': moreArtistsUrl,
      'topTracks': topTracks.map((e) => e.toJson()).toList(),
      'topAlbums': topAlbums.map((e) => e.toJson()).toList(),
      'relatedTags': relatedTags.map((e) => e.toJson()).toList(),
      'itemType': itemType.name,
    };
  }
}
