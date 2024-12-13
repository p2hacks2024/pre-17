import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
import 'dart:async';

void main() {
  runApp(TorchApp());
}

class TorchApp extends StatefulWidget {
  @override
  _TorchAppState createState() => _TorchAppState();
}

class _TorchAppState extends State<TorchApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TorchController(),
    );
  }
}

class TorchController extends StatefulWidget {
  @override
  _TorchControllerState createState() => _TorchControllerState();
}

class _TorchControllerState extends State<TorchController> {
  Timer? _timer; // 次の点灯スケジュール用のタイマー
  bool _isScheduled = false; // スケジュールが開始されているかどうか

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Torch Scheduler App'),
      ),
      body: FutureBuilder<bool>(
        future: _isTorchAvailable(context),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            return Center(
              child: ElevatedButton(
                child: Text(_isScheduled ? 'Stop Schedule' : 'Start Schedule'),
                onPressed: () {
                  if (_isScheduled) {
                    _stopSchedule();
                  } else {
                    _startSchedule();
                  }
                },
              ),
            );
          } else if (snapshot.hasData) {
            return const Center(
              child: Text('No torch available.'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<bool> _isTorchAvailable(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      return await TorchLight.isTorchAvailable();
    } on Exception catch (_) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Could not check if the device has an available torch'),
        ),
      );
      return false;
    }
  }

  void _startSchedule() {
    setState(() {
      _isScheduled = true;
    });

    // 最初の30分待機と以降のループを開始
    _scheduleNextLight();
  }

  void _scheduleNextLight() {
    _timer = Timer(Duration(seconds: 10), () async {
      await _enableTorch();
      await Future.delayed(Duration(seconds: 5));
      await _disableTorch();

      // 次のスケジュールをセット
      if (_isScheduled) {
        _scheduleNextLight();
      }
    });
  }

  void _stopSchedule() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _isScheduled = false;
    });
  }

  Future<void> _enableTorch() async {
    try {
      await TorchLight.enableTorch();
    } on Exception catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not enable torch'),
        ),
      );
    }
  }

  Future<void> _disableTorch() async {
    try {
      await TorchLight.disableTorch();
    } on Exception catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not disable torch'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _stopSchedule(); // アプリ終了時にタイマーを停止
    super.dispose();
  }
}
