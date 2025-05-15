import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

const int initialTime = 300; // five minutes

class HomePageState extends State<HomePage> {
  int counter = initialTime;
  late Timer timer;

  bool _isActive = false;

  void start() {
    setState(() {
      _isActive = true;
    });
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (counter > 0) {
        setState(() {
          counter -= 1;
        });
      } else {
        reset();
      }
    });
  }

  void reset() {
    if (_isActive) {
      timer.cancel();
      setState(() {
        _isActive = false;
        counter = initialTime;
      });
    }
  }

  @override
  void dispose() {
    reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = '${counter ~/ 60}'.padLeft(2, '0');
    final seconds = '${counter % 60}'.padLeft(2, '0');
    final time = '$minutes:$seconds';
    return Scaffold(
      appBar: AppBar(title: Text('Timer'), centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: Text(
                time,
                style: TextStyle(fontSize: 56.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (!_isActive)
            ElevatedButton(
              onPressed: start,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                fixedSize: Size.fromHeight(64.0),
                shape: LinearBorder(),
              ),
              child: Text(
                'Start',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),

          if (_isActive)
            ElevatedButton(
              onPressed: reset,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
                fixedSize: Size.fromHeight(64.0),
                shape: LinearBorder(),
              ),
              child: Text(
                'Reset',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
