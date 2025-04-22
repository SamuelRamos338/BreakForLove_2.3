import 'package:flutter/material.dart';
import '../components/bottom_nav_bar.dart'; // Import ajustado

class ProfilePageItem extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;

  const ProfilePageItem({
    super.key,
    required this.texto,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(texto),
      trailing: const Icon(Icons.arrow_forward),
      onTap: onPressed,
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Itens agrupados no topo
          children: [
            const SizedBox(height: 30),
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 60),
            ),
            const SizedBox(height: 20), // Espaçamento entre avatar e itens
            ProfilePageItem(
              texto: 'Meus Dados',
              onPressed: () {
                // Lógica para "Meus Dados"
              },
            ),
            ProfilePageItem(
              texto: 'Sobre o Casal',
              onPressed: () {
                // Lógica para "Sobre o Casal"
              },
            ),
            ProfilePageItem(
              texto: 'Sobre o App',
              onPressed: () {
                // Lógica para "Sobre o App"
              },
            ),
            const SizedBox(height: 30),
            const Spacer(),
            const Text(
              'ID: 00001',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3, // Índice da aba "Perfil"
        onTabChange: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/notifications');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/calendar');
              break;
          }
        },
      ),
    );
  }
}
