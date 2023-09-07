import 'package:flutter/material.dart';
import 'homeScreen.dart';
import 'counter.dart';
import 'addContent.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      themeMode: ThemeMode.light,
      home: MyHomePage(title: 'Főmenü'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: HomeScreen(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddContent(),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColorDark,
        foregroundColor: Theme.of(context).cardColor,
      ),
    );
  }
}
