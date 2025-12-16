import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nutritrack/app.dart';
import 'package:nutritrack/firebase_options.dart';
import 'package:nutritrack/features/children/provider/children_provider.dart';
import 'package:nutritrack/features/nutrition/provider/nutrition_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChildrenProvider()),
        ChangeNotifierProvider(create: (_) => NutritionProvider()),
      ],
      child: const NutriGeneApp(),
    ),
  );
}
