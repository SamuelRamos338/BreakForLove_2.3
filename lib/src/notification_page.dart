import 'dart:async';
import 'package:flutter/material.dart';
import '../components/bottom_nav_bar.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _timerSeconds = 0;
  bool _isTimerRunning = false;
  bool _notificationsEnabled = false;
  late Timer _timer;

  final _hourController = TextEditingController(text: '0');
  final _minuteController = TextEditingController(text: '0');
  final _secondController = TextEditingController(text: '30');

  void _startTimer() {
    if (_isTimerRunning || _timerSeconds <= 0) return;

    setState(() {
      _isTimerRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        setState(() {
          _isTimerRunning = false;
          _notificationsEnabled = false; // Desativa notificações ao fim do timer
        });
        timer.cancel();
      }
    });
  }

  void _stopTimer() {
    if (_isTimerRunning) {
      _timer.cancel();
      setState(() {
        _isTimerRunning = false;
        _notificationsEnabled = false; // Desativa notificações ao parar
      });
    }
  }

  void _resetTimer() {
    _stopTimer();
    final hours = int.tryParse(_hourController.text) ?? 0;
    final minutes = int.tryParse(_minuteController.text) ?? 0;
    final seconds = int.tryParse(_secondController.text) ?? 0;

    setState(() {
      _timerSeconds = (hours * 3600) + (minutes * 60) + seconds;
      _notificationsEnabled = true; // Reativa notificações ao resetar
    });
  }

  String _formatTime(int totalSeconds) {
    final hours = (totalSeconds / 3600).floor();
    final minutes = ((totalSeconds % 3600) / 60).floor();
    final seconds = totalSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _secondController.dispose();
    if (_isTimerRunning) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notificações',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 80,
                  height: 40,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(9999),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white24,
                        blurRadius: 16,
                        offset: Offset(0, 0),
                        spreadRadius: -8,
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      AnimatedAlign(
                        duration: const Duration(milliseconds: 500),
                        alignment: _notificationsEnabled
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        curve: Curves.easeInOutCubicEmphasized,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: _notificationsEnabled
                                ? Colors.pinkAccent
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              width: _notificationsEnabled ? 15 : 18,
                              height: _notificationsEnabled ? 15 : 18,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: ClipPath(
                                clipper: _notificationsEnabled
                                    ? _StopClipper()
                                    : _PlayClipper(),
                                child: Container(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: _notificationsEnabled
                              ? () {
                            setState(() {
                              _notificationsEnabled =
                              !_notificationsEnabled;
                            });
                          }
                              : null, // Desativa toque se notificações estiverem desativadas
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTimeField('Horas', _hourController),
                    _buildTimeField('Min', _minuteController),
                    _buildTimeField('Seg', _secondController),
                  ],
                ),
                const SizedBox(height: 10),
                Chip(
                  label: Text(
                    _formatTime(_timerSeconds),
                    style: const TextStyle(fontSize: 20),
                  ),
                  backgroundColor:
                  _isTimerRunning ? Colors.green : Colors.grey,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _isTimerRunning ? _stopTimer : null,
                      child: const Text('Parar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _resetTimer,
                      child: const Text('Definir Tempo'),
                    ),
                    ElevatedButton(
                      onPressed: !_isTimerRunning ? _startTimer : null,
                      child: const Text('Iniciar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1, // Índice da aba "Notificações"
        onTabChange: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/calendar');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }

  Widget _buildTimeField(String label, TextEditingController controller) {
    return SizedBox(
      width: 80,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

// Custom clippers for play and stop shapes
class _PlayClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.25, 0);
    path.lineTo(size.width * 0.75, size.height * 0.5);
    path.lineTo(size.width * 0.25, size.height);
    path.lineTo(size.width * 0.25, size.height * 0.51);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _StopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
