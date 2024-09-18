import 'package:flutter/material.dart';
import 'package:heycap/screen/contact_info.dart'; // Asegúrate que estas rutas sean correctas.
import 'package:heycap/screen/contacts.dart';
import 'package:heycap/screen/home.dart';
import 'package:heycap/screen/http.dart'; // Archivo que contiene la lógica para HttpApi.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.orange, // Color de fondo de la barra
          selectedItemColor: Colors.white, // Color de los ítems seleccionados
          unselectedItemColor:
              Colors.black54, // Color de los ítems no seleccionados
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Lista de pantallas que se muestran en la barra de navegación inferior
  final List<Widget> _screens = [
    const HomeScreen(),
    const HttpApi(),
    const ContactInfo(), // Pantalla de información de contacto
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.http),
            label: 'HTTP',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
    );
  }
}
