import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_page.dart';
import 'package:pregnancy_journal_m1/data/drift_db.dart'; // STEP 1 - USE DRIFT WITH PROVIDER - IMPORT

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<JournalDatabase>(
      // STEP 2 - USE DRIFT WITH PROVIDER - use database type at root
      create: (context) =>
          JournalDatabase(), // STEP 3 - USE DRIFT WITH PROVIDER - create db object for context
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
      dispose: (context, db) => db
          .close(), // STEP 4 - USE DRIFT WITH PROVIDER - dispose / close db after material app
    );
  }
}

/**
 * 
 *      Packages used 
 * Internationalization https://pub.dev/packages/intl/install
 * to be able to format date and time 
 * 
 * Provider https://pub.dev/packages/provider
 * to manage state 
 * 
 *   drift: ^1.6.0  - store data locally
  path: ^1.8.1 - find a path for database
  dev_ dependencies:
   drift_dev: ^1.6.0 & build_runner: ^2.1.10 - DRIFT dev dependencies to generate code  
 * 
 *      Tips 
 * //makes textfield scrollable - wrap in Expanded widget + maxlines = null 
 * -> https://dev.to/valerianagit/flutter-create-a-scrollable-text-and-textfield-widgets-obp
  //scrollable Text - > wrap in SingleChildScrollView -> wrap that in Expanded 
 * 
 */
