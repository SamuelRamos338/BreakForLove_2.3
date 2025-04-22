import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChange;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTabChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: GNav(
          selectedIndex: currentIndex,
          onTabChange: onTabChange,
          color: Colors.black, // Cor dos ícones inativos
          activeColor: Colors.black, // Cor dos ícones ativos
          tabBackgroundColor: Colors.pink.shade100,// Cor do fundo ativo
          padding: const EdgeInsets.all(13), // Mantendo o padding original
          gap: 5, // Espaço entre ícones e textos
          tabs: const [
            GButton(icon: Icons.home, text: 'Inicio'),
            GButton(icon: Icons.notifications, text: 'Notificações'),
            GButton(icon: Icons.calendar_month, text: 'Calendário'),
            GButton(icon: Icons.account_circle, text: 'Perfil'),
          ],
        ),
      ),
    );
  }
}
