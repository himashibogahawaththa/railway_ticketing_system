import 'package:flutter/material.dart';
import 'package:railway_ticketing/screens/auth/login.dart';
import 'package:railway_ticketing/screens/auth/registrer.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginScreen(onClickedSignUp: toggle)
      : RegisterScreen(onClickedSignUp: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
