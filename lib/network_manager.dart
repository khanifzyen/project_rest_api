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

  Future<Album> createAlbum(String title) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': title,
      }),
    );

    if (response.statusCode == 201) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album');
    }
  }

  Future<Album> updateAlbum(int id, String title) async {
    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'title': title,
        },
      ),
    );

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update album');
    }
  }

  Future<Album> deleteAlbum(int id) async {
    final response = await http.delete(
        Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      // Jika server mengembalikan respons 200 OK,
      // maka parsing JSON. Setelah menghapus
      // anda akan mendapat kembalian respon json kosong `{}`.
      // Jangan kembalikan `null`, jika mengembalikan null `snapshot.hasData`
      // akan selalu mengembalikan false pada `FutureBuilder`
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete album');
    }
  }
}
