import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:hasura_teste/src/app_module.dart';
import 'package:hasura_teste/src/app_repository.dart';

import '../app_bloc.dart';

class LoginBloc extends BlocBase {
  final AppRepository repository;
  TextEditingController controller = TextEditingController();
  final appBloc = AppModule.to.getBloc<AppBloc>();

  LoginBloc(this.repository);

  Future<bool> login() async {
    try {
      var user = await repository.getUser(controller.text);
      appBloc.userController.add(user);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
