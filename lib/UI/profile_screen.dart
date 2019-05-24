import 'package:flutter/material.dart';
import 'package:flutter_pre_final/METHOD/app_tools.dart';
import 'package:flutter_pre_final/METHOD/sqllite.dart';

class ProfileScreen extends StatefulWidget {
  Account acc;
  ProfileScreen({this.acc});
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  int id;
  String userID;
  String pass;
  String age;
  String name;
  String quote;

  int countSpace(String s) {
    int result = 0;
    for (int i = 0; i < s.length; i++) {
      if (s[i] == ' ') {
        result += 1;
      }
    }
    return result;
  }

  bool isNumeric(String s) {
  if(s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('PROFILE'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.blue,
                ),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  hintText: 'User Id',
                  border: InputBorder.none,
                  fillColor: Colors.blue,
                ),
                onSaved: (value) => userID = value,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.blue,
                ),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.blue,
                  ),
                  hintText: 'Name',
                  border: InputBorder.none,
                  fillColor: Colors.blue,
                ),
                onSaved: (value) => name = value,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.blue,
                ),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.date_range,
                    color: Colors.blue,
                  ),
                  hintText: 'Age',
                  border: InputBorder.none,
                  fillColor: Colors.blue,
                ),
                onSaved: (value) => age = value,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.blue,
                ),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.blue,
                  ),
                  hintText: 'Password',
                  border: InputBorder.none,
                  fillColor: Colors.blue,
                ),
                obscureText: true,
                onSaved: (value) => pass = value,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(bottom: 20.0),
              height: 200.0,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              child: TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: TextStyle(
                  color: Colors.blue,
                ),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.book,
                    color: Colors.blue,
                  ),
                  hintText: 'Quote',
                  border: InputBorder.none,
                  fillColor: Colors.blue,
                ),
                onSaved: (value) => quote = value,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    _formKey.currentState.save();
                    if (userID.length < 6 || userID.length > 12) {
                      _scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Text("User Id ต้องมีความยาวอยู่ในช่วง 6 - 12 ตัวอักษร")));
                    } else if (countSpace(name) != 1) {
                      _scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Text("Name ต้องมีทั้งชื่อและนามสกุลโดยคั่นด้วย space 1 space เท่านั้น")));
                    } else if (!isNumeric(age) || int.parse(age) < 10 || int.parse(age) > 80) {
                      _scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Text("Age ต้องเป็นตัวเลขเท่านั้นและอยู่ในช่วง 10 - 80")));
                    } else if (pass.length < 6) {
                      _scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Text("Password มีความยาวมากกว่า 6")));
                    } else {
                      AccountProvider.db.updateAccount((Account(id: widget.acc.id, userId: userID, name: name, age: int.parse(age), password: pass)));
                      writeData(quote);
                      writeDataLocally(key: "userid", value: userID);
                      writeDataLocally(key: "name", value: name);
                      Navigator.pop(context, true);
                    }
                  },
                  child: Text('SAVE'),
                )),
          ],
        ),
      ),
    );
  }
}
