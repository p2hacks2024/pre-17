import 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:flutter/material.dart';

final alcoholRatioProvider = NotifierProvider<alcoholRatioNotifier, double>(() {
  return alcoholRatioNotifier();
});

class alcoholRatioNotifier extends Notifier<double> {
  // 初期値を設定する
  @override
  double build() {
    return 0.0;
  }

  void set(double ratio) {
    if (ratio > 1.0) {
      state = 1.0;
    } else if (ratio < 0.0) {
      state = 0.0;
    } else {
      state = ratio;
    }
  }

  void add(double ratio) {
    state += ratio;
    if (state > 1.0) {
      state = 1.0;
    } else if (state < 0.0) {
      state = 0.0;
    }
  }
}
