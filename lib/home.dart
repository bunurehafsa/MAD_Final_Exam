import 'package:flutter/material.dart';
import 'package:mad_final_exam/common/navigation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blueGrey.shade300,
      ),
      body: Center(
        
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
