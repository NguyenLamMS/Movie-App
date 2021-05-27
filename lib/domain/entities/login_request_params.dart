import 'package:flutter/cupertino.dart';

class LoginRequestParam {
  final String userName;
  final String passsword;

  LoginRequestParam({@required this.userName, @required this.passsword});

  Map<String, dynamic> toJson() => {'username': userName, 'password': passsword};
}
