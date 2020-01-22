import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:hasura_teste/src/models/message_model.dart';
import 'package:hasura_teste/src/models/user_model.dart';

class AppRepository extends Disposable {
  final HasuraConnect connection;

  AppRepository(this.connection);

  Future<UserModel> getUser(String user) async {
    var query = """
    getUsers(\$name:String!){
    user(where: {name: {_eq: "\$name"}}) {
    name
    id
  }
}
""";
    var data = await connection.query(query, variables: {"name": user});
    if (data["data"]["user"].isEmpty) {
      return createUser(user);
    } else {
      return UserModel.fromJson(data["data"]["user"][0]);
    }
  }

  Future<UserModel> createUser(String name) async {
    var insert = """ 
    mutation createUser(\$name:String){
    insert_user(objects: {name: \$name}) {
    returning {
      id
    }
  }
}
""";
    var data = await connection.mutation(insert, variables: {"name": name});
    var id = data["data"]["insert_user"]["returning"][0]["id"];
    return UserModel(id: id, name: name);
  }

  Stream<List<MessageModel>> getMessages() {
    var query = """ 
      subscription {
      messages(order_by: {id: desc}) {
      content
      id
      user {
        name
      }
    }
  }
      """;
    Snapshot snapshot = connection.subscription(query);
    return snapshot.stream.map(
        (jsonList) => MessageModel.fromJsonList(jsonList["data"]["messages"]));
  }

  Future<dynamic> sendMessage(String message, int userId) {


    var query = """
      sendMessage(\$message:String!,\$userId:Int!) {
      insert_messages(objects: {content: \$message, id_usuario: \$userId}) {
      affected_rows
  }
  }
      """;
    return connection.mutation(query, variables: {
      "message": message,
      "userId": userId,
    });
  }

  @override
  void dispose() {}
}
