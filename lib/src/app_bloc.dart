import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_teste/src/models/user_model.dart';
import 'package:rxdart/subjects.dart';

class AppBloc extends BlocBase {
  var userController = BehaviorSubject<UserModel>();

  @override
  void dispose() {
    userController.close();
    super.dispose();
  }
}
