import 'package:flutter/material.dart';

class Transation{
  String id;
  String title;
  double amount;
  DateTime dateTime;

  Transation({
   required this.id,
    required this.title,
    required this.amount,
    required this.dateTime});
}