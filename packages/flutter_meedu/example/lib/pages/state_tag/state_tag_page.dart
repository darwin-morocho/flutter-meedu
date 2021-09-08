import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/page.dart';
import 'package:flutter_meedu/state.dart';

class StateTagPage extends StatelessWidget {
  const StateTagPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              _LoginTagView(tagName: 'login1', color: Colors.black12),
              _LoginTagView(tagName: 'login2', color: Colors.black26),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginTagView extends ConsumerWidget {
  final String tagName;
  final Color color;
  const _LoginTagView({
    Key? key,
    required this.tagName,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(loginTagProvider.find(tagName));

    return Container(
      padding: EdgeInsets.all(15),
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(hintText: "your email here"),
            onChanged: loginTagProvider.find(tagName).read.onEmailChanged,
          ),
          SizedBox(height: 20),
          Text(controller.state.email),
        ],
      ),
    );
  }
}

final loginTagProvider = StateProvider.withTag<_LoginController, _LoginState>(
  (_) => _LoginController(),
);

class _LoginController extends StateNotifier<_LoginState> {
  _LoginController() : super(_LoginState('', ''));

  void onEmailChanged(String email) {
    state = state.copyWith(email: email);
  }

  @override
  void dispose() {
    print("Disposed _LoginController ${this.hashCode}");
    super.dispose();
  }
}

class _LoginState extends Equatable {
  final String email, password;

  _LoginState(this.email, this.password);

  _LoginState copyWith({
    String? email,
    String? password,
  }) {
    return _LoginState(
      email ?? this.email,
      password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [email, password];
}
