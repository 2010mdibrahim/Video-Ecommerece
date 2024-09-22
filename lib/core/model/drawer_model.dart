import 'package:flutter/material.dart';

class DrawerModel {
  final IconData icon;
  final String name;
  var additionlValue;

  DrawerModel(this.icon, this.name,{this.additionlValue});
  factory DrawerModel.selectItem(String title)=>DrawerModel(Icons.arrow_drop_down, title);
}