// ENTRIES LIST WIDGET -  
// returns a list of Journal cards, 
// each journal card contains the information stored in the database

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pregnancy_journal_m1/widgets/journal_cards.dart';
import 'package:pregnancy_journal_m1/data/drift_db.dart';

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
  // STEP 2 - FETCH FUTURE LIST 
  Future<List<Post>> entries = database.getAllPosts();
  //STEP 3 - USE FUTURE BUILDER
  return FutureBuilder( 
    //STEP 3.A . PASS THE FUTURE LIST FROM DATABASE
    future: entries, 
    //STEP 3.B . PASS A BUILD CONTEXT , 
    //SNAPSHOT IS THE DATA (OR LACK THEREOFF) 
    builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
  //STEP 4 - CONSUME DATA AND HANDLE NULL VALUES / ERRORS ETC. 
return ListView.builder(
          itemBuilder: (context, index) {
   //STEP4.A - IF WE GET DATA     
if (snapshot.hasData) {
           return JournalCard(
             //NOTE: USING THE BANG OPERATOR HERE, IS SAFE ENOUGH BECAUSE WE CHECK IF SNAPSHOT HAS DATA
             // YET THE BANG OPERATOR IS FORCE UNWRAPPING AND VERY DANGEROUS TO USE IN MOST CONDITIONS
              content: snapshot.data![index].content ?? 'No data today',
              date: snapshot.data![index].date ?? DateTime.now(),
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
}