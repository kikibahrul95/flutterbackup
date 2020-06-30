import 'package:databasepure/model/monster.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo hive database"),
      ),
      body: FutureBuilder(
        future: Hive.openBox("monsters"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Center(
                child: Text(snapshot.error),
              );
            else {
              var monsters = Hive.box("monster");
              if (monsters.length == 0) {
                monsters.add(Monster("vampir", 1));
                monsters.add(Monster("kunti", 2));
              }
              return ListView.builder(
                itemCount: monsters.length,
                itemBuilder: (context, index) {
                  Monster monster = monsters.getAt(index);
                  return Text(
                      monster.name + "[" + monster.level.toString() + "]");
                },
              );
            }
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }
}
