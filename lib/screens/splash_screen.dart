import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'auth/auth_page.dart';
import 'navigation/navigation_drawer_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top
    ]);
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    StreamBuilder<User?>(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }else if(snapshot.hasError){
                          return const Center(
                            child: Text(
                              "Something went wrong!"
                            ),
                          );
                        }else if(snapshot.hasData){
                          return const NavigationDrawerScreen();
                        }
                        else{
                          return const AuthPage();
                        }
                      },
                    ),
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/splash_back.png",
          fit: BoxFit.cover,
        ),
        Center(
          child: Image.asset(
            "assets/images/splash_logo.png",
          ),
        ),
      ]
    );
  }
}
