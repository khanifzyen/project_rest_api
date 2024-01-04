import 'package:http/http.dart' as http;
import 'album.dart';
import 'dart:convert';

class NetworkManager {
  Future<Album> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load Album");
    }
  }
}
