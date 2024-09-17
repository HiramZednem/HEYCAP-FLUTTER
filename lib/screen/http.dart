import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpApi extends StatefulWidget {
  const HttpApi({super.key});

  @override
  State<HttpApi> createState() => _HttpApiState();
}

class _HttpApiState extends State<HttpApi> {
  // Método para hacer la solicitud HTTP
  Future<Map<String, dynamic>> fetchData() async {
    final url = Uri.parse('https://rickandmortyapi.com/api/character');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty Characters'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final data = snapshot.data;
              final List results = data?['results'] ?? []; // List of characters

              // Mostramos una lista de personajes
              return ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final character = results[index];
                  return ListTile(
                    leading:
                        Image.network(character['image']), // Character image
                    title: Text(character['name']), // Character name
                    subtitle: Text(
                        'Status: ${character['status']}'), // Character status
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
