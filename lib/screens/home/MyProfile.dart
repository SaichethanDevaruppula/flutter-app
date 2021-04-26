import 'package:flutter/material.dart';
import 'package:flutter_app/models/userr.dart';
import 'package:flutter_app/screens/shared/loading.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/database.dart';
import 'package:provider/provider.dart';

import 'EditInfoPage.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userr>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
          UserData user = snapshot.data;
          if(snapshot.hasData) {
            return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),

                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: CircleAvatar(
                              backgroundColor: Colors.greenAccent[400],
                              radius: 80,
                              child: Text(
                                'Image',
                                style: TextStyle(fontSize: 25, color: Colors.white),
                              ), //Text
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                  letterSpacing: 1.0
                                ),
                              ),
                              SizedBox(height: 8.0,),
                              Text(
                                user.location,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8.0,),
                              Text(
                                user.contact,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextButton.icon(
                                  style: TextButton.styleFrom(
                                    primary: Colors.black, // background
                                     // foreground
                                  ),
                                  label: Text(
                                    'Edit Info',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                    ),
                                  ),
                                  icon: Icon(Icons.settings),
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EditInfo()),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    Card(
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          primary: Colors.black, // background
                          // foreground
                        ),
                        onPressed: () async {
                          await _auth.signOut();
                        },
                        icon: Icon(Icons.account_circle_rounded),
                        label: Text('Signout'),
                      ),
                    ),
                  ],
                )
            );
          }
          else{
            return Loading();
          }
      }
    );
  }
}