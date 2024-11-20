import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  Future<Map<String, dynamic>> fetchSongsNeha() async {
    String api1 = "https://saavn.dev/api/search/songs?query=neha%20kakar";
    Uri url = Uri.parse(api1);

    Response response = await http.get(url);
    if (response.statusCode == 200) {
      String json = response.body;
      Map<String, dynamic> data = jsonDecode(json);

      return data;
    }

    return {};

  }

  Future<Map<String, dynamic>> fetchSongsSonu() async {
    String api2 = "https://saavn.dev/api/search/songs?query=sonu%20nigam";
    Uri url = Uri.parse(api2);

    Response response = await http.get(url);
    if (response.statusCode == 200) {
      String json = response.body;
      Map<String, dynamic> data = jsonDecode(json);
      return data;
    }
    return {};
  }

  Future<Map<String, dynamic>> fetchSongLata() async {
    String api3 = "https://saavn.dev/api/search/songs?query=lata%20mangeshkar";
    Uri url = Uri.parse(api3);

    Response response = await http.get(url);
    if (response.statusCode == 200) {
      String json = response.body;
      Map<String, dynamic> data = jsonDecode(json);
      return data;
    }
    return {};
  }

  Future<Map<String, dynamic>> fetchSongAaditay() async {
    String api4 = "https://saavn.dev/api/search/songs?query=aaditya%20gadhavi";
    Uri url = Uri.parse(api4);

    Response response = await http.get(url);
    if (response.statusCode == 200) {
      String json = response.body;
      Map<String, dynamic> data = jsonDecode(json);
      return data;
    }
    return {};
  }


  Future<Map<String, dynamic>> fetchSongsNarayan() async {
    String api5 = "https://saavn.dev/api/search/songs?query=kinjal%20dave";
    Uri url = Uri.parse(api5);

    Response response = await http.get(url);
    if (response.statusCode == 200) {
      String json = response.body;
      Map<String, dynamic> data = jsonDecode(json);

      return data;
    }
    return {};
  }

}
