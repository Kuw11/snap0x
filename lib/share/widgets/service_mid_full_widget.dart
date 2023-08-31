import 'package:flutter/material.dart';
import 'package:some_name/model/reporting.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceMidFullWidget extends StatelessWidget {
  const ServiceMidFullWidget({super.key, required this.reporting});

  final Reporting reporting;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: reporting.available
            ? () {
                launchUrl(Uri.parse(reporting.linkPay));
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
                          reporting.available ? Icons.done : Icons.close,
                          color:
                              reporting.available ? Colors.green : Colors.red,
                        ),
                        Text(
                          reporting.available ? 'الخدمة متاحة' : 'تم البيع',
                          style: TextStyle(
                              color: reporting.available
                                  ? Colors.green
                                  : Colors.red),
                        )
                      ],
                    ),
                    if (reporting.available)
                      Text(
                        '${reporting.pay} ريال',
                        style: const TextStyle(color: Colors.green),
                      )
                  ],
                ),
                Row(
                  children: [
                    Image.network(
                      reporting.image,
                      width: 100,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            reporting.serviceDescription,
                            textAlign: TextAlign.right,
                            style: const TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
