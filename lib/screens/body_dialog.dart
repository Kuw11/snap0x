import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:some_name/model/user.dart';
import 'package:some_name/services/api_service.dart';

bool stopRepo = false;

class BoodyDialog extends StatefulWidget {
  const BoodyDialog({super.key, required this.userName});
  final String userName;

  @override
  State<BoodyDialog> createState() => _BoodyDialogState();
}

class _BoodyDialogState extends State<BoodyDialog> {
  var text = '';

  @override
  Widget build(BuildContext context) {
    stopRepo = false;
    int index = 0;
    final user =
        UserApp(userName: widget.userName, password: "", statusLogin: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Start Send reports",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 20,
        ),
        StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              index++;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(user.userName),
                        const Text(
                          " :اليورز",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(user.name),
                        const Text(
                          " :الاسم",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                          user.user_id,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )),
                        const Text(
                          " :معرف الحساب",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(user.Famous),
                        const Text(
                          " :تحقق من الشهره ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(user.typeAccount),
                        const Text(
                          " :نوع الحساب",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(user.statusAccount),
                        const Text(
                          " :حالة الحساب",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(user.file),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        // width:double.infinity,
                        //height: 25,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (snapshot.data != null && snapshot.data!)
                      Center(
                        child: Text(
                          "sended report num $index",
                          style: const TextStyle(color: Colors.green),
                        ),
                      ),
                    if (snapshot.data != null && !snapshot.data!)
                      Center(
                        child: Text("Fail to send report num $index",
                            style: const TextStyle(color: Colors.red)),
                      )
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
          },
          stream: ApiService.startReportUser(widget.userName, user),
        )
      ],
    );
  }
}
