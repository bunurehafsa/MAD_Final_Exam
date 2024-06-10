import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:localstorage/localstorage.dart';
import 'loginuser.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String email = '';
  late String password = '';

  //final LocalStorage localStorage = LocalStorage('app');

  Future<void> handleLoginPress() async {
    if (!EmailValidator.validate(email)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Warning!!'),
            icon: Icon(Icons.warning),
            content: Container(
              child: Text('Invalid Email!! Please check your email'),
            ),
          );
        },
      );
      return;
    }

    print('sending login request...');
    Uri uri = Uri.parse('https://task-management-backend-vhcq.onrender.com/api/v1/login');
    var payload = {
      "email": email,
      "password": password,
    };
    http.Response response = await http.post(uri, body: payload);
    print("login status code: ${response.statusCode}");
    print("login response body: ${response.body}");
    dynamic decoded = json.decode(response.body);

    if (response.statusCode == 200 && decoded['data'] != null) {
      LoginUser loginUser = LoginUser.fromJson(decoded['data']);
      print(loginUser.email);
      print(loginUser.firstName);
      print(loginUser.lastName);

      print('token: ${decoded['token']}');
      localStorage.setItem('access-token', decoded['token']);
      Navigator.of(context).pushReplacementNamed('/home');
      print(localStorage.getItem('access-token'));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Login failed. Please try again.'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black12,
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 82, 128, 255),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 35),
            ),
            TextFormField(
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                print('Email: $value');
                setState(() {
                  email = value;
                });
              },
              decoration: const InputDecoration(
                label: Text('Email'),
                icon: Icon(Icons.email),
                hintText: 'Enter Email',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            TextFormField(
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                print('password: $value');
                setState(() {
                  password = value;
                });
              },
              decoration: InputDecoration(
                label: Text('Password'),
                icon: Icon(Icons.key),
                hintText: 'Enter Password',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                handleLoginPress();
              },
              child: Text('Login'),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Don\'t Have an account?'),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pop(MaterialPageRoute(
                //     builder: (context) => const SignupScreen()));
              },
              child: Text('Try Login'),
            )
          ],
        ),
      ),
    );
  }
}
