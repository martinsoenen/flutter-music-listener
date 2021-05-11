import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cours_flutter_g4_ing2/Models/Music.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'G4 Musique',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color.fromRGBO(30, 30, 30, 1),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        scaffoldBackgroundColor: Color.fromRGBO(120, 120, 120, 1),
        primaryColor: Colors.grey,
        primaryTextTheme: TextTheme(
          headline6: TextStyle(color: Colors.white),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  final double cardImageSize = 320;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPlaying = false;
  int musicId = 0;

  AudioPlayer player;
  AudioCache playerCache;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  secSeek(int sec) {
    Duration newPos = Duration(seconds: sec);
    player.seek(newPos);
  }

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();

    // Longueur de la musique
    player.durationHandler = (d){
      setState(() {
        musicLength = d;
      });
    };
    // Position en direct dans la musique
    player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };
  }

  @override
  Widget build(BuildContext context) {

    List<Music> musicList = [
      Music(
          artistName: "Röyksopp, Robyn",
          songTitle: "Monument - The Inevitable End Version",
          pictureUrl: "https://m.media-amazon.com/images/I/81FyPjVkcjL._SS500_.jpg",
          urlMusic: "https://data04.flac.pw/vkp/jpmIuyxbelkJY7d4IkM8dw_1620751614_4__cs9-11v4.vkuseraudio.net/p4/10ff08e0cd9d2b.mp3"
      ),
      Music(
          artistName: "Fall Out Boy",
          songTitle: "Thnks Fr Th Mmrs",
          pictureUrl: "https://images-na.ssl-images-amazon.com/images/I/71J%2BQkOmAKL._SL1400_.jpg",
          urlMusic: "https://data03.flac.pw/vkp/hjk8yaUA8uASb1jZduBjVw_1620751562_3__cs9-4v4.vkuseraudio.net/p1/f93b0440b3b2cd.mp3"
      ),
      Music(
          artistName: "ONE OK ROCK",
          songTitle: "Bombs Away",
          pictureUrl: "https://i1.sndcdn.com/artworks-hqAXLWIRgJGs-0-t500x500.jpg",
          urlMusic: "https://data03.flac.pw/vkp/av_wC8c3yzt9S6T3ZyPVqw_1620750058_3__cs9-17v4.vkuseraudio.net/p1/bb9132a702d920.mp3"
      ),
      Music(
          artistName: "Alan Walker",
          songTitle: "Sing Me To Sleep",
          pictureUrl: "https://i1.sndcdn.com/artworks-Uh5O5qVZoBVC-0-t500x500.jpg",
          urlMusic: "https://paglasongs.com/files/download/id/1714"
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("G4 Musique"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: widget.cardImageSize,
              width: widget.cardImageSize,
              child: Card(
                child: Image.network(
                  musicList[musicId].pictureUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        musicList[musicId].songTitle,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(musicList[musicId].artistName),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(Icons.skip_previous),
                          onPressed: () => {
                            if (musicId > 0) {
                              if (this.isPlaying) {
                                player.stop(),
                                setState(() {
                                  this.isPlaying = !this.isPlaying;
                                }),
                              },
                              setState(() {
                                musicId = musicId - 1;
                              }),
                            }
                          }
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      IconButton(
                          icon: this.isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow) ,
                          onPressed: () {
                            if (!this.isPlaying) {
                              player.play(musicList[musicId].urlMusic);
                            } else {
                              player.pause();
                            }
                            setState(() {
                              this.isPlaying = !this.isPlaying;
                            });
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      IconButton(
                          icon: Icon(Icons.skip_next),
                          onPressed: () => {
                            if (musicId < musicList.length - 1) {
                              if (this.isPlaying) {
                                player.stop(),
                                setState(() {
                                  this.isPlaying = !this.isPlaying;
                                }),
                              },
                              setState(() {
                                musicId = musicId + 1;
                              }),
                            }
                          }
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(position.inMinutes.toString() + ":" + position.inSeconds.remainder(60).toStringAsFixed(0)),
                          Text(musicLength.inMinutes.toString() + ":" + musicLength.inSeconds.remainder(60).toString()),
                        ],
                      ),
                    ),
                    Slider.adaptive(
                      value: position.inSeconds.toDouble(),
                      max: musicLength.inSeconds.toDouble(),
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        secSeek(value.toInt());
                      },
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}