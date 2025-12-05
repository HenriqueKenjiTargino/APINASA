import 'package:flutter/material.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Créditos API")),
      body: const Center(
        child: Text(
          "NASA APOD API URL:https://api.nasa.gov/planetary/apod.\n"
          "Documentação oficial:https://api.nasa.gov/",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
