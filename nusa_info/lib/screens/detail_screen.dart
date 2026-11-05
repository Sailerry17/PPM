import 'package:flutter/material.dart';

import '../models/post.dart';
import '../services/post_service.dart';

class DetailScreen extends StatefulWidget {
  final Post post;

  const DetailScreen({super.key, required this.post});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final PostService _service = PostService();
  late Future<List<Comment>> _commentsFuture;

  @override
  void initState() {
    super.initState();
    _commentsFuture = _service.fetchComments(widget.post.id);
  }

  void _retry() {
    setState(() {
      _commentsFuture = _service.fetchComments(widget.post.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pengumuman')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(post.title, style: textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text('Oleh pengguna #${post.userId}', style: textTheme.bodySmall),
          const SizedBox(height: 16),
          Text(post.body, style: textTheme.bodyLarge),
          const Divider(height: 32),
          Text('Komentar', style: textTheme.titleLarge),
          const SizedBox(height: 8),
          FutureBuilder<List<Comment>>(
            future: _commentsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text(snapshot.error.toString(), textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _retry,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                    ),
                  ],
                );
              }

              final comments = snapshot.data ?? [];
              if (comments.isEmpty) {
                return const Text('Belum ada komentar.');
              }

              return Column(
                children: comments
                    .map(
                      (c) => Card(
                        child: ListTile(
                          title: Text(c.name),
                          subtitle: Text('${c.email}\n${c.body}'),
                          isThreeLine: true,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
