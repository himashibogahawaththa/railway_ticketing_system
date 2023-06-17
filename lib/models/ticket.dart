import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket {
  final String id;
  final String name;
  final String nic;
  final String departureStation;
  final String arrivalStation;
  final String train;
  final DateTime date;
  final String time;
  final String ticketClass;
  final String seat;
  final List<String> passengers;
  final double amount;
  bool isValid;

  Ticket({
    required this.id,
    required this.name,
    required this.nic,
    required this.departureStation,
    required this.arrivalStation,
    required this.train,
    required this.date,
    required this.time,
    required this.ticketClass,
    required this.seat,
    required this.passengers,
    required this.amount,
    this.isValid = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nic': nic,
      'departureStation': departureStation,
      'arrivalStation': arrivalStation,
      'train': train,
      'date': date,
      'time': time,
      'ticketClass': ticketClass,
      'seat': seat,
      'passengers': passengers,
      'amount': amount,
      'isValid': isValid,
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map['id'],
      name: map['name'],
      nic: map['nic'],
      departureStation: map['departureStation'],
      arrivalStation: map['arrivalStation'],
      train: map['train'],
      date: (map['date'] as Timestamp).toDate(),
      time: map['time'],
      ticketClass: map['ticketClass'],
      seat: map['seat'],
      passengers: List<String>.from(map['passengers']),
      amount: map['amount'].toDouble(),
      isValid: map['isValid'],
    );
  }
}