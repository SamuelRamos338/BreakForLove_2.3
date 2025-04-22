import 'package:flutter/material.dart';
import '../main.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final PageController _pageController = PageController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Evita deslize manual entre telas
        children: [
          _buildLoginScreen(context), // Tela de Login
          const RegisterPage(),        // Tela de Cadastro
        ],
      ),
    );
  }

  Widget _buildLoginScreen(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade100, const Color(0xFFF8CBE6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Image.asset(
                'assets/logoApp.png',
                width: 280,
                height: 200,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 100),
              ),
              const SizedBox(height: 10),
              const Text(
                'Mais tempo com quem realmente importa.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 30),
              _LoginForm(
                usernameController: _usernameController,
                passwordController: _passwordController,
                rememberMe: _rememberMe,
                onRememberChanged: (value) => setState(() => _rememberMe = value),
                onRegisterTap: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                onLoginTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final Function(bool) onRememberChanged;
  final VoidCallback onRegisterTap;
  final VoidCallback onLoginTap;

  const _LoginForm({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.rememberMe,
    required this.onRememberChanged,
    required this.onRegisterTap,
    required this.onLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainPage()),
            );
          },
          child: const Text('Login'),
        ),
            TextButton(
              onPressed: onRegisterTap,
              child: const Text(
                'Criar conta',
                style: TextStyle(fontSize: 12, color: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
