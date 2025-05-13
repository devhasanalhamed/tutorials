import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timer',
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
  HomePageState createState() => HomePageState();
}

const int t = 10; // seconds

class HomePageState extends State<HomePage> {
  late Timer timer;
  int counter = t;
  bool _isActive = false;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void start() {
    setState(() {
      _isActive = true;
      setTimer();
    });
  }

  void reset() {
    if (_isActive) {
      timer.cancel();
      setState(() {
        _isActive = false;
        counter = t;
      });
    }
  }

  void setTimer() {
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
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 54.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (!_isActive)
            CustomElevatedButton(title: 'Start', onPressed: start),
          if (_isActive)
            CustomElevatedButton(
              title: 'Reset',
              onPressed: reset,
              backgroundColor: Colors.amber,
            ),
        ],
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color backgroundColor;
  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor = Colors.deepPurple,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        fixedSize: Size.fromHeight(64.0),
        shape: LinearBorder(),
      ),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
      ),
    );
  }
}
