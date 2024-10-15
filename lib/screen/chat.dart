import 'package:flutter/material.dart';
import 'package:heycap/services/gemini.dart'; // Asegúrate de que esta ruta sea correcta
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemini Chatbot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, String>> messages = [];
  bool isBotTyping = false;

  @override
  void initState() {
    super.initState();
    _loadChatHistory(); // Cargar historial al iniciar la aplicación
  }

  // Método para guardar el historial en el local storage
  Future<void> _saveChatHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String messagesJson = jsonEncode(messages); // Convertir la lista a JSON
    await prefs.setString('chat_history', messagesJson);
  }

  // Método para cargar el historial desde el local storage
  Future<void> _loadChatHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? messagesJson = prefs.getString('chat_history');

    if (messagesJson != null) {
      setState(() {
        messages = (jsonDecode(messagesJson) as List)
            .map((item) => Map<String, String>.from(item))
            .toList();
      });
    }
  }

  void sendMessage() async {
    if (_controller.text.isEmpty) return;

    String userMessage = _controller.text;

    // Añadir el mensaje del usuario al historial
    setState(() {
      messages.add({'role': 'user', 'message': userMessage});
      isBotTyping = true;
      _scrollToBottom();
    });
    _controller.clear();

    // Guardar historial actualizado
    _saveChatHistory();

    // Obtener la respuesta del bot enviando todo el historial de mensajes
    String botResponse = await apiService.getResponse(messages);

    // Añadir la respuesta del bot al historial
    setState(() {
      messages.add({'role': 'bot', 'message': botResponse});
      isBotTyping = false;
    });

    // Guardar historial actualizado
    _saveChatHistory();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    // Verifica si el controlador está adjunto antes de usarlo
    if (_scrollController.hasClients) {
      // Desplazarse hacia el final de la lista
      _scrollController
          .jumpTo(_scrollController.position.maxScrollExtent + 130);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini Chatbot'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Asignar el ScrollController
              itemCount: messages.length +
                  (isBotTyping ? 1 : 0), // +1 si el bot está escribiendo
              itemBuilder: (context, index) {
                if (index == messages.length && isBotTyping) {
                  // Mostrar el spinner al final de la lista
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(width: 10),
                          Text("El bot está escribiendo..."),
                        ],
                      ),
                    ),
                  );
                }

                // Mostrar los mensajes anteriores
                final message = messages[index];
                final isUserMessage = message['role'] == 'user';

                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUserMessage
                          ? Colors.orange
                          : const Color.fromARGB(255, 157, 150, 128),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message['message']!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onSubmitted: (value) => sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
