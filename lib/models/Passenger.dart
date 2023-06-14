class Passenger {
  String id;
  String name;
  String username;
  String nic;
  String email;
  String password;
  String phoneNumber;
  // Add more attributes as per your requirements

  Passenger(
      {
        required this.id,
        required this.name,
        required this.username,
        required this.nic,
        required this.email,
        required this.password,
        required this.phoneNumber,
    // Initialize more attributes here
     }
  );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'nic': nic,
      'password': password,
      'phoneNumber': phoneNumber,
    };
  }
}
