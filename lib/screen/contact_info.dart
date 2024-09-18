import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  // Función para abrir enlaces
  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de Contacto'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Imagen de perfil
              const CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                  'https://scontent.fntr7-1.fna.fbcdn.net/v/t39.30808-6/449778905_506681621686778_7264212319723498870_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHeGU8benS3mlutpYVo0st1_6zZHa_mFOL_rNkdr-YU4lMFpP6cTGmSNDNF4nidYBPKBZAvYtQfoFxM8etANR15&_nc_ohc=-eQHpgyu6_IQ7kNvgFtiOFT&_nc_zt=23&_nc_ht=scontent.fntr7-1.fna&oh=00_AYAWbkhPBBJVuyz_5aTngS_EKK0Efcp6ku1dcZewu2GYPw&oe=66EFAB62',
                ),
              ),
              const SizedBox(height: 16),

              // Información personal
              const Text(
                'Nombre: Hiram Mendez',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Matrícula: 213456',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Text(
                'Grupo: 9b',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),

              // Enlaces a GitHub y LinkedIn
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.link),
                    onPressed: () => _launchURL(
                        'https://github.com/HiramZednem/HEYCAP-FLUTTER/tree/hiram-individual'),
                    tooltip: 'GitHub',
                  ),
                ],
              ),

              // Botones para llamar y enviar SMS
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.orange.withOpacity(0.1),
                    ),
                    child: IconButton(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      icon: const Icon(Icons.phone),
                      onPressed: () async {
                        final phoneNumber = Uri.parse('tel:9613321460');
                        if (await canLaunchUrl(phoneNumber)) {
                          await launchUrl(phoneNumber);
                        } else {
                          throw 'Could not launch $phoneNumber';
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.orange.withOpacity(0.1),
                    ),
                    child: IconButton(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      icon: const Icon(Icons.message),
                      onPressed: () async {
                        final messageNumber = Uri.parse('sms:9613324160');
                        if (await launchUrl(messageNumber)) {
                          await launchUrl(messageNumber);
                        } else {
                          throw 'Could not launch $messageNumber';
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
