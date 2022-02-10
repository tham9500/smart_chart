import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chair/connect/connect.dart';
import 'package:smart_chair/models/user_model.dart';
import 'package:smart_chair/page/home.dart';
import 'package:smart_chair/page/register.dart';

class Login_page extends StatefulWidget {
  Login_page({Key? key}) : super(key: key);

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  final form_key = GlobalKey<FormState>();
  List<dynamic> data_user = [];
  String username = "", Password = "";
  bool _isVisible = true;
  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(160, 106, 106, 1),
        title: const Text('เข้าสู่ระบบ'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            //variable formfieldbulder
            key: form_key,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Image(
                              image: AssetImage("assets/images/logo/logo3.jpg"),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Welcome to",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo.shade800),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Sitting Detecter",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo.shade800),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Form_username(),
                  Form_password(),
                  SizedBox(height: 20),
                  Btn_StateLogin(),
                  SizedBox(height: 20),
                  Btn_registor(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Form_username() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'username',
        labelText: 'Username *',
      ),
      onChanged: (value) => setState(() {
        username = value;
      }),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context,
            errorText: "กรุณากรอกชื่อผู้ใช้")
      ]),
    );
  }

  Widget Form_password() {
    return TextFormField(
      obscureText: _isVisible,
      decoration: InputDecoration(
          icon: Icon(Icons.lock),
          hintText: 'Password',
          labelText: 'Password *',
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              icon:
                  Icon(_isVisible ? Icons.visibility_off : Icons.visibility))),
      onChanged: (value) => setState(() {
        Password = value;
      }),
      validator: (String? value) {
        return (value != null && value.contains('@'))
            ? 'Do not use the @ char.'
            : null;
      },
    );
  }

  Widget Btn_StateLogin() {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.pinkAccent.shade700),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ))),
            child: Text(
              "เข้าสู่ระบบ",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () {
              print("login click");
              form_key.currentState!.save();

              if (form_key.currentState!.validate()) {
                // print("username = ${username}");
                // print("password = ${Password}");
                login();
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Home_page()));
              }
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Registor_page()));
            }));
  }

  Widget Btn_registor() {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ))),
            child: Text(
              "ลงทะเบียน",
              style: TextStyle(fontSize: 18, color: Colors.pinkAccent.shade700),
            ),
            onPressed: () {
              print("registor click");

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Register_page()));
            }));
  }

  Future<void> login() async {
    // var dio = Dio();
    // final response = await dio.get('https://google.com');
    // print(response.data);
    Dio dio = new Dio();
    // String url = "http://172.27.7.226/easy_drive_backend/user/mobile/login.php";
    String url = "${Domain_name().domain}/C_project/service/account/login.php";
    var dataReq = {};
    dataReq["username"] = username;
    dataReq["password"] = Password;
    String data = jsonEncode(dataReq);
    var response = await Dio().post(url, data: data);
    print("response = ${response.toString()}");
    if (response.toString() == "fail") {
      _showMyDialogPass("user และ password ของท่าน\nไม่ถูกต้องกรุณาลองใหม่");
    } else {
      var result = json.decode(response.data);
      print("result = ${result}");
      print(result.runtimeType);
      for (var map in result) {
        try {
          User_model user_model = User_model.fromJson(map);
          routeService(user_model);
          print("login complete");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home_page()));
        } catch (e) {
          print("ERROR LOGIN");
        }
      }
    }

    print("user_data=${data_user.toString()}");
  }

  Future<void> _showMyDialogPass(content) async {
    return showDialog<void>(
      context: this.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Container(
                    child: Text(
                      "${content}",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: TextButton(
                      child: const Text(
                        'ตกลง',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<Null> routeService(User_model user_model) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('ID', user_model.userId);
    preferences.setString('USERNAME', user_model.userName);
    preferences.setString('PASSWORD', user_model.password);
    preferences.setString('ROLE', user_model.role);
    preferences.setString('STATUS', "login");
    print(user_model.userName);
  }

  Future<Null> setemail_verify() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('USERNAME', username);
  }
}
