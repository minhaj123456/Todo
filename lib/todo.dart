// ignore_for_file: sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Textt extends StatefulWidget {
  Textt({super.key});

  @override
  State<Textt> createState() => _TexttState();
}

class _TexttState extends State<Textt> {
  DateTime _dateTime = DateTime.now();
  TextEditingController TextControl = TextEditingController();

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2030))
        .then(
      (value) => setState(
        () {
          _dateTime = value!;
        },
      ),
    );
  }

  // void deletehaaa(docId) {
  //   haaa.doc(docId).delete();
  // }

  void setData() {
    FirebaseFirestore.instance
        .collection('haaa')
        .add({'not': TextControl.text, 'date': _dateTime}).then(
      (value) => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 200, left: 20, right: 20),
          child: Column(
            children: [
              TextField(
                controller: TextControl,
                decoration: const InputDecoration(
                    hintText: "NOT", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    MaterialButton(
                      onPressed: _showDatePicker,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              _dateTime.toString(),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      color: const Color.fromARGB(255, 4, 166, 211),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () {
                    setData();
                  },
                  child: const Text("Submit"),
                  color: Colors.red,
                  minWidth: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
