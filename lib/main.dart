import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'User Account Profile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //controller
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  Future<void> _loadProfile() async{
    final prefs = await SharedPreferences.getInstance();
    _nameCtrl.text = prefs.getString('name')?? "";
    _emailCtrl.text = prefs.getString('email')?? "";
  }

  Future<void> _updateProfile() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameCtrl.text);
    await prefs.setString('email', _emailCtrl.text);
  }

  @override
  void initState(){
    _loadProfile();
    super.initState();
  }

  @override
  void dispose(){
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.name,
                controller: _nameCtrl,
                decoration:InputDecoration(
                    labelText: 'Name'
                ),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailCtrl,
                decoration:InputDecoration(
                    labelText: 'Email'
                ),
              ),
              Expanded(child: SizedBox()),
              ElevatedButton(
                  onPressed: _updateProfile,
                  child: Text('Update')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
