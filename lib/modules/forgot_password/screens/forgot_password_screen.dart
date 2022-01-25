import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String? username;
  const ForgotPasswordScreen({Key? key, this.username}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(),
    );
  }
}
