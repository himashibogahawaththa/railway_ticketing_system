import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:railway_ticketing/models/Passenger.dart';
import 'package:railway_ticketing/screens/trainScreen.dart';
import 'package:railway_ticketing/screens/train_schedule_screen.dart';
import '../widgets/menu_widget.dart';
import 'add_payment_card_screen.dart';
import 'booking.dart';
import 'booking_screen.dart';
import 'card_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _greeting = '';
  String _userName = '';

  final user = FirebaseAuth.instance.currentUser;



  @override
  void initState() {
    super.initState();
    _setGreeting();
    _getUserName();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    debugPrint('nameeeewwww $_userName', wrapWidth: 100);

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(title:const Text("Smart Train"),leading: const MenuWidget(),),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/images/home_train.png",
                fit: BoxFit.cover,
              ),
              Container(
                margin: EdgeInsets.all(25),
                child: Column(
                  children: [
                    Text(
                      _greeting,
                      style: const TextStyle(
                        fontSize: 35,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black54
                      ),
                    ),
                    const SizedBox(height: 10,),
                    FutureBuilder<String>(
                        future: _getUserName(),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          return Text(
                            _userName,
                            style: const TextStyle(
                                fontSize: 16
                            ),
                          );
                        }
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 400),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBFCFC),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 23,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
              ),
              Container(
                width: 428,
                height: 200,
                margin: const EdgeInsets.only(top: 200),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.3154, 0.6349, 0.8203],
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Color.fromRGBO(255, 255, 255, 0.680914),
                      Colors.white,
                    ],
                  ),
                ),
              ),
            ]
          ),
          Container(
            margin: const EdgeInsets.only(left: 25,right: 25),
            child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 75,
                              width: 90,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  TrainScreen()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.train,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Train')
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 75,
                              width: 90,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  BookingScreen()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.airplane_ticket,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Tickets')
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 75,
                              width: 90,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  TrainScheduleScreen()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.schedule,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Schedule')
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 75,
                              width: 90,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  BookingScreen()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.transfer_within_a_station,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Stations')
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 75,
                              width: 90,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CardScreen()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.card_giftcard,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('My Cards')
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 75,
                              width: 90,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TicketDataScreen()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.notifications,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        'Notifications',
                                      style: TextStyle(
                                        fontSize: 12
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]
            ),
          ),
        ],
      ),
    );
  }

  void _setGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      setState(() {
        _greeting = 'Good Morning!';
      });
    } else if (hour < 18) {
      setState(() {
        _greeting = 'Good Afternoon!';
      });
    } else {
      setState(() {
        _greeting = 'Good Evening!';
      });
    }
  }

Future<String> _getUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user!.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference documentRef = firestore.collection('Passengers').doc(userId);

    debugPrint('nameeee $userId', wrapWidth: 100);
    DocumentSnapshot snapshot = await documentRef.get();

    if (snapshot.exists) {
      debugPrint('nameeee exxxxx', wrapWidth: 100);
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Access the fields of the document using the 'data' map
      _userName = data['name'];
      debugPrint('nameeee $_userName', wrapWidth: 100);
      return _userName;

    } else {
      print('Document does not exist');
      return ("Passenger name not exist");
    }
  }
}


