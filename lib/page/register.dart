import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:smart_chair/connect/connect.dart';
import 'package:smart_chair/page/login.dart';

class Register_page extends StatefulWidget {
  Register_page({Key? key}) : super(key: key);

  @override
  State<Register_page> createState() => _Register_pageState();
}

class _Register_pageState extends State<Register_page> {
  String username = "", passWord = "", confirmPassword = "";
  bool isChecked = false;
  bool _isVisible_password = true;
  bool _isVisible_confirm = true;
  final form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(160, 106, 106, 1),
        title: const Text('สมัครสมาชิก'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: form_key,
          child: Container(
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
                  Form_confirm(),
                  Check_verify(),
                  SizedBox(height: 50),
                  Btn_Submit()
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
        icon: Icon(Icons.people),
        hintText: 'username',
        labelText: 'username *',
      ),
      onChanged: (value) => setState(() {
        username = value;
      }),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context, errorText: "กรุณากรอก Email"),
      ]),
    );
  }

  Widget Form_password() {
    return TextFormField(
      obscureText: _isVisible_password,
      decoration: InputDecoration(
          icon: Icon(Icons.vpn_key),
          hintText: 'Password',
          labelText: 'Password *',
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isVisible_password = !_isVisible_password;
                });
              },
              icon: Icon(_isVisible_password
                  ? Icons.visibility_off
                  : Icons.visibility))),
      onChanged: (value) => setState(() {
        passWord = value;
      }),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context, errorText: "กรุณากรอกรหัสผ่าน"),
        FormBuilderValidators.minLength(context, 8,
            errorText: "กรุณากรอกอย่างน้อย 8 ตัวอักษร"),
        FormBuilderValidators.match(context, confirmPassword,
            errorText: "รหัสไม่ถูกต้อง")
      ]),
    );
  }

  Widget Form_confirm() {
    return TextFormField(
      obscureText: _isVisible_confirm,
      decoration: InputDecoration(
          icon: Icon(Icons.vpn_key_outlined),
          hintText: 'Comform password',
          labelText: 'Confirm Password *',
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isVisible_confirm = !_isVisible_confirm;
                });
              },
              icon: Icon(_isVisible_confirm
                  ? Icons.visibility_off
                  : Icons.visibility))),
      onChanged: (value) => setState(() {
        confirmPassword = value;
      }),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context, errorText: "กรุณากรอกรหัสผ่าน"),
        FormBuilderValidators.minLength(context, 8,
            errorText: "กรุณากรอกอย่างน้อย 8 ตัวอักษร"),
        FormBuilderValidators.match(context, passWord,
            errorText: "รหัสไม่ถูกต้อง")
      ]),
    );
  }

  Widget Check_verify() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
              child: Checkbox(
                  value: isChecked,
                  onChanged: (verify) {
                    setState(() {
                      isChecked = verify!;
                    });
                  })),
          Container(
            child: Text(
              "ยอมรับเงื่อนไง",
              style: TextStyle(
                  color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget Btn_Submit() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,

      // color: Colors.amber.shade200,
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.pinkAccent.shade700),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
          ),
        ),
        child: Text(
          "ยืนยันลงทะเบียน",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        onPressed: () {
          print("Submit click");
          form_key.currentState!.save();

          if (form_key.currentState!.validate()) {
            if (isChecked == false) {
              _showMyDialogVerify("กรุณายีนยันนโยบายก่อนทำ\nการลงทะเบียน");
            } else {
              print("verify register");
              print("email = ${username}");
              print("password = ${passWord}");
              //regitorThead();
              checkUser();
            }
            // postdataUser();

          }
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => Login_page()));
        },
      ),
    );
  }

  Future<void> _showMyDialogVerify(content) async {
    return showDialog<void>(
      context: this.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Container(
                    child: Text(
                      "${content}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
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

  Future<Null> checkUser() async {
    Dio dio = new Dio();
    String url =
        '${Domain_name().domain}/C_project/service/account/verify_user.php';
    var dataReq = {};
    dataReq["username"] = username;
    var data = jsonEncode(dataReq);
    var response = await Dio().post(url, data: data);
    try {
      print("response = ${response.toString()}");
      if (response.toString() == "repeat") {
        _showMyDialogVerify(
            "มี username นี้อยู่ในระบบกรุณาใช้ \nusername อื่น");
      } else if (response.toString() == "unrepeat") {
        print("response = checkusernull");
        regitorThead();
      }
    } catch (e) {
      print("ERROR check");
    }
  }

  Future<Null> regitorThead() async {
    Dio dio = new Dio();
    String url =
        '${Domain_name().domain}/C_project/service/account/register.php';

    var dataReq = {};
    dataReq["username"] = username;
    dataReq["password"] = passWord;

    var data = jsonEncode(dataReq);
    print("data send = ${data}");
    var response = await Dio().post(url, data: data);
    print(response.toString());
    try {
      print(url);

      if (response.toString() == 'complete') {
        _showRegistorPass("สมัครสมาชิกสำเร็จ");
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Login_page()));
      } else if (response.toString() == 'fail') {
        _showMyDialogVerify("สมัครสมาชิกไม่สำเร็จ \nกรุณาลองใหม่");
      }
    } catch (e) {
      print("ERROR");
    }
  }

  Future<void> _showRegistorPass(content) async {
    return showDialog<void>(
      context: this.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "${content}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login_page()));
                      },
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
}
