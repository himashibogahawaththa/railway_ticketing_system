import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:railway_ticketing/screens/fingerprint_screen.dart';
import 'package:railway_ticketing/screens/pay_screen.dart';

class TicketDataScreen extends StatefulWidget {
  const TicketDataScreen({Key? key}) : super(key: key);

  @override
  _TicketDataScreenState createState() => _TicketDataScreenState();
}

class _TicketDataScreenState extends State<TicketDataScreen> {
  TextEditingController departureStationController = TextEditingController();
  TextEditingController arrivalStationController = TextEditingController();
  TextEditingController trainController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController ticketClassController = TextEditingController();
  TextEditingController seatController = TextEditingController();
  TextEditingController passengersController = TextEditingController();

  @override
  void dispose() {
    departureStationController.dispose();
    arrivalStationController.dispose();
    trainController.dispose();
    dateController.dispose();
    timeController.dispose();
    ticketClassController.dispose();
    seatController.dispose();
    passengersController.dispose();
    super.dispose();
  }

  Future<void> submitTicketData() async {
    // Get the entered data from the text controllers
    String departureStation = departureStationController.text;
    String arrivalStation = arrivalStationController.text;
    String train = trainController.text;
    String date = dateController.text;
    String time = timeController.text;
    String ticketClass = ticketClassController.text;
    String seat = seatController.text;
    String passengers = passengersController.text;

    // Get the current user's UID
    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

    try {
      // Save the ticket data to Firestore
      await FirebaseFirestore.instance.collection('Ticket').doc(currentUserUid).set({
        'departureStation': departureStation,
        'arrivalStation': arrivalStation,
        'train': train,
        'date': date,
        'time': time,
        'ticketClass': ticketClass,
        'seat': seat,
        'passengers': passengers,
      });

      // Reset the text fields
      departureStationController.clear();
      arrivalStationController.clear();
      trainController.clear();
      dateController.clear();
      timeController.clear();
      ticketClassController.clear();
      seatController.clear();
      passengersController.clear();

      // Show a success message or navigate to another screen
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Ticket data saved successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      // Handle any errors that occur during the data saving process
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to save ticket data. Error: $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  FingerprintScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Ticket Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Departure Station:'),
              TextField(
                controller: departureStationController,
              ),
              const SizedBox(height: 10),
              const Text('Arrival Station:'),
              TextField(
                controller: arrivalStationController,
              ),
              const SizedBox(height: 10),
              const Text('Train:'),
              TextField(
                controller: trainController,
              ),
              const SizedBox(height: 10),
              const Text('Date:'),
              TextField(
                controller: dateController,
              ),
              const SizedBox(height: 10),
              const Text('Time:'),
              TextField(
                controller: timeController,
              ),
              const SizedBox(height: 10),
              const Text('Ticket Class:'),
              TextField(
                controller: ticketClassController,
              ),
              const SizedBox(height: 10),
              const Text('Seat:'),
              TextField(
                controller: seatController,
              ),
              const SizedBox(height: 10),
              const Text('Passengers:'),
              TextField(
                controller: passengersController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitTicketData,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

