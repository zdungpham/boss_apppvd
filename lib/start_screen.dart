import 'package:boss_app/grid_board.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Boss Timer'),
          centerTitle: true,
          backgroundColor: Colors.brown,
        ),
        body: GridBoard(),
      ),
    );
  }
}
