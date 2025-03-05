import 'package:flutter/material.dart';
import 'package:flutter_advance1/models/calary.dart';
import 'package:flutter_advance1/pages/goals.dart';
import 'package:flutter_advance1/server/catagory_adapter.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); //hive initializing
  Hive.registerAdapter(CalaryModelAdapter());
  Hive.registerAdapter(CatagoryAdapter());
  await Hive.openBox("foodDatabase"); //createing hive box
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: goals(),
      ),
    );
  }
}
