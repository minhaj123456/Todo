import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo1/todo.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final CollectionReference haaa =
      FirebaseFirestore.instance.collection('haaa');
  void deletehaaa(docId) {
    haaa.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 00, left: 40, top: 550),
        child: Center(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => Textt(),
                  ));
            },
            child: const Icon(Icons.fire_hydrant_alt_outlined),
          ),
        ),
      ),
      backgroundColor: Colors.lightBlue[700],
      
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: 550,
              width: 400,
              child: StreamBuilder<QuerySnapshot>(
                stream: haaa.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final donorsnap = snapshot.data!.docs[index];
                        DateTime date =
                            (donorsnap['date'] as Timestamp).toDate();

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.lightBlue[700],
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 2, 205, 246),
                                      blurRadius: 15,
                                      spreadRadius: 10)
                                ]),
                            height: 80,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(donorsnap['not'].toString(),
                                    style:
                                        const TextStyle(color: Colors.white)),
                                subtitle: Text(
                                    '${date.day}:${date.month}:${date.year}',
                                    style: TextStyle(color: Colors.white)),
                                trailing: IconButton(
                                  onPressed: () {
                                    deletehaaa(donorsnap.id);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
