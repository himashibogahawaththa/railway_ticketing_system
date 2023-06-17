import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:railway_ticketing/screens/profile_screen.dart';

import '../qr_screen.dart';
import '../home_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    final screens = [
       QRScreen(),
      const HomeScreen(),
      const ProfileScreen()
      // PayHerePaymentPage(merchantId: '', returnUrl: '', cancelUrl: '', notifyUrl: '', firstName: '', lastName: '', email: '', phone: '', address: '', city: '', country: '', orderId: '', items: '', currency: '', amount: 0.0 , hash: '',),
    ];
    final items = <Widget>[
      const Icon(Icons.qr_code, size: 30,),
      const Icon(Icons.home, size: 30,),
      const Icon(Icons.person_pin_sharp, size: 30,),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            iconTheme: const IconThemeData(color: Colors.white)
        ),
        child: CurvedNavigationBar(
          color: Colors.black26,
          buttonBackgroundColor: Colors.teal,
          backgroundColor: Colors.transparent,
          height: 55,
          index: index,
          items: items,
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}
