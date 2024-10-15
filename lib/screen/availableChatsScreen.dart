import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvailableChatsScreen extends StatefulWidget {
  const AvailableChatsScreen({Key? key}) : super(key: key);

  @override
  State<AvailableChatsScreen> createState() => _AvailableChatsScreenState();
}

class _AvailableChatsScreenState extends State<AvailableChatsScreen> {
  List<String> _chats = [];
  int _numberTask = 0;

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  // Cargar los chats desde SharedPreferences
  Future<void> _loadChats() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _chats = prefs.getStringList('chats') ?? [];
      _numberTask = prefs.getInt('nChat') ?? 0;
    });
  }

  // Guardar los chats en SharedPreferences
  Future<void> _saveChats() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('nChat', _numberTask);
    prefs.setStringList('chats', _chats);
  }

  // Agregar un nuevo chat
  void _addChat() {
    setState(() {
      _chats.add('Chat ${_numberTask}');
      _numberTask = _numberTask + 1;
      _saveChats(); // Guardar en local storage
    });
  }

  // Eliminar un chat
  void _removeChat(int index) {
    setState(() {
      _chats.removeAt(index); // Eliminar el chat
      _saveChats(); // Guardar cambios en local storage
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addChat,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_chats[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeChat(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
