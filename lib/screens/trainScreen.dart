import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/menu_widget.dart';

class TrainScreen extends StatefulWidget {
  const TrainScreen({Key? key}) : super(key: key);

  @override
  State<TrainScreen> createState() => _TrainScreenState();
}

class _TrainScreenState extends State<TrainScreen> {
  String? selectedValueFrom  = 'Option 1';
  String? selectedValueTo  = 'Option 1';
  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  String? trainType;
  List<Map<String, String>> availableTrains = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Train Schedule'),
        leading: const MenuWidget(),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text('Start Station:'),
                        const SizedBox(height: 10),
                        DropdownButton<String>(
                          alignment: Alignment.center,
                          value: selectedValueFrom,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValueFrom = newValue;
                            });
                          },
                          items: const [
                            DropdownMenuItem(
                              value: 'Option 1',
                              child: Center(child: Text('-- Select --')),
                            ),
                            DropdownMenuItem(
                              value: 'Colombo Fort',
                              child: Text('Colombo Fort'),
                            ),
                            DropdownMenuItem(
                              value: 'Galle',
                              child: Text('Galle'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text('End Station:'),
                        const SizedBox(height: 10),
                        DropdownButton<String>(
                          alignment: Alignment.center,
                          value: selectedValueTo,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValueTo = newValue;
                            });
                          },
                          items: const [
                            DropdownMenuItem(
                              value: 'Option 1',
                              child: Center(child: Text('-- Select --')),
                            ),
                            DropdownMenuItem(
                              value: 'Colombo Fort',
                              child: Text('Colombo Fort'),
                            ),
                            DropdownMenuItem(
                              value: 'Galle',
                              child: Text('Galle'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: _showStartTimePicker,
                      child: Text(
                        selectedStartTime == null
                            ? 'Start Time'
                            : selectedStartTime!.format(context),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: _showEndTimePicker,
                      child: Text(
                        selectedEndTime == null
                            ? 'End Time'
                            : selectedEndTime!.format(context),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: _showDatePicker,
                  child: Text(
                    selectedDate == null
                        ? 'Select Date'
                        : DateFormat('dd MMMM yyyy').format(selectedDate!),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: _searchTrainAvailability,
                    child: const Text('Search'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: _resetData,
                    child: const Text('Reset'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: availableTrains.isNotEmpty
                  ? ListView.builder(
                itemCount: availableTrains.length,
                itemBuilder: (BuildContext context, int index) {
                  final train = availableTrains[index];
                  final trainName = train['trainName'] as String;
                  final startTime = train['startTime'] as String;
                  final endTime = train['endTime'] as String;
                  final trainType = train['trainType'] as String;

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                        trainName,
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
          ],
        ),
      ),
    );
  }

  void _showStartTimePicker() async {
    final initialTime = TimeOfDay.now();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (pickedTime != null && pickedTime != selectedStartTime) {
      setState(() {
        selectedStartTime = pickedTime;
      });
    }
  }

  void _showEndTimePicker() async {
    final initialTime = TimeOfDay.now();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (pickedTime != null && pickedTime != selectedEndTime) {
      setState(() {
        selectedEndTime = pickedTime;
      });
    }
  }

  void _showDatePicker() async {
    final initialDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate.subtract(const Duration(days: 365)),
      lastDate: initialDate.add(const Duration(days: 365)),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _searchTrainAvailability() async {
    if (selectedValueFrom == null || selectedValueTo == null) {
      return;
    }

    final collection = FirebaseFirestore.instance.collection('Train');

    // Check if selectedValueFrom exists in Firestore
    final fromSnapshot = await collection
        .where('startStation', isEqualTo: selectedValueFrom)
        .limit(1)
        .get();
    if (fromSnapshot.docs.isEmpty) {
      // selectedValueFrom does not exist in Firestore
      print('Selected start station does not exist in Firestore');
      return;
    }

    // Check if selectedValueTo exists in Firestore
    final toSnapshot = await collection
        .where('endStation', isEqualTo: selectedValueTo)
        .limit(1)
        .get();
    if (toSnapshot.docs.isEmpty) {
      // selectedValueTo does not exist in Firestore
      print('Selected end station does not exist in Firestore');
      return;
    }

    // Both selectedValueFrom and selectedValueTo exist in Firestore
    final querySnapshot = await collection
        .where('startStation', isEqualTo: selectedValueFrom)
        .where('endStation', isEqualTo: selectedValueTo)
        .get();

    final availableTrains = querySnapshot.docs.map((doc) {
      final trainData = doc.data() as Map<String, dynamic>;
      final trainName = trainData['trainName'] as String;
      final startTime = trainData['startTime'] as String;
      final endTime = trainData['endTime'] as String;
      final trainType = trainData['trainType'] as String;

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





  void _resetData() {
    setState(() {
      selectedValueFrom = null;
      selectedValueTo = null;
      selectedStartTime = null;
      selectedEndTime = null;
      selectedDate = null;
      availableTrains = [];
    });
  }
}
