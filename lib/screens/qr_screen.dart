import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/ticket.dart';
import '../widgets/menu_widget.dart';

class QRScreen extends StatefulWidget {
  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  Ticket? ticket;

  @override
  void initState() {
    super.initState();
    fetchTicketData();
  }

  Future<void> fetchTicketData() async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Ticket')
          .doc('123456789')
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        ticket = Ticket.fromMap(data);
        setState(() {});
      }
    } catch (e) {
      print('Error fetching ticket data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Ticket'),
        leading: MenuWidget(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (ticket != null)
              QrImage(
                data: ticket!.toMap().toString(),
                version: QrVersions.auto,
                size: 300.0,
              )
            else
              CircularProgressIndicator(),

            SizedBox(height: 30.0),
            Text(
              'Scan this QR code for your ticket',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                if (ticket != null) {
                  validateTicket(ticket!.id);
                }
              },
              child: Text('Validate Ticket'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> validateTicket(String ticketId) async {
    try {
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Ticket')
          .doc(ticketId)
          .get();

      if (documentSnapshot.exists) {
        final bool isValid = documentSnapshot['isValid'];

        if (isValid) {
          // Ticket is valid, update its validity status to false
          await documentSnapshot.reference.update({'isValid': false});
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Ticket Validated'),
              content: Text('The ticket is valid.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Invalid Ticket'),
              content: Text('The ticket has already been used or is invalid.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Ticket Not Found'),
            content: Text('The ticket does not exist.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error validating ticket: $e');
    }
  }
}
