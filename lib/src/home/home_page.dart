import 'package:flutter/material.dart';
import 'package:hasura_teste/src/app_bloc.dart';
import 'package:hasura_teste/src/app_module.dart';
import 'package:hasura_teste/src/app_repository.dart';
import 'package:hasura_teste/src/home/home_bloc.dart';
import 'package:hasura_teste/src/home/home_module.dart';
import 'package:hasura_teste/src/models/message_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var repo = AppModule.to.getDependency<AppRepository>();
  Stream<List<MessageModel>> messageOut;
  final bloc = HomeModule.to.getBloc<HomeBloc>();
  final appbloc = AppModule.to.getBloc<AppBloc>();

  void sendMessage() {
    repo.sendMessage(bloc.controller.text, appbloc.userController.value.id);
    bloc.controller.clear();
  }

  @override
  void initState() {
    messageOut = repo.getMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: StreamBuilder<List<MessageModel>>(
          stream: messageOut,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index].user.name),
                        subtitle: Text(snapshot.data[index].content),
                      );
                    },
                  ),
                ),
                TextField(
                  controller: bloc.controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: sendMessage,
                      )),
                ),
              ],
            );
          }),
    );
  }
}
