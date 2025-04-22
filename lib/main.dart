import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/src/home_page.dart';
import 'package:myapp/src/notification_page.dart';
import 'package:myapp/src/calendar_page.dart';
import 'package:myapp/src/profile_page.dart';
import 'package:myapp/components/bottom_nav_bar.dart';
import 'package:myapp/src/login_page.dart';

void main() {
  runApp(const MyApp());
}

class DndController {
  static const MethodChannel _channel = MethodChannel("dnd_mode");

  static Future<void> setDoNotDisturb(bool enabled) async {
    try {
      await _channel.invokeMethod("setDnD", {"enabled": enabled});
    } catch (e) {
      print("Erro ao alterar Não Perturbe: $e");
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const LoginPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = const [
    HomePage(),
    NotificationPage(),
    CalendarPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: PageView(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          children: _pages,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
