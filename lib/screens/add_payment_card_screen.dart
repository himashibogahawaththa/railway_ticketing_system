import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

import '../controller/auth_controller.dart';
import '../widgets/green_intro_widget.dart';
import 'card_screen.dart';


class AddPaymentCardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddPaymentCardScreenState();
  }
}


class AddPaymentCardScreenState extends State<AddPaymentCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String customer_token = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Add Payment Card'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          greenIntroWidgetWithoutLogos(title: 'Add Card'),


          Column(

            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                bankName: 'Axis Bank',
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: Colors.black,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange:
                    (CreditCardBrand creditCardBrand) {},
                customCardTypeIcons: <CustomCardTypeIcon>[

                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: Colors.blue,
                        textColor: Colors.black,
                        cardNumberDecoration: InputDecoration(
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          hintStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        expiryDateDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Card Holder',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      const SizedBox(
                        height: 20,
                      ),



                      ElevatedButton(
                        style: ElevatedButton.styleFrom(

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          primary: Colors.teal
                          // backgroundColor: const Color(0xff1b447b),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'halter',
                              fontSize: 14,
                              package: 'flutter_credit_card',
                            ),
                          ),
                        ),
                        onPressed: ()async {
                          if (formKey.currentState!.validate()) {
                            debugPrint('valid!');

                            makePreapprovalRequest(cardNumber, expiryDate, cvvCode, cardHolderName,);
                            retrieveAccessToken(cardNumber, expiryDate, cvvCode, cardHolderName);

                            Get.snackbar('Success', 'Your card is stored successfully');

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CardScreen()),
                            );

                          } else {
                            debugPrint('invalid!');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  void retrieveAccessToken(String card_no, String card_expiry, String cvvCode, String card_holder_name) async {
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

      await Get.find<AuthController>().storeUserCard(cardNumber, expiryDate,
          cvvCode, cardHolderName, accessToken, tokenType, expiresIn, scope, customer_token);

    } else {
      debugPrint('Failed to retrieve access token. Error: ${response.statusCode}');
    }
  }

  //------------PreapprovalRequest---------------//

  Future<void> makePreapprovalRequest(String card_no, String card_expiry, String cvvCode, String card_holder_name) async {
    final url = Uri.parse('https://sandbox.payhere.lk/pay/preapprove');
    String customer_token = generateHash("1223304", 'Preapproval12345', 10.0, 'LKR',
        'MzIwNDQ4NDAzOTQyNDY0MDIwMjUzNTg3NTIzNTYwMzgwMDU4NDY1NA==');

    final response = await http.post(url, body: {
      'merchant_id': '1223304',
      'return_url': 'http://sample.com/return',
      'cancel_url': 'http://sample.com/cancel',
      'notify_url': 'https://sandbox.payhere.lk/merchant/subscriptions',
      'first_name': 'Saman',
      'last_name': 'Perera',
      'email': 'samanp@gmail.com',
      'phone': '0771234567',
      'address': 'No.1, Galle Road',
      'city': 'Colombo',
      'country': 'Sri Lanka',
      'order_id': 'Preapproval12345',
      'items': 'MyTaxi Hires',
      'currency': 'LKR',
      'method': 'VISA',
      'card_holder_name': card_holder_name,
      'card_no': card_no,
      'card_expiry': card_expiry,
      'cvv': cvvCode,
      'hash': customer_token, // Replace with your generated hash
    });

    if (response.statusCode == 200) {
      // Handle the successful response
      debugPrint('Preapproval request success');
    } else {
      // Handle the error
      debugPrint('Preapproval request failed');
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