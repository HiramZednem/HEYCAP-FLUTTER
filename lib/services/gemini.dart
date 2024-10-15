import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final GenerativeModel model;

  ApiService()
      : model = GenerativeModel(
            model: 'gemini-1.5-flash', apiKey: dotenv.env['API_KEY'] as String);
                                      // role, mensaje
  Future<String> getResponse(List<Map<String, String>> conversation) async {
    try {
      final List<Content> contentList = conversation.map((message) {
        return Content.text(message['message']!);
      }).toList();

      // Llamar a la API con la conversación completa
      final response = await model.generateContent(contentList);

      if (response.text != null) {
        return response.text!;
      } else {
        return 'Error: No se generó una respuesta válida.';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
