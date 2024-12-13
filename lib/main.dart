import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

double ratio = 0.8; //ジョッキに入っているアルコール量(max:1.0)

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'P2HACKS2024 team17',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: Stack(
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
      ),
    );
  }
}
