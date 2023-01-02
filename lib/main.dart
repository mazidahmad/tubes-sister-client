import 'package:flutter/material.dart';
import 'package:train_dashboard/page/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Kereta Api',
      theme: ThemeData(
        backgroundColor: Colors.black87,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black87,
      ),
      home: const DashboardPage(),
    );
  }
}
