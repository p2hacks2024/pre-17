import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: DrinkOrNot(),
  ));
}

class DrinkOrNot extends StatelessWidget {
  DrinkOrNot({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 188, 149),
      appBar: AppBar(
        title: const Text('Drink or Not'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0), // 横の余白を調整
          child: Container(
            width: 400, // レイアウト全体の幅を設定
            padding: const EdgeInsets.all(20.0), // コンテナ内の余白
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 242, 229, 1),
              borderRadius: BorderRadius.circular(10), // 少し角を丸める
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '『お酒は楽しく適量で』',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'ここでやめると、無事に家に帰れます。',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 30), // ボタンとテキスト間のスペース
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // ボタンを均等配置
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        debugPrint('まだ飲む pressed');
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        backgroundColor:
                            const Color.fromARGB(255, 241, 237, 237),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // 四角形のボタン
                        ),
                      ),
                      child: const Text('まだ飲む',
                          style: TextStyle(color: Colors.black)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        debugPrint('水を飲む pressed');
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor:
                            const Color.fromARGB(255, 243, 251, 251),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // 四角形のボタン
                        ),
                      ),
                      child: const Text('お水を飲む',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
