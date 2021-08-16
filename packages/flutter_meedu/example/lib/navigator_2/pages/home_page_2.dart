import 'package:flutter/material.dart';
import 'package:flutter_meedu/router2.dart';
import 'package:routemaster/routemaster.dart';

class HomePage2 extends StatelessWidget {
  const HomePage2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 40),
            TextButton(
              child: Text("counter"),
              onPressed: () {
                router2.push('/counter');
              },
            ),
            SizedBox(height: 10),
            TextButton(
              child: Text("go to product"),
              onPressed: () {
                // Routemaster.of(context).replace('/counter');
                router2.pushReplacement(
                  '/user/Darwin Morocho/product/2',
                  queryParameters: {
                    'darkMode': 'true',
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
