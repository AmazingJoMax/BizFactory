import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:namer_app/pages/details.dart';
import 'package:namer_app/pages/home.dart';
import 'package:namer_app/database.dart';

class Bookmarks extends StatefulWidget {
  Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  Database db = Database();
  final _ideas = Hive.box('ideas');
  @override
  void initState() {
    if (_ideas.get("IDEAS") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmarks"),
      ),
      body: ListView.builder(
        itemCount: db.ideas.length,
        itemBuilder: (context, index) {
          final item = db.ideas[index];
          final name = item[0];
          return Dismissible(
            direction: DismissDirection.endToStart,
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              color: Colors.blueAccent,
              alignment: Alignment.centerRight,
              child: Icon(Icons.delete),
            ),
            key: Key(name),
            onDismissed: (direction) {
              db.ideas.removeAt(index);
              MyAppState().isSaved = false;
              db.saveData();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('$name deleted')));
            },
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailsPage(
                          idea: item,
                        )));
              },
              leading: Icon(
                Icons.circle,
                color: Colors.blueGrey,
              ),
              title: Text(name),
            ),
          );
        },
      ),
    );
  }
}
