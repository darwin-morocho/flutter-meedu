import 'dart:async';

import 'package:flutter_meedu/meedu.dart';

import 'home_state.dart';
import 'package:dio/dio.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController() : super(HomeState.initialState) {
    _init();
  }

  final _counter = 0.obs;
  int get counter => _counter.value;

  Timer? _timer;

  Future<void> _init() async {
    try {
      final response = await Dio().get("https://reqres.in/api/users");
      final users = (response.data['data'] as List)
          .map(
            (e) => User.fromJson(e),
          )
          .toList();
      state = state.copyWith(users: users);
      _timer = Timer.periodic(Duration(seconds: 1), (_) {
        _counter.value++;
      });
    } catch (e) {}
  }

  void random() {
    state = state.copyWith(randomText: DateTime.now().toString());
  }

  @override
  void dispose() {
    print("HomeController disposed");
    _counter.close();
    _timer?.cancel();
    super.dispose();
  }
}
