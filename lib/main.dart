import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:callaco/drink_or_not.dart';
import 'package:callaco/torch_timer.dart';
import 'package:callaco/controller/main_controller.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

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
      home: const MainPage(),
    );
  }
}

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(alcoholRatioProvider); //ジョッキに入っているアルコール量(max:1.0)
    ref.watch(torchControllerProvider);
    final torchController = ref.watch(torchControllerProvider.notifier);

    void lightCountStart() {
      if (ref.read(torchControllerProvider).isScheduled != true) {
        torchController.startSchedule(context, 1800);
      }
    }

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
                decoration: const BoxDecoration(
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
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 74, 74),
                ),
              ),
            ),
          );
        }
      }
      return widgets;
    }

    void drink(double content) {
      lightCountStart();
      ref.read(alcoholRatioProvider.notifier).add(content);
      if (ref.watch(alcoholRatioProvider) >= 0.75) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DrinkOrNot()));
      }
    }

    void drinkWater(double content) {
      ref.read(alcoholRatioProvider.notifier).add(content);

      ref.watch(torchControllerProvider.notifier).startSchedule(context, 1800);
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
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 199, 248, 255),
                  ),
                ),
                Positioned(
                  top: 350 * (1 - ref.watch(alcoholRatioProvider)),
                  left: 5,
                  child: Container(
                    height: 350 * ref.watch(alcoholRatioProvider),
                    width: 200,

                    // alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 255, 183, 39),
                    ),
                  ),
                ),
                ...scaleLine(),
              ],
            ),
            SizedBox(
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      drink(0.7 / 3);
                    },
                    child: Image.asset('assets/beer.png'),
                  ),
                  InkWell(
                    onTap: () {
                      drink(0.6 / 3);
                    },
                    child: Image.asset('assets/PlumLiqueur.png'),
                  ),
                  InkWell(
                    onTap: () {
                      drink(1 / 3);
                    },
                    child: Image.asset('assets/whiskey.png'),
                  ),
                  InkWell(
                    onTap: () {
                      drinkWater(-0.1);
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
