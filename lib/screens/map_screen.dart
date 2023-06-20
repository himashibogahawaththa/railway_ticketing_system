import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Realtime Latitude and Longitude'),
        ),
        // body: StreamBuilder<Event<DataSnapshot>>(
        //   stream: databaseReference.child('location').onValue,
        //   builder: (BuildContext context, AsyncSnapshot<Event<DataSnapshot>> snapshot) {
        //     if (snapshot.hasData) {
        //       final latitude = snapshot.data!.snapshot.value['latitude'];
        //       final longitude = snapshot.data!.snapshot.value['longitude'];
        //
        //       return Center(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text(
        //               'Latitude: $latitude',
        //               style: TextStyle(fontSize: 20),
        //             ),
        //             Text(
        //               'Longitude: $longitude',
        //               style: TextStyle(fontSize: 20),
        //             ),
        //           ],
        //         ),
        //       );
        //     }
        //     return Center(child: CircularProgressIndicator());
        //   },
        // ),
      ),
    );
  }
}
