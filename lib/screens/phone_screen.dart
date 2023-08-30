import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:some_name/services/api_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class phone extends StatefulWidget {
  @override
  _phoneDemoState createState() => _phoneDemoState();
}

class _phoneDemoState extends State<phone> {
  FocusNode focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String _emailOrUserName = '';
  PhoneNumber? phoneNumber;
  late ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.normal,
      textDirection: TextDirection.ltr,
      isDismissible: true,
    );
    pr.style(
      message: 'جاري التحقق من الرقم',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressWidgetAlignment: Alignment.center,
      progressTextStyle: const TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: const TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: Image.asset("images/snapcht_logo.png"),
                  ),
                  const Text(
                    "Snap0x ios",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Material(
                        elevation: 5,
                        color: Colors.yellow,
                        child: IntlPhoneField(
                          countries: const [
                            Country(
                              name: "Saudi Arabia",
                              nameTranslations: {
                                "sk": "Saudská Arábia",
                                "se": "Saudi-Arábia",
                                "pl": "Arabia Saudyjska",
                                "no": "Saudi-Arabia",
                                "ja": "サウジアラビア",
                                "it": "Arabia Saudita",
                                "zh": "沙特阿拉伯",
                                "nl": "Saoedi-Arabië",
                                "de": "Saudi-Arabien",
                                "fr": "Arabie saoudite",
                                "es": "Arabia Saudí",
                                "en": "Saudi Arabia",
                                "pt_BR": "Arábia Saudita",
                                "sr-Cyrl": "Саудијска Арабија",
                                "sr-Latn": "Saudijska Arabija",
                                "zh_TW": "沙烏地阿拉",
                                "tr": "Suudi Arabistan",
                                "ro": "Arabia Saudită",
                                "ar": "السعودية",
                                "fa": "عربستان سعودی",
                                "yue": "沙地阿拉伯"
                              },
                              flag: "🇸🇦",
                              code: "SA",
                              dialCode: "966",
                              minLength: 9,
                              maxLength: 9,
                            ),
                            Country(
                              name: "Kuwait",
                              nameTranslations: {
                                "sk": "Kuvajt",
                                "se": "Kuwait",
                                "pl": "Kuwejt",
                                "no": "Kuwait",
                                "ja": "クウェート",
                                "it": "Kuwait",
                                "zh": "科威特",
                                "nl": "Koeweit",
                                "de": "Kuwait",
                                "fr": "Koweït",
                                "es": "Kuwait",
                                "en": "Kuwait",
                                "pt_BR": "Kuwait",
                                "sr-Cyrl": "Кувајт",
                                "sr-Latn": "Kuvajt",
                                "zh_TW": "科威特",
                                "tr": "Kuveyt",
                                "ro": "Kuweit",
                                "ar": "الكويت",
                                "fa": "کویت",
                                "yue": "科威特"
                              },
                              flag: "🇰🇼",
                              code: "KW",
                              dialCode: "965",
                              minLength: 8,
                              maxLength: 8,
                            ),
                            Country(
                              name: "United Arab Emirates",
                              nameTranslations: {
                                "sk": "Spojené arabské emiráty",
                                "se": "Ovttastuvvan Arábaemiráhtat",
                                "pl": "Zjednoczone Emiraty Arabskie",
                                "no": "De forente arabiske emirater",
                                "ja": "アラブ首長国連邦",
                                "it": "Emirati Arabi Uniti",
                                "zh": "阿拉伯联合酋长国",
                                "nl": "Verenigde Arabische Emiraten",
                                "de": "Vereinigte Arabische Emirate",
                                "fr": "Émirats arabes unis",
                                "es": "Emiratos Árabes Unidos",
                                "en": "United Arab Emirates",
                                "pt_BR": "Emirados Árabes Unidos",
                                "sr-Cyrl": "Уједињени Арапски Емирати",
                                "sr-Latn": "Ujedinjeni Arapski Emirati",
                                "zh_TW": "阿拉伯聯合大公國",
                                "tr": "Birleşik Arap Emirlikleri",
                                "ro": "Emiratele Arabe Unite",
                                "ar": "الإمارات العربية المتحدة",
                                "fa": "امارات متحده عربی",
                                "yue": "阿拉伯聯合酋長國"
                              },
                              flag: "🇦🇪",
                              code: "AE",
                              dialCode: "971",
                              minLength: 9,
                              maxLength: 9,
                            ),
                            Country(
                              name: "Qatar",
                              nameTranslations: {
                                "en": "Qatar",
                                "ar": "قطر",
                              },
                              flag: "🇧🇭",
                              code: "QA",
                              dialCode: "974",
                              minLength: 8,
                              maxLength: 8,
                            ),
                            Country(
                              name: "Oman",
                              nameTranslations: {
                                "en": "Oman",
                                "ar": "عمان",
                              },
                              flag: "🇴🇲",
                              code: "OM",
                              dialCode: "968",
                              minLength: 8,
                              maxLength: 8,
                            ),
                            Country(
                              name: "Bahrain",
                              nameTranslations: {
                                "en": "Bahrain",
                                "ar": "البحرين",
                              },
                              flag: "🇧🇭",
                              code: "BH",
                              dialCode: "973",
                              minLength: 8,
                              maxLength: 8,
                            ),
                          ], 
                          disableLengthCheck: true,
                          focusNode: focusNode,
                          validator: (p0) {
                            if (p0 == null || p0.number.isEmpty) {
                              return "type your phone number";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            phoneNumber = newValue;
                          },
                          // countries: [],
                          decoration: const InputDecoration(
                              labelStyle: TextStyle(color: Colors.black),
                              labelText: 'Phone Number',
                              border: InputBorder.none),
                          languageCode: "en",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Material(
                          elevation: 5,
                          color: Colors.yellow,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "type your username or email";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) => _emailOrUserName = value!,
                            decoration: const InputDecoration(
                              labelText: 'Username or Email',
                              labelStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 11.0, horizontal: 10.0),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () async {},
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    pr.show();
                    final result = await ApiService.verifyPhoneNumber(
                        _emailOrUserName,
                        phoneNumber!.number,
                        phoneNumber!.countryISOCode);
                    pr.hide();
                    if (result) {
                      // ignore: use_build_context_synchronously
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              title: 'success',
                              desc:
                                  'Yes, it is true that the number is registered in the account | ${phoneNumber!.completeNumber} | username : $_emailOrUserName')
                          .show();
                    } else {
                      // ignore: use_build_context_synchronously
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              title: 'error',
                              desc:
                                  'Invalid mobile number. Please try another number, try a verified email address : ${phoneNumber!.completeNumber}')
                          .show();
                    }
                  }
                },
                minWidth: 200,
                height: 42,
                child: const Text(
                  'Run',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
              const SizedBox(height: 20),
              const Text(" Check if the number is associated with a Snapchat account \n  or not Enter the number and username or email",
              style: TextStyle(
                fontSize: 13,
                color: Colors.black,
                ),
                textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
