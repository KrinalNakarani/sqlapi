import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sqlapi/controller/model.dart';

class Apiclass {
  Future<List<dynamic>> GetData(String a) async{
    String link = "https://jsonplaceholder.typicode.com/comments?postId=$a";
    Uri url = Uri.parse(link);
    var abc = await http.get(url);
    var data = jsonDecode(abc.body);
    return data.map((e) => Apimodel().apiFactory(e)).toList();
  }
}
