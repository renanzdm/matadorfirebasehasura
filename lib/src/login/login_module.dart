import 'package:hasura_teste/src/app_module.dart';
import 'package:hasura_teste/src/app_repository.dart';
import 'package:hasura_teste/src/login/login_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:hasura_teste/src/login/login_page.dart';

class LoginModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => LoginBloc(AppModule.to.getDependency<AppRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => LoginPage();

  static Inject get to => Inject<LoginModule>.of();
}
