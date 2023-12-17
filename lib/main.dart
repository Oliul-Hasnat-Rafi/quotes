import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quotes/Hive/model_hive.dart';
import 'package:quotes/home.dart';
import 'package:quotes/Hive/save.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

Box? box;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  box = await Hive.openBox<model_hive>("Favt");
  Hive.registerAdapter(modelhiveAdapter());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static final title = 'Quotes';
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _currentIndex = 0;
  List pages = [Home(), Save()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: MyApp.title,
        debugShowCheckedModeBanner: false,
        theme: ThemeClass.lightTheme,
        darkTheme: ThemeClass.darkTheme,
        themeMode: ThemeMode.system,
        home: Scaffold(
          appBar: AppBar(
            title: Text(MyApp.title),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            centerTitle: true,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                color: Colors.green.shade400,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: SalomonBottomBar(
              backgroundColor: Colors.transparent,
              currentIndex: _currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
              items: [
                SalomonBottomBarItem(
                    icon: Icon(Icons.format_quote_sharp),
                    title: Text("Quotes"),
                    selectedColor: Colors.lightBlue.shade900),
                SalomonBottomBarItem(
                  icon: Icon(Icons.favorite_border_outlined),
                  title: Text("Favorite"),
                  selectedColor: Colors.blue.shade800,
                ),
              ],
            ),
          ),
          body: pages[_currentIndex],
        ));
  }
}

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.green,
      ));

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.dark(),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
      ));
}
