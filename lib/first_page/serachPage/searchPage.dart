import 'package:flutter/material.dart';
import 'package:mx_player/provider/provider.dart';
import 'package:provider/provider.dart';

import '../../provider/serach_provider/ser_provider.dart';

class searchPage extends StatelessWidget {
  const searchPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController txtTextFild = TextEditingController();

    var providerSearch = Provider.of<SearchProvider>(context);
    var provider = Provider.of<MxPlayerProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Text("Hello"),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: txtTextFild,
              onChanged: (value) {
                providerSearch.searchSong(value);
                providerSearch.getData();
              },
              style: TextStyle(color: Colors.yellowAccent),
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      )),
                  labelText: "Search",
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 2))),
            ),
          ),
          Consumer<SearchProvider>(
              builder: (context, providerSearch, child) => (providerSearch
                              .searchModal ==
                          null ||
                      providerSearch.search == '' &&
                          providerSearch.listOfSearch.length == 0)
                  ? Column(
                      children: [
                        SizedBox(
                          height: 250,
                        ),
                        Text(
                          'Play what you love song',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        Text(
                          'Search for artists, songs, prodcasts, and\nmore.',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : (providerSearch.search != '')
                      ? Expanded(
                          child: ListView.builder(
                          itemCount:
                              providerSearch.searchModal!.data.results.length,
                          itemBuilder: (context, index) {
                            final data =
                                providerSearch.searchModal!.data.results;
                            return ListTile(
                              onTap: () async {
                                providerSearch.listOfSearch.add(data[index]);

                                provider.selectSongAll(data[index]);

                                await provider
                                    .setSong(data[index].downloadUrl[1].url);

                                provider.playSong();
                                provider.isPlay = true;
                                provider.nextSong = index;
                                providerSearch.searchSong('');
                                providerSearch.getData();
                                txtTextFild.clear();
                              },
                              leading: Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${data[index].image[2].url}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(
                                '${data[index].name}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                              subtitle: Text(
                                  "${data[index].artists.primary[0].name}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18)),
                            );
                          },
                        ))
                      : Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Recent Searches',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ...List.generate(
                                  providerSearch.listOfSearch.length,
                                  (index) {
                                    return ListTile(
                                      onTap: () async {
                                        final data =
                                            providerSearch.listOfSearch[index];
                                        provider.selectSongAll(data);
                                        await provider
                                            .setSong(data.downloadUrl[1].url);

                                        provider.playSong();
                                        provider.isPlay = true;
                                        provider.nextSong = index;
                                      },
                                      leading: Container(
                                        height: 65,
                                        width: 65,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                '${providerSearch.listOfSearch[index].image[2].url}'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        '${providerSearch.listOfSearch[index].name}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      subtitle: Text(
                                        'Singer - ${providerSearch.listOfSearch[index].artists.primary[0].name}',
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      trailing: IconButton(
                                          onPressed: () {
                                            providerSearch.removeData(index);
                                          },
                                          icon: Icon(
                                            Icons.cancel,
                                            color: Colors.white,
                                          )),
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        )),
        ],
      ),
    );
  }
}
