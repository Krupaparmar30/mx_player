import 'package:flutter/material.dart';
import 'package:mx_player/provider/provider.dart';
import 'package:provider/provider.dart';

class songPage extends StatelessWidget {
  const songPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Songs"),
      ),
      body: Consumer<MxPlayerProvider>(
        builder: (context, provider, child) => SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.pink,
                    image: DecorationImage(
                        image: NetworkImage(provider.result!.image[2].url)),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 2)),
                    ]),
              ),
              Text(
                provider.result!.name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              Text(
                provider.result!.artists.primary[0].name,
                style: TextStyle(fontSize: 18),
              ),
              IconButton(
                  onPressed: () async {
                    await provider.playSong();
                  },
                  icon: Icon(
                    Icons.play_circle_outlined,
                    size: 50,
                  )),
              StreamBuilder(
                stream: provider.getCurrentPosition(),
                builder: (context, snapshot) {
                  return Slider(
                    max: provider.duration!.inSeconds.toDouble() ?? 0,
                    value: snapshot.data!.inSeconds.toDouble(),
                    onChanged: (value) {
                      provider.moveSlider(Duration(seconds: value.toInt()));
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(snapshot.data!.inSeconds.toString()),
                        Text(provider.duration!.inSeconds.toString())
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
