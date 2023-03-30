import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:memeziez/domain/user_model.dart';
import 'package:memeziez/screens/home_page.dart';
import 'package:memeziez/utils/color_schemes.g.dart';
import 'package:http/http.dart' as http;
import 'package:memeziez/utils/urls.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memeziez',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<UserModel?> loginUser() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
      Uri.parse("${URLS.userURL}/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'password': passwordController.text
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      UserModel user = UserModel.fromJson(jsonDecode(response.body));
      debugPrint("${user.username} has logged in.");
      return user;
    } else {
      setState(() {
        isLoading = false;
      });
      debugPrint("Failed to login.");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Memeziez"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/logo.png'),
              fit: BoxFit.scaleDown,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email)
                ),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                  hintText: 'Password',
                    prefixIcon: Icon(Icons.password)
                ),
                controller: passwordController,
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () async {
                UserModel? user = await loginUser();
                if(user!= null){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage(user: user)),
                  );
                }
              },
              child:  Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width/6,
                      vertical: 20),
                  child: isLoading?
                  const CircularProgressIndicator()
                      :
                  const Text("Login")
              ),
            )
          ],
        ),
      ),
    );
  }
}
