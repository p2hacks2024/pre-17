import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
import 'dart:async';
import 'package:no_name/controller/main_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TorchState {
  final bool isScheduled;
  final bool isDialogShowing;
  final int remainingSeconds;

  const TorchState({
    this.isScheduled = false,
    this.isDialogShowing = false,
    this.remainingSeconds = 0,
  });

  TorchState setTorch({
    bool? isScheduled,
    bool? isDialogShowing,
    int? remainingSeconds,
  }) {
    return TorchState(
      isScheduled: isScheduled ?? this.isScheduled,
      isDialogShowing: isDialogShowing ?? this.isDialogShowing,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
    );
  }
}

class TorchControllerNotifier extends StateNotifier<TorchState> {
  TorchControllerNotifier() : super(const TorchState());

  Timer? _timer;

  void startSchedule(BuildContext context, int seconds) {
    _timer?.cancel();
    state = state.setTorch(
      isScheduled: true,
      remainingSeconds: seconds,
    );

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        final newSeconds = state.remainingSeconds - 1;

        if (newSeconds <= 0) {
          timer.cancel();
          state = state.setTorch(
            isScheduled: false,
            remainingSeconds: 0,
          );
          await enableTorch(context);
          await warmDialog(context, '警告 : 水を飲んでください', '最後に水を飲んでから30分が経過しました');

          await Future.delayed(const Duration(seconds: 5)); //光らせる秒数
          await disableTorch(context);

          _showTimeUpDialog(context);
          resetSchedule(context, 10);
        } else {
          state = state.setTorch(remainingSeconds: newSeconds);
        }
      },
    );
  }

  void resetSchedule(BuildContext context, int seconds) {
    startSchedule(context, seconds);
  }

  void _showTimeUpDialog(BuildContext context) {}

  void setDialogShowing(bool showing) {
    state = state.setTorch(isDialogShowing: showing);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> warmDialog(
      BuildContext context, String title, String content) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> enableTorch(context) async {
    try {
      await TorchLight.enableTorch();
    } on Exception catch (e) {
      warmDialog(context!, '例外が発生しました', e.toString());
    }
  }

  Future<void> disableTorch(context) async {
    try {
      await TorchLight.disableTorch();
    } on Exception catch (e) {
      warmDialog(context!, '例外が発生しました', e.toString());
    }
  }
}

// Provider定義
final torchControllerProvider =
    StateNotifierProvider.autoDispose<TorchControllerNotifier, TorchState>(
        (ref) {
  return TorchControllerNotifier();
});
