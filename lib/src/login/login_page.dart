import 'package:flutter/material.dart';
import 'package:hasura_teste/src/login/login_bloc.dart';
import 'package:hasura_teste/src/login/login_module.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

final bloc = LoginModule.to.getBloc<LoginBloc>();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: bloc.controller,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            RaisedButton(
              onPressed: () {
                bloc.login();
              },
              child: Text('Acessar'),
            )
          ],
        ),
      ),
    );
  }
}
