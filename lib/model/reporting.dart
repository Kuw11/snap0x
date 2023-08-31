import 'package:flutter/material.dart';

class Reporting {
  final int expectedDuration;
  final String linkPay;
  final double pay;
  final String serviceDescription;
  final int accountBot;
  final bool available;
  final String image;

  Reporting(
      {required this.expectedDuration,
      required this.linkPay,
      required this.pay,
      required this.serviceDescription,
      required this.accountBot,
      required this.available,
      required this.image});

  factory Reporting.fromJson(Map<String, dynamic> json) => Reporting(
      expectedDuration: json['Expected_duration'],
      linkPay: json['LinkPay'],
      pay: double.parse(json['Pay'].toString()),
      serviceDescription: json['Service_description'],
      accountBot: json['account_Bot'],
      available: json['available'],
      image: json['image']);
}
