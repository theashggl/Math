import 'package:flutter/material.dart';
import 'package:flutter_apps/Models/list_generation.dart';

class NumberDisplay extends StatelessWidget {
  const NumberDisplay({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NumberScreen(),
    );
  }
}

class NumberScreen extends StatefulWidget {
  const NumberScreen({Key key}) : super(key: key);
  @override
  _NumberScreenState createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  GameListGeneration gameListGeneration = GameListGeneration();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: gameListGeneration.createData(),
          builder: (context, snapshot) {
            return Center(child: Text(snapshot.data.toString()));
          },
        ),
      ),
    );
  }
}
