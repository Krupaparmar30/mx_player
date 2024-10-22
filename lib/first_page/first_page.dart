import 'package:flutter/material.dart';
import 'package:mx_player/modal/modal.dart';
import 'package:mx_player/provider/provider.dart';
import 'package:provider/provider.dart';

class firstPage extends StatelessWidget {
  const firstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Songs"),
      ),
      body: Provider.of<MxPlayerProvider>(context).song == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<MxPlayerProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.song!.data.results.length,
                  itemBuilder: (context, index) {
                    Result result = provider.song!.data.results[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading:
                            Image(image: NetworkImage(result.image[2].url)),
                        title: Text(result.name),
                        subtitle: Text(result.artists.primary[0].name),
                        trailing: IconButton(
                            onPressed: () {


                              provider.selectSong(result);
                              provider.setSong(result.downloadUrl[0].url);
                              Navigator.of(context).pushNamed('/song');
                            },
                            icon: Icon(Icons.arrow_forward_ios)),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
