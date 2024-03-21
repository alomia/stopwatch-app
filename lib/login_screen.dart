import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch/stopwatch.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String name = "";

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: _buildLoginForm(),
      ),
    );
  }

  _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Runner"),
              validator: (text) =>
                  text!.isEmpty ? "Enter the runner's name." : null,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: "Email"),
              validator: (text) {
                if (text!.isEmpty) {
                  return "Enter the runner's email.";
                }

                final regex = RegExp("[^@]+@[^.]+..+");
                if (!regex.hasMatch(text)) {
                  return "Enter a valid email";
                }

                return null;
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _validate,
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }

  void _validate() {
    final form = _formKey.currentState;
    if (form?.validate() == false) {
      return;
    }

    final String name = _nameController.text;
    final String email = _emailController.text;

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => StopWatch(name: name, email: email),
    ));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
