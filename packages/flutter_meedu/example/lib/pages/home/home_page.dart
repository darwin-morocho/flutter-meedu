import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/rx.dart';
import 'package:flutter_meedu/state.dart';
import 'package:meedu_example/main.dart';
import 'package:meedu_example/pages/home/home_controller.dart';
import 'package:meedu_example/pages/home/home_provider.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:meedu_example/routes/routes.dart';
import 'home_state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(_) {
    final dateTime = router.arguments as DateTime?;
    homeProvider.setArguments(dateTime ?? DateTime.now());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => {
              router.pushNamedAndRemoveUntil(Routes.SPLASH),
            },
          ),
        ],
      ),
    );

//  final dateTime = router.arguments(_) as DateTime?;
//     homeProvider.setArguments(dateTime ?? DateTime.now());
//     return Scaffold(
//       appBar: AppBar(
//         // title: RxBuilder(
//         //   () => Text("${homeProvider.read.counter}"),
//         // ),
//         title: Consumer(
//           builder: (_, watch, __) {
//             print("object");
//             // print(StackTrace.current);
//             final text = watch<HomeController, HomeState>(
//               homeProvider.buildWhen(
//                 (prevState, currentState) {
//                   return prevState.randomText != currentState.randomText;
//                 },
//               ),
//             ).state.randomText;
//             return Text(
//               text,
//               style: TextStyle(fontSize: 13),
//             );
//           },
//         ),
//         actions: [
//           SimpleBuilder<AppThemeController>(
//             builder: (_) => CupertinoSwitch(
//               value: _.darkMode,
//               onChanged: _.onToggleTheme,
//               trackColor: Colors.black26,
//               activeColor: Colors.blue,
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () => {
//               router.pushNamedAndRemoveUntil(Routes.SPLASH),
//             },
//           ),
//         ],
//       ),
//       body: Consumer(
//         builder: (_, watch, __) {
//           final users = watch<HomeController, HomeState>(
//             homeProvider.buildWhen(
//               (prevState, currentState) => prevState.users.length != currentState.users.length,
//             ),
//           ).state.users;
//           if (users.isEmpty)
//             return Center(
//               child: CupertinoActivityIndicator(radius: 15),
//             );
//           print("list");
//           return ListView.builder(
//             itemBuilder: (_, index) {
//               final user = users[index];
//               return ListTile(
//                 title: Text("${user.firstName} ${user.lastName}"),
//                 subtitle: Text("${user.email}"),
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(user.avatar),
//                 ),
//               );
//             },
//             itemCount: users.length,
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: homeProvider.read.random,
//       ),
//     );
  }
}
