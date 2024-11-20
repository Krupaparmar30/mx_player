import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mx_player/provider/provider.dart';
import 'package:provider/provider.dart';

class songPage extends StatelessWidget {
  const songPage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MxPlayerProvider>(context);
    void changeSong(double first, double second) async {
      if (provider.repat == true) {
        if (first == second) {
          final data = provider.songNeha!.data.results[provider.nextSong];
          provider.selectSongAll(data);
          await provider.setSong(data.downloadUrl[1].url);
          provider.player.play();
          provider.isSong = true;
        }
      } else {
        if (first == second) {
          final data = provider.songNeha!.data.results[provider.nextSong + 1];
          provider.selectSongAll(data);
          await provider.setSong(data.downloadUrl[1].url);
          provider.player.play();
          provider.isSong = true;
          provider.nextSong = provider.nextSong + 1;
        }
      }
    }

    num checkSong(double firstSong, double secondSong) {
      changeSong(firstSong, secondSong);
      return secondSong;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        backgroundColor: Colors.black,
        title: Text(
          "Music Page",
          style: TextStyle(
            color: Colors.white,
          ),
        ),

        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed('/like');
          }, icon: Icon(Icons.favorite,color: Colors.white,))
        ],
      ),
      body: Consumer<MxPlayerProvider>(
        builder: (context, provider, child) => SizedBox(
          width: double.infinity,
          height: 600,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      height: 500,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.pink,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        provider.result!.image[2].url)),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.transparent,
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(0, 2)),
                                ]),
                          ),
                          Text(
                            provider.result!.name,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Text(
                            provider.result!.artists.primary[0].name,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          StreamBuilder(
                            stream: provider.getCurrentPosition(),
                            builder: (context, snapshot) {
                              return Slider(
                                activeColor: Colors.red,
                                max: provider.duration!.inSeconds.toDouble() ??
                                    0,
                                value: snapshot.data!.inSeconds.toDouble(),
                                onChanged: (value) {
                                  provider.moveSlider(
                                      Duration(seconds: value.toInt()));
                                },
                              );
                            },
                          ),
                          StreamBuilder(
                            stream: provider.getCurrentPosition(),
                            builder: (context, snapshot) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text(
                                    //   provider.duration!.inMinutes.toString(),
                                    //   style: TextStyle(
                                    //     color: Colors.white,
                                    //   ),
                                    // ),
                                    Text(
                                      '${provider.duration!.inMinutes.toDouble()}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      '${checkSong(provider.duration!.inSeconds.toDouble(), snapshot.data!.inSeconds.toDouble())}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    await provider.playSong();
                                  },
                                  icon: Icon(
                                    Icons.fast_rewind_outlined,
                                    color: Colors.white,
                                    size: 40,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    provider.checkSong();
                                    provider.playSong();
                                  },
                                  icon: (provider.isSong == true)
                                      ? Icon(
                                          Icons.pause_circle_filled,
                                          color: Colors.white,
                                          size: 52,
                                        )
                                      : Icon(
                                          Icons.play_circle,
                                          color: Colors.white,
                                          size: 52,
                                        )),
                              IconButton(
                                  onPressed: () async {
                                    await provider.playSong();
                                  },
                                  icon: Icon(
                                    Icons.fast_forward_outlined,
                                    color: Colors.white,
                                    size: 40,
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    // provider.songModel!.data.results[0]
                                    final data = provider.songNeha!.data
                                        .results[provider.nextSong + 1];
                                    provider.selectSongAll(data);
                                    await provider
                                        .setSong(data.downloadUrl[1].url);
                                    provider.player.play();
                                    provider.isSong = true;
                                    provider.nextSong = provider.nextSong + 1;
                                  },
                                  icon: Icon(
                                    Icons.skip_next_outlined,
                                    color: Colors.white,
                                    size: 38,
                                  )),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    provider.repeateSong();
                                  },
                                  icon: Icon(
                                    CupertinoIcons.repeat,
                                    color: (provider.repat == true)
                                        ? Color(0xff6156e1)
                                        : Colors.white,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    provider.likeList
                                        .add(provider.result!.name);
                                    // provider.likeList.add(provider.result!.downloadUrl[2].url);
                                    // likeList.add(provider.result!.name);
                                    // likeList.add(provider.result!.downloadUrl[2].url);

                                    // provider
                                    // .addFavourite(provider.result!.name);
                                  },

                                      icon: (provider.isLikeView == true)
                                          ? Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.white,
                                        size: 22,
                                      )
                                          : Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 22,
                                      )),
                              // IconButton(onPressed: () {
                              //   provider.likeList.add(provider.result!);
                              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              //     content: Row(
                              //       children: [
                              //         Icon(CupertinoIcons.headphones,color: Color(0xff6156e1),),
                              //         Text(
                              //           "  Added to Liked Songs",
                              //           style: TextStyle(color: Color(0xff6156e1),fontWeight: FontWeight.bold,fontSize: 16),
                              //         ),
                              //       ],
                              //     ),
                              //     backgroundColor: Colors.white,
                              //     action: SnackBarAction(
                              //         label: 'Undo',
                              //         textColor: Color(0xff6156e1),
                              //         onPressed: () {}),
                              //   ));
                              // }, icon: Icon(Icons.favorite,color: Colors.white,size: 25,)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
