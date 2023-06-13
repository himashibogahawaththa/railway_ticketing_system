import 'package:flutter/material.dart';

import '../widgets/menu_widget.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.black,
      title: Text('Profile Page'),
      leading: MenuWidget(),
    ),
  );
}
