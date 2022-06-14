// ENTRIES LIST WIDGET -  
// returns a list of Journal cards, 
// each journal card contains the information stored in the database

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pregnancy_journal_m1/widgets/journal_cards.dart';
import 'package:pregnancy_journal_m1/data/drift_db.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EntriesList extends StatefulWidget {
  const EntriesList({Key? key}) : super(key: key);

  @override
  State<EntriesList> createState() => _EntriesListState();
}

class _EntriesListState extends State<EntriesList> {

  @override
  Widget build(BuildContext context) {
    //STEP 1 - CREATE DATABASE INSTANCE
    final database = Provider.of<JournalDatabase>(context);
  // STEP 2 - FETCH STREAM LIST 
  Stream<List<Post>> entries = database.watchAllPosts();
  //STEP 3 - USE STREAM BUILDER
  return StreamBuilder( 
    //STEP 3.A . PASS THE STREAM LIST FROM DATABASE
    stream: entries, 
    //STEP 3.B . PASS A BUILD CONTEXT , 
    //SNAPSHOT IS THE DATA (OR LACK THEREOFF) 
    builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
  //STEP 4 - CONSUME DATA AND HANDLE NULL VALUES / ERRORS ETC. 
return ListView.builder(
          itemBuilder: (context, index) {
   //STEP4.A - IF WE GET DATA     
if (snapshot.hasData) {
           return Slidable(
                    // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),
        // The start action pane is the one at the left or the top side.
        endActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const StretchMotion(),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context) => deletePost(context, database, snapshot.data![index]), // note function call, GOTCHA!
              autoClose: true,
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
             child: JournalCard(
               //NOTE: USING THE BANG OPERATOR HERE IS SAFE ENOUGH BECAUSE WE CHECK IF SNAPSHOT HAS DATA
               // THE BANG OPERATOR IS FORCE UNWRAPPING, VERY DANGEROUS TO USE IN MOST CONDITIONS
                content: snapshot.data![index].content ?? 'No data today',
                date: snapshot.data![index].date ?? DateTime.now(),
              ),
           );
//STEP4.B - IF WE GET ERROR
          } else if (snapshot.hasError) {
             return JournalCard(
              content: 'Error: ${snapshot.error}', //entry.content[index],
              date: DateTime.now(),
            );
  //STEP4.C - IF WE ARE IDLE 
          } else {
             return JournalCard(
              content: 'Loading...', //entry.content[index],
              date: DateTime.now(),
            );
          }  
          },
          itemCount: snapshot.data?.length, //how to access the number of entries in database 
        );
    } 
  );
  }
   void deletePost(BuildContext context, JournalDatabase database, Post post) {
    database.deletePost(post);
  }
}