import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/post.dart';

/// Exception dengan pesan yang ramah untuk ditampilkan ke pengguna.
class PostException implements Exception {
  final String message;
  const PostException(this.message);

  @override
  String toString() => message;
}

class PostService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration _timeout = Duration(seconds: 10);

  /// GET /posts
  Future<List<Post>> fetchPosts() {
    return _guard(() async {
      final uri = Uri.parse('$_baseUrl/posts'); // 1. buat alamat
      final response = await http.get(uri).timeout(_timeout); // 2. kirim request

      if (response.statusCode != 200) { // 3. cek status code
        throw PostException('Gagal memuat pengumuman (${response.statusCode}).');
      }

      final List<dynamic> data = jsonDecode(response.body); // 4. JSON -> objek
      return data
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  /// GET /posts/{id}/comments
  Future<List<Comment>> fetchComments(int postId) {
    return _guard(() async {
      final uri = Uri.parse('$_baseUrl/posts/$postId/comments');
      final response = await http.get(uri).timeout(_timeout);

      if (response.statusCode != 200) {
        throw PostException('Gagal memuat komentar (${response.statusCode}).');
      }

      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  /// POST /posts
  Future<Post> createPost({
    required String title,
    required String body,
    int userId = 1,
  }) {
    return _guard(() async {
      final uri = Uri.parse('$_baseUrl/posts');
      final response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode({'title': title, 'body': body, 'userId': userId}),
          )
          .timeout(_timeout);

      if (response.statusCode != 201) {
        throw PostException('Gagal membuat pengumuman (${response.statusCode}).');
      }

      return Post.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    });
  }

  /// Mengubah error jaringan menjadi pesan yang mudah dipahami.
  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on PostException {
      rethrow;
    } on SocketException {
      throw const PostException(
          'Tidak ada koneksi internet. Periksa jaringan Anda.');
    } on http.ClientException {
      throw const PostException(
          'Tidak ada koneksi internet. Periksa jaringan Anda.');
    } on TimeoutException {
      throw const PostException('Koneksi terlalu lama. Silakan coba lagi.');
    } on FormatException {
      throw const PostException('Format data dari server tidak valid.');
    }
  }
}
