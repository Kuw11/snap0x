class Friend {
  String userName;
  String name;
  String addFriendTime;
  String? changedUserName;
  String? changedName;
  Friend(
      {required this.userName,
      required this.name,
      required this.addFriendTime,
      this.changedUserName,
      this.changedName});

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
        userName: json['username'].toString(),
        name: json['name'].toString(),
        addFriendTime: json['addFriendTime'].toString(),
        changedUserName: json['changedUserName'].toString(),
        changedName: json['changedName'].toString());
  }

  Map<String, String> toJson() => {
        'username': userName,
        'name': name,
        'addFriendTime': addFriendTime,
        'changedUserName': changedUserName ?? '',
        'changedName': changedName ?? ''
      };
}
