import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 30),
          const CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 60),
          ),
          const SizedBox(height: 20),
          _ProfilePageItem(
            texto: 'Meus Dados',
            onPressed: () {
              // Lógica para "Meus Dados"
            },
          ),
          _ProfilePageItem(
            texto: 'Sobre o Casal',
            onPressed: () {
              // Lógica para "Sobre o Casal"
            },
          ),
          _ProfilePageItem(
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
    );
  }
}

class _ProfilePageItem extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;

  const _ProfilePageItem({
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
