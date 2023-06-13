import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:railway_ticketing/screens/fingerprint_screen.dart';
import '../widgets/menu_widget.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? selectedValueFrom  = 'Option 1';
  String? selectedValueTo  = 'Option 1';
  DateTime? _selectedDate;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  List<String> _availableTrains = [
    'Train A',
    'Train B',
    'Train C',
  ];

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Booking'),
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
                        const SizedBox(height: 10,),
                        const Text(
                            'From:'
                        ),
                        const SizedBox(height: 10,),
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
                              value: 'Option 2',
                              child: Text('Colombo Fort'),
                            ),
                            DropdownMenuItem(
                              value: 'Option 3',
                              child: Text('Galle'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
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
                        const SizedBox(height: 10,),
                        const Text(
                            'To:'
                        ),
                        const SizedBox(height: 10,),
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
                              value: 'Option 2',
                              child: Text('Colombo Fort'),
                            ),
                            DropdownMenuItem(
                              value: 'Option 3',
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
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: _showDatePicker,
                  child: Text(_selectedDate == null ? 'Select a date' :
                    DateFormat('dd MMMM yyyy').format(_selectedDate!),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: _showStartTimePicker,
                      child: Text(
                        _selectedStartTime == null
                            ? 'Start time'
                            : _selectedStartTime!.format(context),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: _showEndTimePicker,
                      child: Text(
                        _selectedEndTime == null
                            ? 'End time'
                            : _selectedEndTime!.format(context),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _searchTrainAvailability,
                child: const Text('Search'),
              ),
            ),
          ]
        ),
      ),
    );
  }

  void _showDatePicker() async {
    final initialDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate.subtract(const Duration(days: 365)),
      lastDate: initialDate.add(const Duration(days: 365)),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _showStartTimePicker() async {
    final initialTime = TimeOfDay.now();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (pickedTime != null && pickedTime != _selectedStartTime) {
      setState(() {
        _selectedStartTime = pickedTime;
      });
    }
  }

  void _showEndTimePicker() async {
    final initialTime = TimeOfDay.now();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (pickedTime != null && pickedTime != _selectedEndTime) {
      setState(() {
        _selectedEndTime = pickedTime;
      });
    }
  }

  void _searchTrainAvailability() {
    // Replace with your train schedule or database lookup code
    if (selectedValueFrom == 'Option 2' && selectedValueTo == 'Option 3' && _selectedDate != null && _selectedDate!.day == 30 && _selectedDate!.month == 4) {
      setState(() {
        _availableTrains = ['Train A', 'Train B'];
      });
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Available Trains'),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BookingScreen()),
                    );
                  },
                  child: ListView.builder(
                    itemCount: _availableTrains.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(_availableTrains[index]),
                        onTap: () {
                          // Handle train selection
                          // ...
                          Navigator.pop(context); // Close the modal
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FingerprintScreen()),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
    );
    } else {
      setState(() {
        _availableTrains = [];
      });
    }
  }
}
