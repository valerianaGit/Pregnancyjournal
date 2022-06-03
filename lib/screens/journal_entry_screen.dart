import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pregnancy_journal_m1/models/journal_entry_data.dart';
import 'package:pregnancy_journal_m1/constants/constants.dart';
import 'package:pregnancy_journal_m1/constants/strings.dart';

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
 JournalEntryScreen({this.incomingText = ''});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const Text(feelingsDesires,
                  style: ktitleTextStyle),
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
          toPressOrNotToPress(context);
        },
        tooltip: doneEditing,
        child: const Icon(Icons.check),
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

  void toPressOrNotToPress(BuildContext context) {
    if (incomingText == '' && newContent != '') {
      Provider.of<JournalEntryData>(context, listen: false)
          .addAnotherEntry(newContent);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }
}