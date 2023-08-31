import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:some_name/model/acounts.dart';
import 'package:some_name/model/data_fire.dart';
import 'package:some_name/model/reporting.dart';
import 'package:some_name/model/two_factor_authentication.dart';

class ServiceFireBase {
  static final store = FirebaseFirestore.instance;
  static Future<DataFire> getService() async {
    final dataFire = DataFire();
    final accounts = await store.collection('accounts').get();

    final allAccounts = await store
        .collection('accounts')
        .doc('detalis')
        .collection('accounts')
        .get();
    if (accounts.docs.first.data().isNotEmpty) {
      final account =
          Accounts.fromJson(accounts.docs.first.data(), allAccounts);
      debugPrint(account.toString());
      dataFire.accounts = account;
    }

    final reportings = await store.collection('reporting').get();
    if (reportings.docs.first.data().isNotEmpty) {
      final repo = Reporting.fromJson(reportings.docs.first.data());
      debugPrint(repo.toString());
      dataFire.reporting = repo;
    }

    final auth = await store.collection('Two-Factor_Authentication').get();
    if (auth.docs.first.data().isNotEmpty) {
      final twoFactor =
          TwoFactorAuthentication.fromJson(auth.docs.first.data());
      debugPrint(twoFactor.toString());
      dataFire.twoFactorAuthentication = twoFactor;
    }
    return dataFire;
  }
}
