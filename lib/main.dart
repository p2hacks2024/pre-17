import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MyApp());
}

double ratio = 0.0; //ジョッキに入っているアルコール量(max:1.0)

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
  List<List<String>> csvImport() {
    List<List<String>> importList = [];

    try {
      final String csvString =
          File('assets/alcohol_content.csv').readAsStringSync();

      List<String> csvLines = LineSplitter().convert(csvString);
      for (String line in csvLines) {
        importList.add(line.split(','));
      }

      print(importList);
    } catch (e) {
      importList.add(e.toString().split(','));
    }
    return importList;
  }

  @override
  Widget build(BuildContext context) {
    final test = csvImport();
    //目盛り
    List<Widget> scaleLine() {
      List<Widget> widgets = [];
      for (int i = 0; i < 10; i++) {
        if (i % 5 == 0) {
          widgets.add(
            Positioned(
              top: 350 * (i / 10),
              left: 30,
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 74, 74),
                ),
              ),
            ),
          );
        } else {
          widgets.add(
            Positioned(
              top: 350 * (i / 10),
              left: 30,
              child: Container(
                height: 5,
                width: 20,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 74, 74),
                ),
              ),
            ),
          );
        }
      }
      return widgets;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 188, 149),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 355,
                  width: 210,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 199, 248, 255),
                  ),
                ),
                Positioned(
                  top: 350 * (1 - ratio),
                  left: 5,
                  child: Container(
                    height: 350 * ratio,
                    width: 200,

                    // alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 255, 183, 39),
                    ),
                  ),
                ),
                ...scaleLine(),
              ],
            ),
            Container(
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      ratio += (0.7 / 3);
                      print('ボタンがタップされました！'); //押したときの処理を書く
                    },
                    child: Image.asset('assets/beer.png'),
                  ),
                  InkWell(
                    onTap: () {
                      print('ボタンがタップされました！'); //押したときの処理を書く

                      ratio += (0.6 / 3);
                    },
                    child: Image.asset('assets/PlumLiqueur.png'),
                  ),
                  InkWell(
                    onTap: () {
                      print('ボタンがタップされました！'); //押したときの処理を書く
                      ratio += (1 / 3);
                    },
                    child: Image.asset('assets/whiskey.png'),
                  ),
                  InkWell(
                    onTap: () {
                      print('ボタンがタップされました！'); //押したときの処理を書く
                      ratio -= 0.1;
                    },
                    child: Image.asset('assets/00c021eee9d4be95.png'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
