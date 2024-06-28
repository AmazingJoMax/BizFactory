import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:namer_app/generator.dart';
import 'package:namer_app/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyAppState extends ChangeNotifier {
  Database db = Database();
  var current = WordPair.random();
  var isSaved = false;

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleSaved(String name, String details) {
    if (isSaved) {
      db.deleteLast();
      isSaved = false;
    } else {
      db.save(name, details);
      isSaved = true;
    }
    db.saveData();
    notifyListeners();
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Toastification toastification = Toastification();
  final _inputController = TextEditingController();
  String? result = '';
  var finalResult = '';

  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  GlobalKey _four = GlobalKey();
  GlobalKey _five = GlobalKey();
  GlobalKey _six = GlobalKey();
  final _firstTime = Hive.box('firstTime');

  @override
  initState() {
    if(_firstTime.get("FIRSTTIME") == null){
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          ShowCaseWidget.of(context)
              .startShowCase([_one, _two, _three, _four, _five, _six]));
      _firstTime.put("FIRSTTIME", false);
    }
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    void displayResult() async {
      showDialog(
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.3),
          context: context,
          builder: (context) {
            return Center(
              child: SpinKitWave(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          });
      result = await generateIdea(_inputController.text);
      setState(() {
        if (result == null) {
          toastification.show(
            context: context,
            type: ToastificationType.error,
            style: ToastificationStyle.flatColored,
            title: Text("An error occured"),
            autoCloseDuration: const Duration(seconds: 4),
          );
        } else {
          finalResult = result!;
        }
      });

      if (context.mounted) Navigator.of(context).pop();
    }

    IconData icon;
    if (appState.isSaved) {
      icon = Icons.bookmark;
    } else {
      icon = Icons.bookmark_add_outlined;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "BizFactory",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          actions: [
            Showcase(
              key: _five,
              description: 'Click here to view saved ideas',
              targetShapeBorder: CircleBorder(),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/bookmarks');
                  },
                  icon: Icon(
                    Icons.bookmarks,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
            ),
            Showcase(
              key: _six,
              description: 'Click here to view the tutorial again',
              targetShapeBorder: CircleBorder(),
              child: IconButton(
                onPressed: () {
                  ShowCaseWidget.of(context)
                      .startShowCase([_one, _two, _three, _four, _five, _six]);
                },
                icon: Icon(
                  Icons.help_outline_rounded,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            )
          ],
          // centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Markdown(
                selectable: true,
                data: finalResult,
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Showcase(
                      key: _one,
                      description: 'Click here to generate a name',
                      targetShapeBorder: CircleBorder(),
                      child: IconButton(
                        onPressed: () {
                          appState.getNext();
                          setState(() {
                            _inputController.text = pair.asPascalCase;
                            appState.isSaved = false;
                          });
                        },
                        icon: Icon(
                          Icons.autorenew_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ), // refresh icon
                      ),
                    ),
                    Expanded(
                      child: Showcase(
                        key: _two,
                        description: 'Enter a name or edit generated name',
                        targetShapeBorder: CircleBorder(),
                        child: TextField(
                          controller: _inputController,
                          decoration: InputDecoration(
                            hintText: 'Enter a name',
                            constraints: BoxConstraints(maxHeight: 40),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueGrey, width: 10.0),
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                      ),
                    ),
                    Showcase(
                      key: _three,
                      description: 'Click here to save idea to bookmarks',
                      targetShapeBorder: CircleBorder(),
                      child: IconButton(
                        onPressed: () {
                          appState.toggleSaved(
                              _inputController.text, finalResult);
                        },
                        icon: Icon(icon),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Showcase(
                      key: _four,
                      description: 'Click here to generate idea',
                      targetShapeBorder: CircleBorder(),
                      child: IconButton.filled(
                          onPressed: () {
                            if (_inputController.text.isEmpty) {
                              toastification.show(
                                context: context,
                                type: ToastificationType.error,
                                style: ToastificationStyle.flatColored,
                                title: Text("Please make an input"),
                                autoCloseDuration: const Duration(seconds: 4),
                              );
                            } else {
                              displayResult();
                            }
                          },
                          icon: Icon(Icons.arrow_upward_outlined)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
