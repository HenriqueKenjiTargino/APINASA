import 'package:flutter/material.dart';
import '../models/apod.dart';
import '../services/api_connection.dart';
import 'image_of_day_page.dart';
import 'search_page.dart';
import 'credits_page.dart';

class HomePage extends StatefulWidget {
  final String apiKey;

  const HomePage({super.key, required this.apiKey});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Apod? apod;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadTodayImage();
  }

  Future<void> loadTodayImage() async {
    final json = await ApiConnection.fetchToday(widget.apiKey);

    if (json != null) {
      setState(() {
        apod = Apod.fromJson(json);
        loading = false;
      });
    } else {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Positioned.fill(
                  child: apod != null
                      ? Image.network(
                          ApiConnection.proxy(apod!.url),
                          fit: BoxFit.cover,
                        )
                      : Container(color: Colors.black),
                ),

                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.7),
                          Colors.white.withValues(alpha: 0.85),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _menuButton(
                        text: "Ver detalhes",
                        onPressed: () {
                          if (apod != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ImageOfDayPage(apod: apod!),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      _menuButton(
                        text: "Pesquisar por data",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SearchPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      _menuButton(
                        text: "Créditos",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CreditsPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
  Widget _menuButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
  backgroundColor: Colors.white.withValues(alpha: 0.85),
  foregroundColor: Colors.black,
  textStyle: const TextStyle(fontSize: 18),
),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
