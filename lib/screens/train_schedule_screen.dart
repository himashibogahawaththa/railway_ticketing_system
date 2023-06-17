import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/menu_widget.dart';

class TrainScheduleScreen extends StatefulWidget {
  const TrainScheduleScreen({Key? key}) : super(key: key);

  @override
  State<TrainScheduleScreen> createState() => _TrainScheduleScreenState();
}

class _TrainScheduleScreenState extends State<TrainScheduleScreen> {
  List<Map<String, String?>> availableTrains = [];

  @override
  void initState() {
    super.initState();
    getTrains();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('trainnn $availableTrains');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Train Schedule'),
        leading: const MenuWidget(),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: availableTrains.isNotEmpty
                  ? ListView.builder(
                itemCount: availableTrains.length,
                itemBuilder: (BuildContext context, int index) {
                  final train = availableTrains[index];
                  final trainName = train['trainName'];
                  final startTime = train['startTime'];
                  final endTime = train['endTime'];
                  final trainType = train['trainType'];

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        trainName!,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'Arrival: $startTime',
                                style: TextStyle(fontSize: 14),
                              ),
                              Spacer(),
                              Text(
                                'Departure: $endTime',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Train Type: $trainType',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                },
              )
                  : const Center(
                child: Text('No trains available on the selected date.'),
              ),
            ),
          ]
        ),
      ),
    );
  }

  void getTrains() async {
    final collection = FirebaseFirestore.instance.collection('Train');

    final querySnapshot = await collection.get();

    final availableTrains = querySnapshot.docs.map((doc) {
      final trainData = doc.data() as Map<String, dynamic>;
      final trainName = trainData['trainName'] as String?;
      final startTime = trainData['startTime'] as String?;
      final endTime = trainData['endTime'] as String?;
      final trainType = trainData['trainType'] as String?;

      debugPrint('trainnn $trainType');

      return {
        'trainName': trainName,
        'startTime': startTime,
        'endTime': endTime,
        'trainType': trainType,
      };
    }).toList();

    setState(() {
      this.availableTrains = availableTrains;
    });
  }
}
