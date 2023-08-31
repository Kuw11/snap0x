class TwoFactorAuthentication {
  final int expectedDuration;
  final String linkPay;
  final double pay;
  final String serviceDescription;
  final bool available;
  final String image;

  TwoFactorAuthentication(
      {required this.expectedDuration,
      required this.linkPay,
      required this.pay,
      required this.serviceDescription,
      required this.available,
      required this.image});

  factory TwoFactorAuthentication.fromJson(Map<String, dynamic> json) =>
      TwoFactorAuthentication(
          expectedDuration: json['Expected_duration'],
          linkPay: json['LinkPay'],
          pay: double.parse(json['Pay'].toString()),
          serviceDescription: json['Service_description'],
          available: json['available'],
          image: json['image']);
}
