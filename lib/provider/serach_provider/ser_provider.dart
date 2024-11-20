import 'package:flutter/widgets.dart';
import 'package:mx_player/modal/modal.dart';

import '../../api_serviec/serach_service.dart';

class SearchProvider extends ChangeNotifier {
  String search = '';
  String recentSearch = '';
  List<Result> listOfSearch = [];

  Song? searchModal;
  Song? searchSelSong;

  Future<void> getData() async {
    SearchApiService apiService = SearchApiService();

    Map<String, dynamic> json = await apiService.fetchData(search);
    searchModal = Song.fromJson(json);
    notifyListeners();
  }

  Future<void> fetchData() async {
    SearchApiService apiService = SearchApiService();
    Map<String, dynamic> json = await apiService.fetchData(recentSearch);
    searchSelSong = Song.fromJson(json);
    notifyListeners();
  }

  void removeData(int index) {
    listOfSearch.removeAt(index);
  }

  // void deleteData(int index)
  // {
  //   likedData.removeAt(index);
  //   notifyListeners();
  // }

  void searchSong(String selectSong) {
    search=selectSong;
    notifyListeners();
  }
  void playSong(String selectSong)
  {
    recentSearch=selectSong;
    notifyListeners();
  }


  SearchProvider()
  {
    getData();
  }
}
// selectSong
