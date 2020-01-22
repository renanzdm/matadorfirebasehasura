import 'package:flutter/material.dart';
import 'package:hasura_teste/src/app_bloc.dart';
import 'package:hasura_teste/src/app_module.dart';
import 'package:hasura_teste/src/home/home_module.dart';
import 'package:hasura_teste/src/login/login_module.dart';
import 'package:hasura_teste/src/models/user_model.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AppModule.to.getBloc<AppBloc>();
    return MaterialApp(
        title: 'Flutter Slidy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder<UserModel>(
          stream: bloc.userController,
          builder: (context, snapshot) {
            return snapshot.hasData ? HomeModule() : LoginModule();
          },
        ));
  }
}
