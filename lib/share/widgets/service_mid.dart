import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:some_name/model/acounts.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceMid extends StatelessWidget {
  const ServiceMid({
    super.key,
    required this.accountList,
  });
  final AccountList accountList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: accountList.available
              ? () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.noHeader,
                    body: Column(
                      children: [
                        Image.network(
                          accountList.image,
                          width: 100,
                          height: 100,
                        ),
                        Text(accountList.name),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  accountList.available
                                      ? Icons.done
                                      : Icons.close,
                                  color: accountList.available
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                Text(
                                  accountList.available ? 'متوفر' : 'تم البيع',
                                  style: TextStyle(
                                      color: accountList.available
                                          ? Colors.green
                                          : Colors.red),
                                )
                              ],
                            ),
                            if (accountList.available)
                              Text(
                                '${accountList.pay} ريال',
                                style: const TextStyle(color: Colors.amber),
                              )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              accountList.withEmail ? 'نعم' : "لا",
                              style: TextStyle(
                                  color: accountList.withEmail
                                      ? Colors.green
                                      : Colors.red),
                            ),
                            const Text(' : مع الايميل الاساسي '),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              accountList.withNumber ? 'نعم' : "لا",
                              style: TextStyle(
                                  color: accountList.withNumber
                                      ? Colors.green
                                      : Colors.red),
                            ),
                            const Text(' : مع الرقم'),
                          ],
                        )
                      ],
                    ),
                    btnOkText: 'شراء',
                    btnCancelText: 'الغاء',
                    btnOkOnPress: () {
                      launchUrl(Uri.parse(accountList.linkPay));
                    },
                    btnCancelOnPress: () {},
                  ).show();
                }
              : null,
          child: Card(
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Center(
                        child: Image.network(
                          accountList.image,
                          width: 75,
                          height: 75,
                        ),
                      ),
                    ),
                    Positioned(
                        left: 0, bottom: 0, child: Image.asset('images/wh.PNG'))
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(
                    accountList.available ? Icons.done : Icons.close,
                    color: accountList.available ? Colors.green : Colors.red,
                  ),
                  Text(
                    accountList.available ? 'متوفر' : 'تم البيع',
                    style: TextStyle(
                        color:
                            accountList.available ? Colors.green : Colors.red),
                  )
                ],
              ),
              if (accountList.available)
                Text(
                  '${accountList.pay} ريال',
                  style: const TextStyle(color: Colors.amber),
                )
            ],
          ),
        ),
      ],
    );
  }
}
