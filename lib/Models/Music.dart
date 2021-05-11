import 'dart:convert';

Music musicFromJson(String str) => Music.fromJson(json.decode(str));

String musicToJson(Music data) => json.encode(data.toJson());

class Music {
  Music({
    this.artistName,
    this.songTitle,
    this.pictureUrl,
    this.urlMusic,
  });

  String artistName;
  String songTitle;
  String pictureUrl;
  String urlMusic;

  factory Music.fromJson(Map<String, dynamic> json) => Music(
    artistName: json["artistName"],
    songTitle: json["songTitle"],
    pictureUrl: json["pictureUrl"],
    urlMusic: json["urlMusic"],
  );

  Map<String, dynamic> toJson() => {
    "artistName": artistName,
    "songTitle": songTitle,
    "pictureUrl": pictureUrl,
    "urlMusic": urlMusic,
  };
}