import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pregnancy_journal_m1/constants/constants.dart';
import 'package:pregnancy_journal_m1/constants/strings.dart';
import 'package:pregnancy_journal_m1/data/drift_db.dart'; //DRIFT USE QUERIES - STEP 1 - IMPORT DB
import 'package:drift/drift.dart' hide Column;
//TODO: UPDATE Journal entry screen as statfeul widget since NEWCONTENT needs to mutate?

// class JournalEntryScreen extends StatefulWidget {
//   const JournalEntryScreen({Key key}) : super(key: key);

//   @override
//   State<JournalEntryScreen> createState() => _JournalEntryScreenState();
// }

// class _JournalEntryScreenState extends State<JournalEntryScreen> {
//   @override
//   Widget build(BuildContext context) {

//   }
// }

class JournalEntryScreen extends StatelessWidget {
  String newContent = '';
  String incomingText = '';
  // ignore: use_key_in_widget_constructors
  JournalEntryScreen({this.incomingText = ''});

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<JournalDatabase>(context);
    return Provider<JournalDatabase>(
      create: (context) => JournalDatabase(),
      
        child: Scaffold(
            appBar: AppBar(
              title: const Text(post),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50.0,
                    ),
                    const Text(feelingsDesires, style: ktitleTextStyle),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Theme(
                      data: ThemeData(
                          primaryColor: Colors.teal, primaryColorDark: Colors.teal),
                      child: getWidget(),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                toPressOrNotToPress(context, database);
              },
              tooltip: doneEditing,
              child: const Icon(Icons.check),
            ),
          ),

    );
  
  }

  Widget getWidget() {
    if (incomingText == '') {
      return Expanded(
        //makes textfield scrollable - wrap in Expanded widget + maxlines = null
        child: TextField(
          maxLines: null, //wrap text
          autofocus: true,
          autocorrect: true,
          cursorColor: Colors.purple[900],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: notesAndThoughts,
          ),
          onChanged: (newValue) {
            newContent = newValue;
          },
        ),
      );
    } else {
      return Expanded(
        child: SingleChildScrollView(
          //scrollable Text - > wrap in SingleChildScrollView -> wrap that in Expanded
          child: Text(
            incomingText,
            overflow: TextOverflow.visible,
          ),
        ),
      );
    }
  }

  void toPressOrNotToPress(BuildContext context, JournalDatabase database) {
    if (incomingText == '' && newContent != '') {
      database.insertNewCompanionPost(PostsCompanion(
          content: Value(newContent), date: Value(DateTime.now())));
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }
}
