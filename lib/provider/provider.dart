import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mx_player/api_serviec/api_serviec.dart';
import 'package:mx_player/modal/modal.dart';

import '../modal/modal.dart';

class MxPlayerProvider extends ChangeNotifier {
  Song? song;
  Result? result;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration? duration;
  bool isPlay = false;

  Future<void> getSongs() async {
    ApiService apiService = ApiService();
    Map<String, dynamic> json = await apiService.fetchSongs();
    song = Song.fromJson(json);

    notifyListeners();
  }

  void selectSong(Result selectSong) {
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

  Future<void> moveSlider(Duration position)
  async {
    await audioPlayer.seek(position);
    notifyListeners();

  }

  MxPlayerProvider() {
    getSongs();
  }
}
