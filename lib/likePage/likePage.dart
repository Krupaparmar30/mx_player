import 'package:flutter/material.dart';
import 'package:mx_player/provider/provider.dart';
import 'package:mx_player/song_page/song_page.dart';
import 'package:provider/provider.dart';

class likePage extends StatelessWidget {
  const likePage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MxPlayerProvider>(context);

    return Scaffold(
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
          'Your Like Songs',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: provider.likeList.length,
        // itemBuilder: (context, index) {
        //   provider.setSong(likeList[index]);
        //   provider.selectSong(likeList[inde])
        // },
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: Text(
                  provider.likeList[index],
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                    onPressed: () {
                      provider.remove(index);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
              )

              // leading: Container(
              //   height: 100,
              //   width:100,
              //   decoration:
              //       BoxDecoration(image: DecorationImage(image:NetworkImage(provider.likeList[index]))),
              // ),
              ),
        ),
      ),
    );
  }
}
