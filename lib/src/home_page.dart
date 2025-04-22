import 'package:flutter/material.dart';
import '../components/bottom_nav_bar.dart'; // Import ajustado
import './notification_page.dart';
import './calendar_page.dart';
import './profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Bem-vindo à Página Inicial!",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0, // Índice da aba "Inicio"
        onTabChange: (index) {
          switch (index) {
            case 1:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const NotificationPage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return child; // Sem animação entre as páginas
                  },
                  transitionDuration: Duration.zero, // Remove a duração da transição
                ),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const CalendarPage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return child; // Sem animação entre as páginas
                  },
                  transitionDuration: Duration.zero, // Remove a duração da transição
                ),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const ProfilePage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return child; // Sem animação entre as páginas
                  },
                  transitionDuration: Duration.zero, // Remove a duração da transição
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
