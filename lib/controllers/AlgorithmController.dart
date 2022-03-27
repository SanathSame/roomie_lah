import 'dart:convert';

import 'package:http/http.dart' as http;

class AlgorithmController {
  String url = "http://10.0.2.2:5000/";

  Future<List<String>> getRecommedations(String currentUsername) async {
    print(currentUsername);
    String host = url + "getRecommendations";
    print("host == $host");
    final response = await http.post(Uri.parse(host), body: currentUsername);
    print("here");
    final decoded = json.decode(response.body) as Map<String, dynamic>;
    List<String> recommendations =
        List<String>.from(decoded['list of profiles']);
    print(recommendations);
    return recommendations;
  }
}
