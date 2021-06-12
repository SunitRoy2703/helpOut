import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication_service.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Password",
            ),
          ),
          RaisedButton(
            onPressed: (){
            context.read<AuthenticationService>().signUp(
              emailController.text.trim(), 
              passwordController.text.trim());
          },
            child: Text("Sign up"),
          ),
          RaisedButton(
            onPressed: (){
            context.read<AuthenticationService>().signIn(
              emailController.text.trim(), 
              passwordController.text.trim());
          },
            child: Text("Sign in"),
          )
        ],
      ),
    );
  }
}