import 'package:flutter/material.dart';
import 'package:some_name/model/two_factor_authentication.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceFullWidget extends StatelessWidget {
  const ServiceFullWidget({super.key, required this.twofactor});
  final TwoFactorAuthentication twofactor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: twofactor.available
            ? () async {
                if (await launchUrl(Uri.parse(twofactor.linkPay))) {}
              }
            : null,
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          twofactor.available ? Icons.done : Icons.close,
                          color:
                              twofactor.available ? Colors.green : Colors.red,
                        ),
                        Text(
                          twofactor.available ? 'الخدمة متاحة' : 'تم البيع',
                          style: TextStyle(
                              color: twofactor.available
                                  ? Colors.green
                                  : Colors.red),
                        )
                      ],
                    ),
                    if (twofactor.available)
                      Text(
                        '${twofactor.pay} ريال',
                        style: const TextStyle(color: Colors.green),
                      )
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      twofactor.image,
                      width: 100,
                      height: 100,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //       horizontal: MediaQuery.of(context).size.width / 5),
                    //   child: const Text(
                    //     'عرض خدمة فتح المصداقة الثنائية',
                    //     style: TextStyle(
                    //         fontSize: 25, fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                  ],
                ),
                Text(
                  twofactor.serviceDescription,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
