import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:railway_ticketing/screens/auth/login.dart';
import 'package:railway_ticketing/screens/home_screen.dart';

import '../../main.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const RegisterScreen({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    child: const Text(
                      "Sign up to become a member",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(39, 155, 141, 0.88),
                        fontSize: 20,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: Container(
                      padding: const EdgeInsets.only(top: 150),
                      child: Column(
                        children: [
                          fullNameInput(),
                          const SizedBox(
                            height: 20,
                          ),
                          emailInput(),
                          const SizedBox(
                            height: 20,
                          ),
                          passwordInput(),
                          const SizedBox(
                            height: 20,
                          ),
                          confirmPasswordInput(),
                          const SizedBox(
                            height: 50,
                          ),
                          signUpButton(),
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            "By signing up for an account you agree to our ",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                            },
                            child: const Text(
                              "Terms and Conditions",
                              style: TextStyle(
                                color: Color.fromRGBO(39, 155, 141, 0.88),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Already have an account?",
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = widget.onClickedSignUp,
                                    text: " Login",
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

  ElevatedButton signUpButton() {
    return ElevatedButton(
                          onPressed: signUp,
                          //     () {
                          //   Navigator.push(context,MaterialPageRoute(builder: (context) =>const HomeScreen()));
                          // },
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(
                                  39, 155, 141, 0.88),
                              padding: const EdgeInsets.only(
                                  top: 15, bottom: 15, left: 50, right: 50),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(25))
                              )
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),
                          ),
                        );
  }

  Container confirmPasswordInput() {
    return Container(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(13, 16, 14, 0.03),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(25)),
                              border: Border.all(
                                color: const Color(0xFF279B8D),)
                          ),
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            obscuringCharacter: "*",
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                color: Colors.black38,
                              ),
                              hintText: "Enter confirm password",
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black38
                              ),
                              icon: Icon(Icons.lock, color: Colors.teal,),
                            ),
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            validator: (value) =>
                            value != null && value.length < 6
                                ? 'Confirm the password'
                                : null,

                          ),
                        );
  }

  Container passwordInput() {
    return Container(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(13, 16, 14, 0.03),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(25)),
                              border: Border.all(
                                color: const Color(0xFF279B8D),)
                          ),
                          child: TextFormField(
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
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            validator: (value) =>
                            value != null && value.length < 6
                                ? 'Enter min. 6 characters'
                                : null,
                          ),
                        );
  }

  Container emailInput() {
    return Container(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(13, 16, 14, 0.03),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(25)),
                              border: Border.all(
                                color: const Color(0xFF279B8D),)
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: Colors.black38,
                                ),
                                hintText: "Enter your email",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black38
                                ),
                                icon: Icon(Icons.person, color: Colors.teal,)
                            ),
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Enter a valid email'
                                : null,
                          ),
                        );
  }

  Container fullNameInput() {
    return Container(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(13, 16, 14, 0.03),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(25)),
                              border: Border.all(
                                color: const Color(0xFF279B8D),)
                          ),
                          child: TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Full Name',
                                labelStyle: TextStyle(
                                  color: Colors.black38,
                                ),
                                hintText: "Enter your full name",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black38
                                ),
                                icon: Icon(Icons.person, color: Colors.teal,)
                            ),
                          ),
                        );
  }

  Future signUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator(),));

    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
      );
    }
    on FirebaseAuthException catch(e){
      print(e);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
