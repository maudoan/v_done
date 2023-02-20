import 'package:flutter/material.dart';

class CreateLiveScreen extends StatefulWidget {
  const CreateLiveScreen({Key? key}) : super(key: key);

  @override
  _CreateLiveScreenState createState() => _CreateLiveScreenState();
}

class _CreateLiveScreenState extends State<CreateLiveScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('abc'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              "You have pushed ' the button this many times:",
            ),
          ],
        ),
      ),
    );
  }
}
