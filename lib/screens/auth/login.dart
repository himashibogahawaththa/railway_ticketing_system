import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:railway_ticketing/screens/home_screen.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginScreen({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/login_top.png",
                  fit: BoxFit.cover,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/login_back.png",
                  ),
                ),
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    child: const Text(
                      "Login using your Email and Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  "assets/images/login_last.png",
                  fit: BoxFit.cover,
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: Container(
                      padding: const EdgeInsets.only(top: 200),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(13, 16, 14, 0.03),
                                borderRadius: const BorderRadius.all(Radius
                                    .circular(25)),
                                border: Border.all(color: const Color(
                                    0xFF279B8D),)
                            ),
                            child: TextField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color: Colors.black38,
                                  ),
                                  hintText: "Enter Email",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black38
                                  ),
                                  icon: Icon(Icons.mail, color: Colors.teal,)
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(13, 16, 14, 0.03),
                                borderRadius: const BorderRadius.all(Radius
                                    .circular(25)),
                                border: Border.all(color: const Color(
                                    0xFF279B8D),)
                            ),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              obscuringCharacter: "*",
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  color: Colors.black38,
                                ),
                                hintText: "Enter password",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black38
                                ),
                                icon: Icon(Icons.lock, color: Colors.teal,),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 70,
                          ),

                          ElevatedButton(
                            onPressed: signIn,
                            //   () {
                            //   Navigator.push(context,MaterialPageRoute(builder: (context) =>const HomeScreen()));
                            // },
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(39, 155, 141, 0.88),
                                padding: const EdgeInsets.only(top: 15,
                                    bottom: 15,
                                    left: 50,
                                    right: 50),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25))
                                )
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 70,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Color.fromRGBO(39, 155, 141, 0.88),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Do not have an account yet?",
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                  ..onTap = widget.onClickedSignUp,
                                  text: " Sign Up",
                                  style: const TextStyle(
                                    color: Color.fromRGBO(39, 155, 141, 0.88),
                                  ),
                                ),
                              ]
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator(),));

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()
      );
    }
    on FirebaseAuthException catch(e){
      print(e);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
