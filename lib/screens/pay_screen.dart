import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:railway_ticketing/screens/qr_screen.dart';

import '../widgets/menu_widget.dart';
import 'navigation/navigation_drawer_screen.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({Key? key}) : super(key: key);

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Payment Page'),
        leading: MenuWidget(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rs.20.00',
              style: TextStyle(fontSize: 40), // Increase the text size
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: () {
                createCustomer();
                showSuccessDialog(context);
              },
              style: TextButton.styleFrom(
                textStyle: TextStyle(fontSize: 25),
                backgroundColor: Colors.teal,
                minimumSize: Size(150, 60),
                primary: Colors.white, // Set the text color to white
              ),
              child: Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> createCustomer() async {
  final url = Uri.parse('https://api.stripe.com/v1/customers');
  final headers = {
    'Authorization': 'Bearer sk_test_51NKjiIIcjSAPVFhWYqjT7fT6DTxNk3Fo7rfaBlrcqm6SVcdcAZ0PzKMmKTWw5y0zzhXnnWKfFwXCzfd9pc65CN5z0007xCmZV6',
  };
  final body = {
    'description': 'My First Test Customer',
    'name': 'Himashi',
    'payment_method': 'pm_card_visa',
  };

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    // Customer created successfully
    final responseData = jsonDecode(response.body);
    final customerId = responseData['id'];
    print('Customer created with ID: $customerId');

    // Create payment method
    await createPaymentMethod(customerId);
  } else {
    // Error creating customer
    print('Failed to create customer. Error: ${response.statusCode}');
  }
}

Future<void> createPaymentMethod(String customerId) async {
  final url = Uri.parse('https://api.stripe.com/v1/payment_methods');
  final headers = {
    'Authorization': 'Bearer sk_test_51NKjiIIcjSAPVFhWYqjT7fT6DTxNk3Fo7rfaBlrcqm6SVcdcAZ0PzKMmKTWw5y0zzhXnnWKfFwXCzfd9pc65CN5z0007xCmZV6',
  };
  final body = {
    'type': 'card',
    'card[token]': 'tok_visa', // Use the test token here
    'billing_details[name]': 'John Doe', // Add the name of the cardholder
  };

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    // Payment method created successfully
    final responseData = jsonDecode(response.body);
    final paymentMethodId = responseData['id'];
    print('Payment method created with ID: $paymentMethodId');

    // Attach payment method to customer
    await attachPaymentMethodToCustomer(paymentMethodId, customerId);
  } else {
    // Error creating payment method
    print('Failed to create payment method. Error: ${response.statusCode}');
  }
}


Future<void> attachPaymentMethodToCustomer(String paymentMethodId, String customerId) async {
  final url = Uri.parse('https://api.stripe.com/v1/payment_methods/$paymentMethodId/attach');
  final headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Bearer sk_test_51NKjiIIcjSAPVFhWYqjT7fT6DTxNk3Fo7rfaBlrcqm6SVcdcAZ0PzKMmKTWw5y0zzhXnnWKfFwXCzfd9pc65CN5z0007xCmZV6',
  };
  final body = {
    'customer': customerId,
  };

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    // Payment method attached to customer successfully
    print('Payment method attached to customer');
    // Create payment intent
    await createPaymentIntent(customerId);
  } else {
    // Error attaching payment method to customer
    print('Failed to attach payment method to customer. Error: ${response.statusCode}');
  }
}

Future<void> createPaymentIntent(String customerId) async {
  final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
  final headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Bearer sk_test_51NKjiIIcjSAPVFhWYqjT7fT6DTxNk3Fo7rfaBlrcqm6SVcdcAZ0PzKMmKTWw5y0zzhXnnWKfFwXCzfd9pc65CN5z0007xCmZV6',
  };
  final body = {
    'amount': '2000',
    'currency': 'aud',
    'customer': customerId,
  };

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    // Payment intent created successfully
    final responseData = jsonDecode(response.body);
    final paymentIntentId = responseData['id'];
    print('Payment intent created with ID: $paymentIntentId');

    // Confirm payment intent
    await confirmPaymentIntent(paymentIntentId);
  } else {
    // Error creating payment intent
    print('Failed to create payment intent. Error: ${response.statusCode}');
  }
}

Future<void> confirmPaymentIntent(String paymentIntentId) async {
  final url = Uri.parse('https://api.stripe.com/v1/payment_intents/$paymentIntentId/confirm');
  final headers = {
    'Authorization': 'Bearer sk_test_51NKjiIIcjSAPVFhWYqjT7fT6DTxNk3Fo7rfaBlrcqm6SVcdcAZ0PzKMmKTWw5y0zzhXnnWKfFwXCzfd9pc65CN5z0007xCmZV6',
  };
  final body = {
    'payment_method': 'pm_card_visa',
    'return_url': 'http://example.com',
  };

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    // Payment intent confirmed successfully
    print('Payment intent confirmed');
  } else {
    // Error confirming payment intent
    print('Failed to confirm payment intent. Error: ${response.statusCode}');
  }
}


void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Success'),
        content: const Text('Successfully pain to the ticket.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NavigationDrawerScreen()),
              );
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}