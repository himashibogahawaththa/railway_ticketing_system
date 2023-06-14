import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:railway_ticketing/models/Passenger.dart';
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
  final _userNameController = TextEditingController();
  final _nicController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _nicController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
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
                    padding: const EdgeInsets.all(20),
                    child: const Center(
                      child: Text(
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
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: Container(
                      padding: const EdgeInsets.only(top: 100),
                      child: Column(
                        children: [
                          fullNameInput(),
                          const SizedBox(
                            height: 10,
                          ),
                          UserNameInput(),
                          const SizedBox(
                            height: 10,
                          ),
                          nicInput(),
                          const SizedBox(
                            height: 10,
                          ),
                          passwordInput(),
                          const SizedBox(
                            height: 10,
                          ),
                          confirmPasswordInput(),
                          const SizedBox(
                            height: 10,
                          ),
                          emailInput(),
                          const SizedBox(
                            height: 10,
                          ),
                          phoneNumberInput(),
                          const SizedBox(
                            height: 30,
                          ),
                          signUpButton(),
                          const SizedBox(
                            height: 30,
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
                            height: 30,
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

  Container phoneNumberInput() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(13, 16, 14, 0.03),
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: const Color(0xFF279B8D)),
      ),
      child: TextFormField(
        controller: _phoneNumberController,
        keyboardType: TextInputType.phone, // Set the keyboard type to phone
        decoration: const InputDecoration(
          border: InputBorder.none,
          labelText: 'Phone Number',
          labelStyle: TextStyle(
            color: Colors.black38,
          ),
          hintText: "Enter your phone number",
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black38,
          ),
          icon: Icon(Icons.phone, color: Colors.teal),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (phoneNumber) {
          // Add your validation logic for the phone number
          // Return an error message if the phone number is invalid
          if (phoneNumber == null || phoneNumber.isEmpty) {
            return 'Phone number is required';
          }
          // You can add additional validation logic here if needed
          return null; // Return null if the phone number is valid
        },
      ),
    );
  }

  Container nicInput() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(13, 16, 14, 0.03),
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: const Color(0xFF279B8D)),
      ),
      child: TextFormField(
        controller: _nicController,
        keyboardType: TextInputType.number, // Set the keyboard type to phone
        decoration: const InputDecoration(
          border: InputBorder.none,
          labelText: 'NIC',
          labelStyle: TextStyle(
            color: Colors.black38,
          ),
          hintText: "Enter your National Identity Card number",
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black38,
          ),
          icon: Icon(Icons.credit_card, color: Colors.teal),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (nic) {
          // Add your validation logic for the phone number
          // Return an error message if the phone number is invalid
          if (nic == null || nic.isEmpty) {
            return 'NIC is required';
          }
          // You can add additional validation logic here if needed
          return null; // Return null if the phone number is valid
        },
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
            icon: Icon(Icons.email, color: Colors.teal,)
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

  Container UserNameInput() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(13, 16, 14, 0.03),
          borderRadius: const BorderRadius.all(
              Radius.circular(25)
          ),
          border: Border.all(
            color: const Color(0xFF279B8D),
          )
      ),
      child: TextField(
        controller: _userNameController,
        decoration: const InputDecoration(
            border: InputBorder.none,
            labelText: 'Username',
            labelStyle: TextStyle(
              color: Colors.black38,
            ),
            hintText: "Enter your username",
            hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.black38
            ),
            icon: Icon(Icons.person, color: Colors.teal,)
        ),
      ),
    );
  }

  Container fullNameInput() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(13, 16, 14, 0.03),
          borderRadius: const BorderRadius.all(
              Radius.circular(25)
          ),
          border: Border.all(
            color: const Color(0xFF279B8D),
          )
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
    String name = _nameController.text.trim();
    String username = _userNameController.text.trim();
    String nic = _nicController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();

    Passenger passenger = Passenger(
      id: '',
      name: name,
      username: username,
      nic: nic,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    );

    try {
      // Create the user in Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user's UID
      String uid = userCredential.user!.uid;

      // Use the UID as the document ID in Firestore
      DocumentReference documentRef = FirebaseFirestore.instance.collection("Passengers").doc(uid);

      // Set the document data
      await documentRef.set(passenger.toMap());

      print('xxxxxxxFirebase Authentication UID: $uid');
      print('xxxxxxxFirestore Document ID: ${documentRef.id}');

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } catch (e) {
      print(e);
    }
  }

}
