import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkingForecast {
  NetworkingForecast(this.url);
  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["data"];
      return data;
    } else {
      print(response.statusCode);
    }
  }
}
