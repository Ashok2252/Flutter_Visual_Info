import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visualinfo/animation.dart';
import 'package:visualinfo/getpage3.dart';
import 'package:visualinfo/user_model.dart';
import 'package:http/http.dart' as http;

class MyHomePage2 extends StatefulWidget {
  MyHomePage2({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<UserModel> createUser(
  int _srno,
  String _name,
  String _address,
  String dateCtl,
  String _phoneNumber,
  String _email,
  String createdDateCtl,

  // String _dob,
) async {
  final String apiUrl = "http://test.visualinfosoft.com/api/Employee/Save";
  // final String apiUrl =
  //     'http://test.visualinfosoft.com/swagger/index.html/api/Employee/Save';

  // final response = await http.post(apiUrl, body: {
  //   "srno": int.parse(_srno),
  //   "name": _name.toString(),
  //   "address": _address.toString(),
  //   "dob": dateCtl.toString(),
  //   "mobile": _phoneNumber.toString(),
  //   "email": _email.toString(),
  //   "createddate": createdDateCtl.toString(),
  // });

  final Map<String, dynamic> activityData = {
    "srno": _srno,
    "name": _name,
    "address": _address,
    "dob": dateCtl,
    "mobile": _phoneNumber,
    "email": _email,
    "createddate": createdDateCtl
  };

  // final response = await http.post(apiUrl, body: json.encode(activityData));
  final response = await http.post(apiUrl,
      body: json.encode(activityData),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });

  if (response.statusCode == 200) {
    final String responseString = response.body;
    print(response.statusCode);
    return userModelFromJson(responseString);
  }
  if (response.statusCode == 415) {
    final String responseString = response.body;
    print(response.statusCode);
    print("Error 415");
    return userModelFromJson(responseString);
  }
  // if (response.body.isNotEmpty) {
  //   json.decode(response.body);
  // }
  else {
    print(response.statusCode);
    return null;
  }

  // return null;
}

class _MyHomePageState extends State<MyHomePage2> {
  UserModel _user;

  // String dateCtl_;
  final TextEditingController dateCtl_ = TextEditingController();

  // String createdDateCtl_;
  final TextEditingController createdDateCtl_ = TextEditingController();

  // String createdDateCtl;
  // final TextEditingController nameController = TextEditingController();
  final int sr_no = 0;
  String name_;
  String email_;
  String phoneNumber_;

  // String _dob;
  String address_;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            width: 1.5,
            color: Colors.lightBlue[700],
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
            width: 1.5,
          ),
        ),
        labelText: 'Enter Name',
        counter: new SizedBox(
          height: 0,
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.lightBlue[700],
        ),
      ),
      // controller: nameController,
      // SizedBox(height: 25.0,),
      maxLength: 24,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }
        if (value.length < 3) {
          return 'Enter the Correct Name';
        }
        if (value.length > 23) {
          return 'Entered Name is too Long';
        }
        return null;
      },
      onSaved: (String val) {
        name_ = val;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(width: 1, color: Colors.lightBlue[700]),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
            width: 1.5,
          ),
        ),
        labelText: 'Email Address',
        counter: new SizedBox(
          height: 0,
        ),
        prefixIcon: Icon(
          Icons.email,
          color: Colors.lightBlue[700],
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        return null;
      },
      onSaved: (String value) {
        email_ = value;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(width: 1, color: Colors.lightBlue[700]),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
            width: 1.5,
          ),
        ),
        labelText: 'Mobile Number',
        counter: new SizedBox(
          height: 0,
        ),
        prefixIcon: Icon(
          Icons.phone_iphone,
          color: Colors.lightBlue[700],
        ),
      ),
      maxLength: 10,
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone number is Required';
        }
        if (value.length < 10) {
          return 'Please Enter the Correct Phone Number';
        }

        return null;
      },
      onSaved: (String value) {
        phoneNumber_ = value;
      },
    );
  }

  Widget _buildDOB(BuildContext context) {
    // DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS");
    // final tf = new DateFormat('H:m:s').format(date);
    final df = new DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');

    return TextFormField(
      controller: dateCtl_,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(width: 1, color: Colors.lightBlue[700]),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
            width: 1.5,
          ),
        ),
        labelText: "Date of birth",
        counter: new SizedBox(
          height: 0,
        ),
        prefixIcon: Icon(
          Icons.calendar_today,
          color: Colors.lightBlue[700],
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'DOB is Required';
        }
        return null;
      },
      onTap: () async {
        DateTime date = DateTime(1920);
        FocusScope.of(context).requestFocus(new FocusNode());

        date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        // dateCtl.text = df.format(DateTime.now());
        dateCtl_.text = DateFormat(
          "yyyy-MM-ddTHH:mm:ss.SSS",
        ).format(date);
        // dateCtl.text = DateTime.now().toUtc().toIso8601String();
      },
      onSaved: (String value) {
        dateCtl_.text = value;
      },
    );
  }

  Widget _buildCreatedDate(BuildContext context) {
    // final df = new DateFormat('dd-MM-yyyy');
    return TextFormField(
      controller: createdDateCtl_,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(width: 1, color: Colors.lightBlue[700]),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
            width: 1.5,
          ),
        ),
        labelText: "Your Point of Creation",
        counter: new SizedBox(
          height: 0,
        ),
        prefixIcon: Icon(
          Icons.calendar_today,
          color: Colors.lightBlue[700],
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'It is Required';
        }
        return null;
      },
      onTap: () async {
        DateTime date = DateTime.now();
        FocusScope.of(context).requestFocus(new FocusNode());

        date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now(),
        );

        // dateCtl.text = df.format(date);
        createdDateCtl_.text = DateFormat(
          "yyyy-MM-ddTHH:mm:ss.SSS",
        ).format(DateTime.now());
        // dateCtl.text = DateTime.now().toUtc().toIso8601String();
      },
      onSaved: (String value) {
        createdDateCtl_.text = value;
      },
    );
  }

  Widget _buildAddress() {
    return TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(width: 1, color: Colors.lightBlue[700]),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
            width: 1.5,
          ),
        ),
        labelText: 'Your Address',
        counter: new SizedBox(
          height: 0,
        ),
        prefixIcon: Icon(
          Icons.place,
          color: Colors.lightBlue[700],
        ),
      ),
      maxLength: 70,
      showCursor: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address is Required';
        }
        if (value.length < 10) {
          return 'Address is Too Short';
        }
        if (value.length > 60) {
          return 'Address is Too Long';
        }
        return null;
      },
      onSaved: (String value) {
        address_ = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blue[900],
              Colors.lightBlue[600],
              Colors.lightBlue[100],
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Text(
                      "VISUAL INFOSOFT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(24),
                        child: Form(
                          key: _key,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _buildName(),
                              Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              _buildAddress(),
                              Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              _buildDOB(context),
                              Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              _buildPhoneNumber(),
                              Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              _buildEmail(),
                              Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              _buildCreatedDate(context),
                              Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              //
                              SizedBox(height: 50),
                              //

                              _user == null
                                  ? Container(
                                      // child: Text('Not Submitted Yet'),
                                      )
                                  : Text(
                                      "The user ${_user.isSuccess}, ${_user.message} is the message by user",
                                    ),
                              //
                              Container(
                                height: 48,
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    colors: [
                                      Colors.blue[600],
                                      Colors.lightBlue[400],
                                      Colors.lightBlue[100],
                                    ],
                                  ),
                                ),
                                child: OutlineButton(
                                  borderSide: BorderSide.none,
                                  color: Colors.orange,
                                  child: Center(
                                    child: Text(
                                      'POST',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (!_key.currentState.validate()) {
                                      return null;
                                    }
                                    _key.currentState.save();
                                    print(sr_no);
                                    print(name_);
                                    print(address_);
                                    print(dateCtl_.text);
                                    print(email_);
                                    print(phoneNumber_);
                                    print(createdDateCtl_.text);

                                    final int _srno = sr_no;
                                    final String _name = name_;
                                    final String _address = address_;
                                    final String _phoneNumber = phoneNumber_;
                                    final String _email = email_;
                                    final String dateCtl = dateCtl_.text;
                                    final String createdDateCtl =
                                        createdDateCtl_.text;

                                    final UserModel user = await createUser(
                                      _srno,
                                      _name,
                                      _address,
                                      dateCtl,
                                      _phoneNumber,
                                      _email,
                                      createdDateCtl,
                                    );

                                    print(
                                        "Values Printed in Console : Success");

                                    setState(() {
                                      _user = user;
                                      // print(user);
                                      // print(int.parse(sr_no));
                                    });

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GetPage()));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
