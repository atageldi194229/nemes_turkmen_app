import 'package:flutter/material.dart';
import 'package:nemes/presentation/pages/home_page.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Nemes dilini öwren! Offline",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
