import 'package:flutter/material.dart';
import 'package:pregnancy_journal_m1/screens/journal_entry_screen.dart';
import 'package:pregnancy_journal_m1/widgets/entries_list.dart';
import 'package:pregnancy_journal_m1/constants/strings.dart';

// HOME widgets. shows list with posts in chronological order
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(pregnancyJournal),
      ),
      body: const SafeArea(
        child: EntriesList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JournalEntryScreen(),
            ),
          );
        },
        tooltip: 'New entry',
        child: const Icon(Icons.add),
      ),
    );
  }
}