import 'package:flutter/material.dart';
import 'register_page.dart';

// Tela de Login com animação e layout responsivo
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores dos campos
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    // Ativa a animação após pequeno delay
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fundo com gradiente animado
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 243, 33, 159),
              const Color.fromARGB(255, 248, 203, 230),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // Evita overflow em telas pequenas
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 800),
              opacity: _visible ? 1 : 0,
              child: AnimatedSlide(
                duration: Duration(milliseconds: 800),
                offset: _visible ? Offset(0, 0) : Offset(0, 0.3),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Image.asset(
                      'assets/logoApp.png',
                      width: 280,
                      height: 200,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Mais tempo com quem realmente importa.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                    _LoginForm(
                      usernameController: _usernameController,
                      passwordController: _passwordController,
                      rememberMe: _rememberMe,
                      onRememberChanged: (value) {
                        setState(() => _rememberMe = value);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Formulário da tela de login
class _LoginForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final Function(bool) onRememberChanged;

  const _LoginForm({
    required this.usernameController,
    required this.passwordController,
    required this.rememberMe,
    required this.onRememberChanged,
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
            SizedBox(height: 20),
            // Campo: E-mail
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 12),
            // Campo: Senha
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            // Lembrar senha e recuperar
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (value) => onRememberChanged(value ?? false),
                ),
                Text(
                  'Lembrar senha',
                  style: TextStyle(fontSize: 10, color: Colors.blue),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Recuperar Senha'),
                        content: TextField(
                          decoration: InputDecoration(
                            labelText: 'Digite seu e-mail',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Instruções enviadas para o e-mail!'),
                                ),
                              );
                            },
                            child: Text('Enviar'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancelar'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    'Esqueceu a senha?',
                    style: TextStyle(fontSize: 10, color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Botão: Login
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 230, 65, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                // Aqui você pode validar o login
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text(
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
