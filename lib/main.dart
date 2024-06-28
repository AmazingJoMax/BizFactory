import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:namer_app/pages/bookmarks.dart';
import 'package:namer_app/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:showcaseview/showcaseview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var ideas = await Hive.openBox('ideas');
  await Hive.openBox('firstTime');
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Biz Factory',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
        home: FirstTime(),
        routes: {
          '/bookmarks': (context) => Bookmarks(),
        },
      ),
    );
  }
}

class FirstTime extends StatelessWidget {
  const FirstTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      // autoPlay: true,
      // autoPlayDelay: Duration(seconds: 3),
      builder: (context) => HomePage(),
    );
  }
}
