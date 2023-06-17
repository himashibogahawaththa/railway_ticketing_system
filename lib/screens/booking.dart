import 'package:flutter/material.dart';

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
  TextEditingController amountController = TextEditingController();

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
    amountController.dispose();
    super.dispose();
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
              const SizedBox(height: 10),
              const Text('Amount:'),
              TextField(
                controller: amountController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Get the entered data from the text controllers
                  String departureStation = departureStationController.text;
                  String arrivalStation = arrivalStationController.text;
                  String train = trainController.text;
                  String date = dateController.text;
                  String time = timeController.text;
                  String ticketClass = ticketClassController.text;
                  String seat = seatController.text;
                  String passengers = passengersController.text;
                  String amount = amountController.text;

                  // Perform any necessary validations or further processing with the data
                  // Save the data to Firestore or perform any other actions

                  // Reset the text fields
                  departureStationController.clear();
                  arrivalStationController.clear();
                  trainController.clear();
                  dateController.clear();
                  timeController.clear();
                  ticketClassController.clear();
                  seatController.clear();
                  passengersController.clear();
                  amountController.clear();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
