import 'package:flutter/material.dart';

class AppLayout{
  static getSize(BuildContext context){
    return MediaQuery.of(context).size;
  }

  static getHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static getWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
}