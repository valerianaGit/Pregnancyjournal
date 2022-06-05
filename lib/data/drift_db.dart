// STEP 1 -
//IMPORT STATEMENTS - import drift package
import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
// import generated file by drift
part 'drift_db.g.dart';

// STEP 2
//- Create table for data model
// name of auto generated data class will be class name with no s (Post)
// @DataClassName('CustomName') => would change the autogenerated class name
class Posts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text().nullable()();
  DateTimeColumn get date => dateTime().nullable()();
}

//STEP 3 -
//this annotation tells drift to prepare a database class uses the
// table we just defined (Posts).
@DriftDatabase(tables: [Posts])
class JournalDatabase extends _$JournalDatabase {
//STEP 4 -
// Generating the code with dRIFT
  JournalDatabase() : super(_openConnection());

// bump this number whenever you change or add a table definition
  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file, logStatements: true); // STEP 5 - SET logs to true 
  });
}
