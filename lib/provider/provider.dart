import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mx_player/api_serviec/api_serviec.dart';
import 'package:mx_player/modal/modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modal/modal.dart';

class MxPlayerProvider extends ChangeNotifier {
  Song? songNeha;
  Song? songSonu;
  Song? songLata;
  Song? songAaditya;
  Song? songNarayan;
  Result? result;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration? duration;
  bool isPlay = false;
  bool isLikeView = false;
  int nextSong = 0;
  bool repat = false;
  AudioPlayer player=AudioPlayer();
  bool isSong=false;

  List<String> likeList = [];
  List<String> images = [];

  Future<void> getSongsNeha() async {
    ApiService apiService = ApiService();
    Map<String, dynamic> json = await apiService.fetchSongsNeha();
    songNeha = Song.fromJson(json);

    notifyListeners();
  }

  Future<void> getSongsSonu() async {
    ApiService apiService = ApiService();
    Map<String, dynamic> json = await apiService.fetchSongsSonu();
    songSonu = Song.fromJson(json);

    notifyListeners();
  }

  Future<void> getSongsLata() async {
    ApiService apiService = ApiService();
    Map<String, dynamic> json = await apiService.fetchSongLata();
    songLata = Song.fromJson(json);

    notifyListeners();
  }

  Future<void> getSongsAaditay() async {
    ApiService apiService = ApiService();
    Map<String, dynamic> json = await apiService.fetchSongAaditay();
    songAaditya = Song.fromJson(json);

    notifyListeners();
  }

  Future<void> getSongsNarayan() async {
    ApiService apiService = ApiService();
    Map<String, dynamic> json = await apiService.fetchSongsNarayan();
    songNarayan = Song.fromJson(json);

    notifyListeners();
  }

  void selectSongAll(Result selectSong) {
    result = selectSong;
    notifyListeners();
  }

  Future<void> setSong(String url) async {
    duration = await audioPlayer.setUrl(url);
    notifyListeners();
  }

  Future<void> playSong() async {
    if (isPlay) {
      isPlay = false;
      await audioPlayer.pause();
      notifyListeners();
    } else {
      isPlay = true;
      await audioPlayer.play();
      notifyListeners();
    }
  }

  Stream<Duration> getCurrentPosition() {
    return audioPlayer.positionStream;
  }

  Future<void> moveSlider(Duration position) async {
    await audioPlayer.seek(position);
    notifyListeners();
  }

  Future<void> addFavourite(String name) async {
    String data = "$name";


    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    likeList.add(data);
    // likeList.add(image);

    sharedPreferences.setStringList('likeList', likeList);
  }

  void remove(int index)
  {
    likeList.removeAt(index);
    notifyListeners();
  }

  void repeateSong() {
    repat = !repat;
   notifyListeners();
  }

  void checkSong()
  {
    isSong=!isSong;
    (isSong==true)?player.play():player.pause();
    notifyListeners();
  }

  MxPlayerProvider() {
      getSongsNeha();
      getSongsSonu();
      getSongsLata();
      getSongsAaditay();
      getSongsNarayan();
    }
  }
