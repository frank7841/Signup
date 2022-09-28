import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:register/components/read_data.dart';
import 'package:register/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  List<String> docIds = [];

  Future getDocID() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          (snapshot) => snapshot.docs.forEach((element) {
            docIds.add(element.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            user.email!,
            style: TextStyle(fontSize: 12),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("Signed Out");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                });
              },
              child: Icon(Icons.logout),
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('User Details'),
              Expanded(
                  child: FutureBuilder(
                future: getDocID(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: docIds.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: GetUserName(documentId: docIds[index]),
                            tileColor: Colors.grey,
                          ),
                        );
                      });
                },
              ))
            ],
          ),
        ));
  }
}
