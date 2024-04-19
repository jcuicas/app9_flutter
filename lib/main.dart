import 'package:flutter/material.dart';
import 'package:app9/screens/home.dart';

void main() => runApp(const MyApp9());

class MyApp9 extends StatelessWidget {
  const MyApp9({super.key});

  @override
  Widget build(BuildContext context) {
    const String tituloApp = 'Lista de compañias';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow)),
      home: HomeScreen(
        titulo: tituloApp,
      ),
    );
  }
}
