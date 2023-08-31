import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AccountList {
  final String linkPay;
  final double pay;
  final String name;
  final bool available;
  final bool withEmail;
  final bool withNumber;
  final String image;

  AccountList({
    required this.linkPay,
    required this.pay,
    required this.name,
    required this.available,
    required this.withEmail,
    required this.withNumber,
    required this.image,
  });
  factory AccountList.fromJson(Map<String, dynamic> json, String name) =>
      AccountList(
          linkPay: json['link_pay'],
          pay: double.parse(json['pay'].toString()),
          name: name,
          withEmail: json['with_email'],
          withNumber: json['with_number'],
          available: json['available'],
          image: json['image']);
}

class Accounts {
  final String linkPay;
  final String serviceDescription;
  final int accounts;
  final bool available;
  final String image;
  final double pay;
  final List<AccountList> listaccounts;

  Accounts(
      {required this.linkPay,
      required this.serviceDescription,
      required this.accounts,
      required this.available,
      required this.image,
      required this.pay,
      required this.listaccounts});

  factory Accounts.fromJson(
      Map<String, dynamic> json, QuerySnapshot<Map<String, dynamic>> accounts) {
    final List<AccountList> list = [];
    for (var element in accounts.docs) {
      list.add(AccountList.fromJson(element.data(), element.id));
    }
    return Accounts(
        linkPay: json['LinkPay'],
        serviceDescription: json['Service_description'],
        accounts: json['accounts'],
        available: json['available'],
        image: json['image'],
        pay: double.parse(json['pay'].toString()),
        listaccounts: list);
  }
}
