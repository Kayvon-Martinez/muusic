
# Muusic

An unofficial last.fm client made with dart and kotlin


## Features
#### NYI = Not yet implemented
#### W = Working
##### NTF = Need to fix
#### Android app
- Favorites (NYI)
- Search (NYI)
- Artist details (NYI)
- Album details (NYI)
- Track details (NYI)
- Tag details (NYI)
- Tag artists, albums, and tracks browser (NYI)
- Track lyrics (NYI)
- Artist's events (NYI)
- Muusic Player (NYI)
- History (NYI)


#### Api:
- Search (W)
- Get artist details (NTF isTouring)
- Get album details (W)
- Get track details (W)
- Get tag details (W)
- Get tag artists (paginated) (W)
- Get tag albums (paginated) (W)
- Get tag tracks (paginated) (W)
- Get lyrics (paginated) (W)
- Get an artist's events (paginated) (W)
- Get extracted song info (paginated) (W)

## Installation

#### Requirements
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio)
- An Android device or emulator

#### How to run the api:

```bash
  // Windows
  cd backend
  dart compile exe .\bin\backend.dart
  ./bin/backend.exe

  // MacOs/Linux
  cd backend
  dart compile exe ./bin/backend.dart
  ./bin/backend.exe
```

#### How to run the Android app:
###### 1. Compile the app in Android Studio (If not running on an emulator you will have to configure the app to request the right loacal ip)
###### 1. Install the app on your device
###### 2. Open it
## API Reference

The api is served on http://localhost:8080/api/v1

#### Search

```http
  GET /api/v1/search/{query}
```

| Parameter | Type     | Description                | Parameter Type |
| :-------- | :------- | :------------------------- | :------- |
| `query` | `string` | **Required**. Your search query | Path |

#### Get artist details

```http
  POST /api/v1/details/artist
```

| Parameter | Type     | Description                       | Parameter Type |
| :-------- | :------- | :-------------------------------- | :------- |
| `url`      | `string` | **Required**. Url for artist from items with itemType *Artist* | Json |

#### Get album details

```http
  POST /api/v1/details/album
```

| Parameter | Type     | Description                       | Parameter Type |
| :-------- | :------- | :-------------------------------- | :------- |
| `url`      | `string` | **Required**. Url for album from items with itemType *Album* | Json |

#### Get track details

```http
  POST /api/v1/details/track
```

| Parameter | Type     | Description                       | Parameter Type |
| :-------- | :------- | :-------------------------------- | :------- |
| `url`      | `string` | **Required**. Url for track from items with itemType *Track* | Json |

#### Get tag details

```http
  POST /api/v1/details/tag
```

| Parameter | Type     | Description                       | Parameter Type |
| :-------- | :------- | :-------------------------------- | :------- |
| `url`      | `string` | **Required**. Url for tag from items with itemType *Tag* | Json |

#### Get tag artists (paginated)

```http
  POST /api/v1/tag/artists
```

| Parameter | Type     | Description                       | Parameter Type |
| :-------- | :------- | :-------------------------------- | :------- |
| `url`      | `string` | **Required**. Url for tag from items with itemType *Tag* | Json |
| `page`      | `int` | **Optional**. Page number to request. Default is 1  | Json |


#### Get tag albums (paginated)

```http
  POST /api/v1/tag/albums
```

| Parameter | Type     | Description                       | Parameter Type |
| :-------- | :------- | :-------------------------------- | :------- |
| `url`      | `string` | **Required**. Url for tag from items with itemType *Tag* | Json |
| `page`      | `int` | **Optional**. Page number to request. Default is 1  | Json |

#### Get tag tracks (paginated)

```http
  POST /api/v1/tag/tracks
```

| Parameter | Type     | Description                       | Parameter Type |
| :-------- | :------- | :-------------------------------- | :------- |
| `url`      | `string` | **Required**. Url for tag from items with itemType *Tag* | Json |
| `page`      | `int` | **Optional**. Page number to request. Default is 1  | Json |

#### Get lyrics (paginated)

```http
  POST /api/v1/lyrics
```

| Parameter | Type     | Description                       | Parameter Type |
| :-------- | :------- | :-------------------------------- | :------- |
| `url`      | `string` | **Required**. Url for lyrics from lyricsUrl in track details| Json |

#### Get an artist's events (paginated)

```http
  POST /api/v1/events
```

| Parameter | Type     | Description                       | Parameter Type |
| :-------- | :------- | :-------------------------------- | :------- |
| `url`      | `string` | **Required**. Url for lyrics from eventsUrl in artist details| Json |


#### Get extracted song info (paginated)

```http
  POST /api/v1/extractor
```

| Parameter | Type     | Description                       | Parameter Type |
| :-------- | :------- | :-------------------------------- | :------- |
| `url`      | `string` | **Required**. Source url for song from items with itemType *Track* | Json |
