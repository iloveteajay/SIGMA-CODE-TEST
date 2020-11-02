import 'package:http/http.dart' as http;
import 'dart:convert';
import './data.dart';

Future<Data> fetchData() async {
  final response = await http.get('https://sigmatenant.com/mobile/tags');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    print(response.statusCode);
    return Data.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}
