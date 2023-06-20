import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/menu_widget.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

//MzIwNDQ4NDAzOTQyNDY0MDIwMjUzNTg3NTIzNTYwMzgwMDU4NDY1NA==                   secret
//Authorization code            NE9WeE1QZ01HUEk0SkREU2JYeVBSbzNQVjo0amxUeHpzVFppUDRmU2RxTE8zc29lNFVyUEtaUFhZcmc0cDVsMklBTkpRYw==


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? userId;
  String accessToken = '';
  String customerToken = '';

  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    authController.getUserCards();
    super.initState();
    getCurrentUser();
    // initPlatformState();
  }

  Future<void> getCurrentUser() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
      accessToken = (await getAccessToken(userId))!;
      customerToken = (await getCustomerToken(userId!))!;
      setState(() {
        // Update the state with the retrieved accessToken
      });
    }
  }

  void showAlert(BuildContext context, String title, String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
            TextButton(
                onPressed: () {
                  print('accessToken: $accessToken, customerToken:$customerToken');
                  chargeCustomer(accessToken, customerToken);
                },
                child: Text('Start Tokenization Payment (with amount)!')),
          ],
        ),
      ),
    );
  }

  void chargeCustomer(String accessToken, String customerToken) async {
    final url = 'https://sandbox.payhere.lk/merchant/v1/payment/charge';

    print('Entered to charge the customer.');

    final body = {
      "type": "PAYMENT",
      "order_id": "Order12345",
      "items": "Taxi Hire 123",
      "currency": "LKR",
      "amount": 20.67,
      "customer_token": customerToken,
      "hash": customerToken
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final status = data['status'];
      final message = data['msg'];
      final paymentId = data['data']['payment_id'];
      final statusCode = data['data']['status_code'];
      final statusMessage = data['data']['status_message'];
      final md5sig = data['data']['md5sig'];
      final authorizationToken = data['data']['authorization_token'];

      // Process the response data as needed
      print('Status: $status');
      print('Message: $message');
      print('Payment ID: $paymentId');
      print('Status Code: $statusCode');
      print('Status Message: $statusMessage');
      print('MD5 Signature: $md5sig');
      print('Authorization Token: $authorizationToken');
    } else {
      print('Failed to charge the customer. Error: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>?> getCardData(String cardId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userId = currentUser.uid;

      final docSnapshot = await FirebaseFirestore.instance
          .collection('Passengers')
          .doc(userId)
          .collection('Cards')
          .doc(cardId) // Use the cardId parameter here
          .get();

      if (docSnapshot.exists) {
        final cardData = docSnapshot.data() as Map<String, dynamic>;
        return cardData;
      }
    }

    return null; // Return null in case of no data or error
  }

  Future<String?> getAccessToken(String? cardId) async {
    final cardData = await getCardData(cardId!);
    if (cardData != null) {
      final accessToken = cardData['access_token'] as String?;
      return accessToken;
    }
    return null;
  }

  Future<String?> getCustomerToken(String? cardId) async {
    final cardData = await getCardData(cardId!);
    if (cardData != null) {
      final customerToken = cardData['customer_token'] as String?;
      return customerToken;
    }
    return null;
  }

  void retrieveAccessToken() async {
    final url = 'https://sandbox.payhere.lk/merchant/v1/oauth/token';
    final authorizationCode = 'NE9WeE1QZ01HUEk0SkREU2JYeVBSbzNQVjo0amxUeHpzVFppUDRmU2RxTE8zc29lNFVyUEtaUFhZcmc0cDVsMklBTkpRYw==';
    final customer_token = generateHash("1223304", 'Preapproval12345', 10.0, 'LKR',
        'MzIwNDQ4NDAzOTQyNDY0MDIwMjUzNTg3NTIzNTYwMzgwMDU4NDY1NA==');

    final grantType = 'client_credentials';
    final body = {
      'grant_type': grantType,
      'hash': generateHash("1223304", 'Preapproval12345', 10.0, 'LKR',
          'MzIwNDQ4NDAzOTQyNDY0MDIwMjUzNTg3NTIzNTYwMzgwMDU4NDY1NA=='),
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic $authorizationCode',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );


    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final accessToken = data['access_token'];
      final tokenType = data['token_type'];
      final expiresIn = data['expires_in'];
      final scope = data['scope'];

      // Use the retrieved access_token for further requests
      debugPrint('Access token: $accessToken , $tokenType, $expiresIn, $scope');

    } else {
      debugPrint('Failed to retrieve access token. Error: ${response.statusCode}');
    }
  }

  String generateHash(String merchantId, String orderId, double amount, String currency, String merchantSecret) {
    String formattedAmount = amount.toStringAsFixed(2);
    String hashString = merchantId +
        orderId +
        formattedAmount +
        currency +
        md5.convert(utf8.encode(merchantSecret)).toString().toUpperCase();

    String hash = md5.convert(utf8.encode(hashString)).toString().toUpperCase();
    return hash;
  }

}

