import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:railway_ticketing/screens/booking_screen.dart';
import 'package:railway_ticketing/screens/navigation/bottom_navbar.dart';
import 'package:railway_ticketing/screens/payment_screen.dart';
import 'package:railway_ticketing/screens/profile_screen.dart';

import '../../models/menu_item.dart';
import '../home_screen.dart';
import '../pay_screen.dart';
import 'menu_screen.dart';

class NavigationDrawerScreen extends StatefulWidget {
  const NavigationDrawerScreen({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerScreen> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawerScreen> {
  MenuItem currentItem = MenuItems.home;

  @override
  Widget build(BuildContext context) => ZoomDrawer(
    style: DrawerStyle.Style1,
    showShadow: true,
    mainScreen: getScreen(),
    menuScreen: Builder(
      builder: (context) => MenuScreen(
          currentItem: currentItem,
          onSelectedItem: (item) {
            setState(() => currentItem = item);

            ZoomDrawer.of(context)!.close();
          }
      ),
    ),
  );

  Widget getScreen() {
    switch(currentItem){
      case MenuItems.home:
        return const BottomNav();
      case MenuItems.booking:
        return const BookingScreen();
      case MenuItems.payment:
        return const PayScreen();
      case MenuItems.profile:
        return const ProfileScreen();
        // return PayHerePaymentPage(merchantId: '', returnUrl: '', cancelUrl: '',
        //   notifyUrl: '', firstName: '', lastName: '', email: '', phone: '',
        //   address: '', city: '', country: '', orderId: '', items: '',
        //   currency: '', amount: 0.0 , hash: '',);
      default:{
        FirebaseAuth.instance.signOut();
        return const HomeScreen() ;
      }
    }
  }
}

