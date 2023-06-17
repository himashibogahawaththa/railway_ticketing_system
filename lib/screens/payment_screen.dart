import 'package:flutter/material.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/menu_widget.dart';
import 'package:crypto/crypto.dart';

//MzIwNDQ4NDAzOTQyNDY0MDIwMjUzNTg3NTIzNTYwMzgwMDU4NDY1NA==                   secret
//Authorization code                     NE9WeE1QZ01HUEk0SkREU2JYeVBSbzNQVjo0amxUeHpzVFppUDRmU2RxTE8zc29lNFVyUEtaUFhZcmc0cDVsMklBTkpRYw==

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  void initState() {
    super.initState();
    // initPlatformState();
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

  void startOneTimePayment(BuildContext context) async {
    Map paymentObject = {
      "sandbox": true, // true if using Sandbox Merchant ID
      "merchant_id": "1223304", // Replace your Merchant ID
      "merchant_secret": "MzIwNDQ4NDAzOTQyNDY0MDIwMjUzNTg3NTIzNTYwMzgwMDU4NDY1NA==",
      "notify_url": "https://ent13zfovoz7d.x.pipedream.net/",
      "order_id": "ItemNo12345",
      "items": "Hello from Flutter!",
      "item_number_1": "001",
      "item_name_1": "Test Item #1",
      "amount_1": "5.00",
      "quantity_1": "2",
      "item_number_2": "002",
      "item_name_2": "Test Item #2",
      "amount_2": "20.00",
      "quantity_2": "1",
      "amount": 30.00,
      "currency": "LKR",
      "first_name": "Saman",
      "last_name": "Perera",
      "email": "samanp@gmail.com",
      "phone": "0771234567",
      "address": "No.1, Galle Road",
      "city": "Colombo",
      "country": "Sri Lanka",
      "delivery_address": "No. 46, Galle road, Kalutara South",
      "delivery_city": "Kalutara",
      "delivery_country": "Sri Lanka",
      "custom_1": "",
      "custom_2": ""
    };

    PayHere.startPayment(paymentObject, (paymentId) {
      print("One Time Payment Success. Payment Id: $paymentId");
      showAlert(context, "Payment Success!", "Payment Id: $paymentId");
    }, (error) {
      print("One Time Payment Failed. Error: $error");
      showAlert(context, "Payment Failed", "$error");
    }, () {
      print("One Time Payment Dismissed");
      showAlert(context, "Payment Dismissed", "");
    });
  }

  void startRecurringPayment(BuildContext context) async {
    Map paymentObject = {
      "sandbox": true, // true if using Sandbox Merchant ID
      "merchant_id": "1223304", // Replace your Merchant ID
      "merchant_secret": "MzIwNDQ4NDAzOTQyNDY0MDIwMjUzNTg3NTIzNTYwMzgwMDU4NDY1NA==",
      "notify_url": "https://ent13zfovoz7d.x.pipedream.net/",
      "order_id": "ItemNo12345",
      "items": "Hello from Flutter!",
      "item_number_1": "001",
      "item_name_1": "Test Item #1",
      "amount_1": 50.00,
      "quantity_1": "1",
      "item_number_2": "002",
      "item_name_2": "Test Item #1",
      "amount_2": "25.00",
      "quantity_2": "2",
      "amount": 100.00,
      "recurrence": "1 Month", // Recurring payment frequency
      "duration": "1 Year", // Recurring payment duration
      "currency": "LKR",
      "first_name": "Saman",
      "last_name": "Perera",
      "email": "samanp@gmail.com",
      "phone": "0771234567",
      "address": "No.1, Galle Road",
      "city": "Colombo",
      "country": "Sri Lanka",
      "delivery_address": "No. 46, Galle road, Kalutara South",
      "delivery_city": "Kalutara",
      "delivery_country": "Sri Lanka",
      "custom_1": "",
      "custom_2": ""
    };

    PayHere.startPayment(paymentObject, (paymentId) {
      print("Recurring Payment Success. Payment Id: $paymentId");
      showAlert(context, "Payment Success!", "Payment Id: $paymentId");
    }, (error) {
      print("Recurring Payment Failed. Error: $error");
      showAlert(context, "Payment Failed", "$error");
    }, () {
      print("Recurring Payment Dismissed");
      showAlert(context, "Payment Dismissed", "");
    });
  }

  void startTokenizationPayment(BuildContext context, { bool setAmount = false }) async {
    Map paymentObject = {
      "sandbox": true, // true if using Sandbox Merchant ID
      "merchant_id": "1223304", // Replace your Merchant ID
      "merchant_secret": "MzIwNDQ4NDAzOTQyNDY0MDIwMjUzNTg3NTIzNTYwMzgwMDU4NDY1NA==",
      "preapprove": true, // Required
      "notify_url": "https://ent13zfovoz7d.x.pipedream.net/",
      "order_id": "ItemNo12345",
      "items": "Hello from Flutter!",
      "currency": "LKR",
      "first_name": "Saman",
      "last_name": "Perera",
      "email": "samanp@gmail.com",
      "phone": "0771234567",
      "address": "No.1, Galle Road",
      "city": "Colombo",
      "country": "Sri Lanka",
    };

    if (setAmount){
      paymentObject['amount'] = '30.00';
    }

    PayHere.startPayment(paymentObject, (paymentId) {
      print("Tokenization Payment Success. Payment Id: $paymentId");
      showAlert(context, "Payment Success!", "Payment Id: $paymentId");
    }, (error) {
      print("Tokenization Payment Failed. Error: $error");
      showAlert(context, "Payment Failed", "$error");
    }, () {
      print("Tokenization Payment Dismissed");
      showAlert(context, "Payment Dismissed", "");
    });
  }

  void startHoldOnCardPayment(BuildContext context) async {
    Map paymentObject = {
      "sandbox": true, // true if using Sandbox Merchant ID
      "authorize": true, // Required
      "merchant_id": "1223304", // Replace your Merchant ID
      "notify_url": "https://ent13zfovoz7d.x.pipedream.net/",
      "order_id": "ItemNo12345",
      "items": "Hello from Flutter!",
      "currency": "LKR",
      "item_number_1": "001",
      "item_name_1": "Test Item #1",
      "amount_1": "15.00",
      "quantity_1": "2",
      "item_number_2": "002",
      "item_name_2": "Test Item #2",
      "amount_2": "20.00",
      "quantity_2": "1",
      "amount": "50.00",
      "first_name": "Saman",
      "last_name": "Perera",
      "email": "samanp@gmail.com",
      "phone": "0771234567",
      "address": "No.1, Galle Road",
      "city": "Colombo",
      "country": "Sri Lanka",
    };

    PayHere.startPayment(paymentObject, (paymentId) {
      print("Hold-on-Card Payment Success.");
      showAlert(context, "Payment Success!", "");
    }, (error) {
      print("Hold-on-Card Payment Failed. Error: $error");
      showAlert(context, "Payment Failed", "$error");
    }, () {
      print("Hold-on-Card Payment Dismissed");
      showAlert(context, "Payment Dismissed", "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Payment Page'),
        leading: MenuWidget(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  startOneTimePayment(context);
                },
                child: Text('Start One Time Payment!')),
            TextButton(
                onPressed: () {
                  startRecurringPayment(context);
                },
                child: Text('Start Recurring Payment!')),
            TextButton(
                onPressed: () {
                  startTokenizationPayment(context);
                  retrieveAccessToken();
                  makePreapprovalRequest();
                },
                child: Text('Start Tokenization Payment!')),
            TextButton(
                onPressed: () {
                  startTokenizationPayment(context, setAmount: true);
                },
                child: Text('Start Tokenization Payment (with amount)!')),
            TextButton(
                onPressed: () {
                  startHoldOnCardPayment(context);
                },
                child: Text('Start Hold on Card Payment!')),
          ],
        ),
      ),
    );
  }

  void retrieveAccessToken() async {
    final url = 'https://sandbox.payhere.lk/merchant/v1/oauth/token';
    final authorizationCode = 'NE9WeE1QZ01HUEk0SkREU2JYeVBSbzNQVjo0amxUeHpzVFppUDRmU2RxTE8zc29lNFVyUEtaUFhZcmc0cDVsMklBTkpRYw==';

    debugPrint('Access token: pass', wrapWidth: 100);

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic $authorizationCode',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: jsonEncode({'grant_type': 'client_credentials'}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final accessToken = data['access_token'];
      final tokenType = data['token_type'];
      final expiresIn = data['expires_in'];
      final scope = data['scope'];

      // Use the retrieved access_token for further requests
      debugPrint('Access token: $accessToken');
    } else {
      debugPrint('Failed to retrieve access token. Error: ${response.statusCode}');
    }
  }

  //------------PreapprovalRequest---------------//

  Future<void> makePreapprovalRequest() async {
    final url = Uri.parse('https://sandbox.payhere.lk/pay/preapprove');

    final response = await http.post(url, body: {
      'merchant_id': '1223304',
      'return_url': 'http://sample.com/return',
      'cancel_url': 'http://sample.com/cancel',
      'notify_url': 'http://sample.com/notify',
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
      'card_holder_name': 'Himashi',
      'card_no': '4916217501611292',
      'card_expiry': '05/25',
      'hash': generateHash("1223304", 'Preapproval12345', 10.0, 'LKR',
      'MzIwNDQ4NDAzOTQyNDY0MDIwMjUzNTg3NTIzNTYwMzgwMDU4NDY1NA=='), // Replace with your generated hash
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

