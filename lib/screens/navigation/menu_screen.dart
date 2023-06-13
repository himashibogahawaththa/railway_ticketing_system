import 'package:flutter/material.dart';

import '../../models/menu_item.dart';



class MenuItems{
  static const home = MenuItem('Home', Icons.home);
  static const booking = MenuItem('Ticket Booking ', Icons.airplane_ticket);
  static const payment = MenuItem('Payment', Icons.payment);
  static const profile = MenuItem('Profile ', Icons.person);
  static const logout = MenuItem('Logout', Icons.logout);

  static const all = <MenuItem>[
    home,
    booking,
    payment,
    profile,
    logout
  ];
}

class MenuScreen extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  const MenuScreen({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem}) : super(key: key);

  @override
  Widget build(BuildContext context) => Theme(
    data: ThemeData.dark(),
    child: Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            ...MenuItems.all.map(buildMenuItem).toList(),
            const Spacer(flex: 2,)
          ],
        ),
      ),
    ),
  );

  Widget buildMenuItem(MenuItem item) => ListTileTheme(
    selectedColor: Colors.white,
    child: ListTile(
      selectedTileColor: Colors.black26,
      selected: currentItem == item,
      minLeadingWidth: 20,
      leading: Icon(item.icon),
      title: Text(item.title),
      onTap: () => onSelectedItem(item),
    ),
  );
}
