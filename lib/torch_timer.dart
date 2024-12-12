import 'dart:async';
import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class TorchTimer {
  Timer? _timer;

  Future<void> start(BuildContext context) async {
    // トーチが利用可能かチェック
    if (!await _isTorchAvailable(context)) return;

    // 30分ごとに繰り返すタイマーを設定
    _timer = Timer.periodic(const Duration(minutes: 30), (Timer timer) async {
      await _toggleFlashlight();
    });
  }

  Future<bool> _isTorchAvailable(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      return await TorchLight.isTorchAvailable();
    } on Exception catch (_) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('トーチが利用できるか確認できませんでした'),
        ),
      );
      return false;
    }
  }

  Future<void> _toggleFlashlight() async {
    try {
      // トーチライトを点灯
      await TorchLight.enableTorch();
    } catch (e) {
      // エラーが発生した場合にログ出力
      print('Torch error: $e');
    }
    await Future.delayed(const Duration(seconds: 5)); // 5秒間点灯
    // トーチライトを消灯
    try {
      await TorchLight.disableTorch();
    } catch (e) {
      // エラーが発生した場合にログ出力
      print('Torch error: $e');
    }
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }
}
