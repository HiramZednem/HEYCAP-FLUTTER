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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen de perfil
            CircleAvatar(
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
                  onPressed: () => _launchURL('https://github.com/HiramZednem'),
                  tooltip: 'GitHub',
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.business),
                  onPressed: () =>
                      _launchURL('https://www.linkedin.com/in/hiramzednem/'),
                  tooltip: 'LinkedIn',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
