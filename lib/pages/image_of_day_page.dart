import 'package:flutter/material.dart';
import '../models/apod.dart';
import '../services/api_connection.dart';

class ImageOfDayPage extends StatelessWidget {
  final Apod apod;

  const ImageOfDayPage({super.key, required this.apod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(apod.title)),
      body: Column(
        children: [
          Expanded(
            child: apod.mediaType == "image"
                ? Image.network(
                    ApiConnection.proxy(apod.url),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.error, size: 80),
                  )
                : const Center(
                    child: Text(
                      "Este APOD é um vídeo.\nAbra o link na explicação.",
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              apod.explanation,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
