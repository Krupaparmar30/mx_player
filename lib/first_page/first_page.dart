import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mx_player/modal/modal.dart';
import 'package:mx_player/provider/provider.dart';
import 'package:provider/provider.dart';

TextEditingController txtTextFild = TextEditingController();

class firstPage extends StatelessWidget {
  const firstPage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MxPlayerProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQIM57KDHyxTdRFhpTOqqe4SVeoMYoL2miww&s"),
            ),
          ),
          title: Text("My Songs", style: TextStyle(color: Colors.white)),
        ),
        bottomNavigationBar: TabBar(
          labelColor: Colors.pink,
          overlayColor: WidgetStatePropertyAll(Colors.white12),
          padding: EdgeInsets.all(8),
          tabAlignment: TabAlignment.start,
          indicatorPadding: EdgeInsets.zero,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Neha Kakar Songs'),
            Tab(text: 'Sonu Nigam Songs'),
            Tab(text: 'Lata Mangeshkar Songs'),
            Tab(text: 'Aagitya Gadhavi Songs'),
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 160, top: 5),
                  child: Text(
                    "Hi Krupa!!",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/ser');
                    },
                    icon: Icon(
                      Icons.search,
                      size: 22,
                      color: Colors.white,
                    ))
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 180, top: 5),
              child: Text(
                "New Release !!",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.pink,
                                  blurRadius: 2,
                                  offset: Offset(0, 2),
                                  spreadRadius: 2)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(images[index]),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              "---- All New Songs ----",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Expanded(
              child: TabBarView(children: [
                Consumer<MxPlayerProvider>(
                  builder: (context, provider, child) => FutureBuilder(
                    future: provider.getSongsNeha(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return    CircularProgressIndicator();
                      }
                      else if(snapshot.connectionState==ConnectionState.waiting)
                        {
                          CircularProgressIndicator();
                        }

                     return  ListView.builder(
                       itemCount: provider.songNeha!.data.results.length,
                       itemBuilder: (context, index) {
                         Result result =
                         provider.songNeha!.data.results[index];
                         return Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: ListTile(
                             leading: Image(
                                 image: NetworkImage(result.image[2].url)),
                             title: Text(
                               result.name,
                               style: TextStyle(color: Colors.white),
                             ),
                             subtitle: Text(
                               result.artists.primary[0].name,
                               style: TextStyle(color: Colors.white),
                             ),
                             trailing: IconButton(
                                 onPressed: () {
                                   provider.selectSongAll(result);
                                   provider.setSong(result.downloadUrl[0].url);
                                   Navigator.of(context).pushNamed('/song');
                                 },
                                 icon: Icon(
                                   Icons.arrow_forward_ios,
                                   color: Colors.white,
                                 )),
                           ),
                         );
                       },
                     );
                    },
                  ),
                ),
                Consumer<MxPlayerProvider>(
                  builder: (context, provider, child) => FutureBuilder(
                    future: provider.getSongsSonu(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        CircularProgressIndicator();
                      }

                      return ListView.builder(
                        itemCount: provider.songSonu!.data.results.length,
                        itemBuilder: (context, index) {
                          Result result =
                              provider.songSonu!.data.results[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Image(
                                  image: NetworkImage(result.image[2].url)),
                              title: Text(result.name,
                                  style: TextStyle(color: Colors.white)),
                              subtitle: Text(result.artists.primary[0].name,
                                  style: TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                  onPressed: () {
                                    provider.selectSongAll(result);
                                    provider.setSong(result.downloadUrl[0].url);
                                    Navigator.of(context).pushNamed('/song');
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  )),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Consumer<MxPlayerProvider>(
                  builder: (context, provider, child) => FutureBuilder(
                    future: provider.getSongsLata(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        CircularProgressIndicator();
                      }

                      return ListView.builder(
                        itemCount: provider.songLata!.data.results.length,
                        itemBuilder: (context, index) {
                          Result result =
                              provider.songLata!.data.results[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Image(
                                  image: NetworkImage(result.image[2].url)),
                              title: Text(result.name,
                                  style: TextStyle(color: Colors.white)),
                              subtitle: Text(result.artists.primary[0].name,
                                  style: TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                  onPressed: () {
                                    provider.selectSongAll(result);
                                    provider.setSong(result.downloadUrl[0].url);
                                    Navigator.of(context).pushNamed('/song');
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  )),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Consumer<MxPlayerProvider>(
                  builder: (context, provider, child) => FutureBuilder(
                    future: provider.getSongsAaditay(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        CircularProgressIndicator();
                      }

                      return ListView.builder(
                        itemCount: provider.songAaditya!.data.results.length,
                        itemBuilder: (context, index) {
                          Result result =
                              provider.songAaditya!.data.results[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Image(
                                  image: NetworkImage(result.image[2].url)),
                              title: Text(result.name,
                                  style: TextStyle(color: Colors.white)),
                              subtitle: Text(result.artists.primary[0].name,
                                  style: TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                  onPressed: () {
                                    provider.selectSongAll(result);
                                    provider.setSong(result.downloadUrl[0].url);
                                    Navigator.of(context).pushNamed('/song');
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  )),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

List images = [
  "https://i.scdn.co/image/ab67616d00001e02dc9563139ebc2a5597254664",
  "https://i0.wp.com/www.smartprix.com/bytes/wp-content/uploads/2024/02/7-1.webp?ssl=1&quality=80&w=728&h=910",
  "https://media5.bollywoodhungama.in/wp-content/uploads/2024/04/Pyar-Ke-Do-Naam-2-306x393.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFzaF1tU_HuOjXc4wfAa4CrSqSEGkKmwuDDNyGjOypncGHmsYqSCURcOdPbqoTkbfFjX8&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEJPo9LvQHKCRnqhIBcV9MEtNEHdUS2IRZKg&s"
];
