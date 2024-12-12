import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'torch_timer.dart';

void main() {
  runApp(const MyApp());
}

double ratio = 0.5;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'P2HACKS2024 team17',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TorchTimer _torchTimer = TorchTimer(); // インスタンスを作成

  @override
  void initState() {
    super.initState();
    _torchTimer.start(); // タイマーを開始
  }

  @override
  void dispose() {
    _torchTimer.stop(); // タイマーを停止
    super.dispose();
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 188, 149),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 350,
              width: 210,
              // alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 199, 248, 255),
              ),
            ),
            Positioned(
              top: 225,
              left: 5,
              child: Container(
                height: 120,
                width: 200,
                // alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 183, 39),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
