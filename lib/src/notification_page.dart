import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _timerSeconds = 30;
  bool _isTimerRunning = false;
  bool _notificationsEnabled = false;
  Timer? _timer;

  void _startTimer() {
    if (_isTimerRunning || _timerSeconds <= 0) return;
    setState(() => _isTimerRunning = true);

    DndController.setDoNotDisturb(true); // Ativar Não Perturbe

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() => _timerSeconds--);
      } else {
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    setState(() {
      _isTimerRunning = false;
      _notificationsEnabled = false;
      _timerSeconds = 30; // Reinicia o tempo
    });

    DndController.setDoNotDisturb(false); // Desativar Não Perturbe
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notificações")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _stopTimer,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isTimerRunning ? Colors.green.withOpacity(0.3) : Colors.pink.shade100.withOpacity(0.3),
                  border: Border.all(color: Colors.grey, width: 4),
                ),
                alignment: Alignment.center,
                child: Text(
                  _timerSeconds.toString(),
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isTimerRunning ? _stopTimer : null,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Parar', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: _startTimer,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Iniciar', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
