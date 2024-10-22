
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class ApiService
{
  Future<Map<String,dynamic>> fetchSongs()
  async {
    String api="https://saavn.dev/api/search/songs?query=neha%20kakar";
    Uri url=Uri.parse(api);

  Response response= await http.get(url);
  if(response.statusCode==200)
    {
     String json= response.body;
    Map<String,dynamic> data= jsonDecode(json);
    return data;

    }
  return {};

  }
}