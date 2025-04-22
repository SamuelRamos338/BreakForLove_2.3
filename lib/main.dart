import 'package:flutter/material.dart';
import 'package:myapp/src/home_page.dart';
import 'package:myapp/src/login_page.dart';
import 'package:myapp/src/register_page.dart';
import 'package:myapp/src/notification_page.dart';
import 'package:myapp/src/calendar_page.dart';
import 'package:myapp/src/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Define a rota inicial
      initialRoute: '/home',
      // Configurações de rotas
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/notifications': (context) => const NotificationPage(),
        '/calendar': (context) => const CalendarPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
