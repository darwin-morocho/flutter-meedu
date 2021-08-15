import 'package:flutter/material.dart';
import 'package:flutter_meedu/router2.dart';

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
                router2.push(
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
