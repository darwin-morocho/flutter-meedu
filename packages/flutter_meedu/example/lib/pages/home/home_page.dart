import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:meedu_example/main.dart';
import 'package:meedu_example/pages/home/home_controller.dart';
import 'package:meedu_example/pages/home/home_provider.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:meedu_example/routes/routes.dart';
import 'home_state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(context) {
    // final dateTime = router.arguments<DateTime?>(_);
    // print("dateTime!=null ${dateTime != null}");
    // final dateTime = router.arguments(context) as DateTime?;
    // homeProvider.setArguments(dateTime ?? DateTime.now());
    return Scaffold(
      appBar: AppBar(
        // title: RxBuilder(
        //   () => Text("${homeProvider.read.counter}"),
        // ),
        title: Consumer(
          builder: (_, watch, __) {
            final users = watch<HomeController, HomeState>(
              homeProvider,
              WatchFilter(
                when: (prev, current) => prev.users.length != current.users.length,
              ),
            ).state.users;

            if (users.length == 0) return Text("lalalalal");

            return Consumer(builder: (_, watch, __) {
              final text = watch(homeProvider).state.randomText;
              return Text(
                text,
                style: TextStyle(fontSize: 13),
              );
            });

            // print(StackTrace.current);
            // final text = watch<HomeController, HomeState>(
            //   homeProvider.buildWhen(
            //     (prevState, currentState) {
            //       return prevState.randomText != currentState.randomText;
            //     },
            //   ),
            // ).state.randomText;
          },
        ),
        actions: [
          SimpleBuilder<AppThemeController>(
            builder: (context, _) => CupertinoSwitch(
              value: _.darkMode,
              onChanged: _.onToggleTheme,
              trackColor: Colors.black26,
              activeColor: Colors.blue,
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              router.pushNamed(
                Routes.TABS,
                arguments: 1,
              );
            },
          ),
        ],
      ),
      body: Consumer(
        builder: (_, watch, __) {
          final users = watch<HomeController, HomeState>(
            homeProvider,
            WatchFilter(
              when: (prev, current) => prev.users.length != current.users.length,
            ),
          ).state.users;
          if (users.isEmpty)
            return Center(
              child: CupertinoActivityIndicator(radius: 15),
            );
          print("list");
          return ListView.builder(
            itemBuilder: (_, index) {
              final user = users[index];
              return ListTile(
                title: Text("${user.firstName} ${user.lastName}"),
                subtitle: Text("${user.email}"),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar),
                ),
              );
            },
            itemCount: users.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: homeProvider.read.random,
      ),
    );
  }
}
