import 'package:flutter/material.dart';
import 'package:some_name/model/data_fire.dart';
import 'package:some_name/services/service_firebase.dart';
import 'package:some_name/share/widgets/service_full_widget.dart';
import 'package:some_name/share/widgets/service_mid.dart';

import '../share/widgets/service_mid_full_widget.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  DataFire? dataFire;
  @override
  Widget build(BuildContext context) {
    if (dataFire == null) {
      ServiceFireBase.getService().then(
        (value) {
          setState(() {
            dataFire = value;
          });
        },
      );
    }
    return Center(
      child: dataFire != null
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    if (dataFire!.twoFactorAuthentication != null)
                      ServiceFullWidget(
                        twofactor: dataFire!.twoFactorAuthentication!,
                      ),
                    if (dataFire!.accounts!.listaccounts.isNotEmpty)
                      const Text(
                        'شراء حسابات',
                        style: TextStyle(fontSize: 30),
                      ),
                    Center(
                      child: Wrap(
                        spacing: 30,
                        runSpacing: 20,
                        runAlignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: dataFire!.accounts!.listaccounts
                            .map((e) => ServiceMid(
                                  accountList: e,
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        'حصريا لك',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    if (dataFire!.reporting != null)
                      ServiceMidFullWidget(
                        reporting: dataFire!.reporting!,
                      )
                  ],
                ),
              ),
            )
          : const CircularProgressIndicator(
              color: Colors.yellow,
            ),
    );
  }
}
