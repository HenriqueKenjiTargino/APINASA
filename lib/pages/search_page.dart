import 'package:flutter/material.dart';
import '../models/apod.dart';
import '../services/api_connection.dart';
import 'image_of_day_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController dateController = TextEditingController();
  Apod? apod;
  bool loading = false;

  final String apiKey = "S1pvtv4ARS1lpSbmRSQR5sCbUbWmhOtTB39T0CuG";

  Future<void> search() async {
    setState(() => loading = true);

    final json = await ApiConnection.fetchByDate(apiKey, dateController.text);

    if (json != null) {
      setState(() {
        apod = Apod.fromJson(json);
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buscar por Data")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                label: Text("AAAA-MM-DD"),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: search,
              child: const Text("Buscar"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : apod == null
                      ? const Center(child: Text("Nenhum resultado"))
                      : GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ImageOfDayPage(apod: apod!),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: apod!.mediaType == "image"
                                    ? Image.network(
                                        ApiConnection.proxy(apod!.url),
                                        fit: BoxFit.cover,
                                      )
                                    : const Text("O APOD encontrado é um vídeo."),
                              ),
                              Text(
                                apod!.title,
                                style: const TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }
}
