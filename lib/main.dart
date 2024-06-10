import 'package:flutter/material.dart';
import 'package:mad_final_exam/home.dart';
import 'package:mad_final_exam/login.dart';
import 'package:mad_final_exam/profile.dart';
import 'package:mad_final_exam/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/home',
      routes: {
        '/login':(BuildContext context) => const Login() ,
        '/home':(BuildContext context) => const Home() ,
         '/to_do':(BuildContext context) => const TodoScreen() ,
          '/profile':(BuildContext context) => const Profile() ,}
    );
  }
}

