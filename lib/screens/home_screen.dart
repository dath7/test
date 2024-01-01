import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:test_vais/model/friend.dart';

class HomeScreen extends StatelessWidget {
  final List<String> _names = List.generate(
      10,
      (index) =>
          "Nguyen Van ${String.fromCharCode("A".codeUnitAt(0) + index)}"); // A-J
  final List<String> _status =
      List.generate(10, (index) => (index + 1).toString()); //0-9
  late final List<Friend> _contacts = List.generate(
      10,
      (index) => Friend(
          name: _names[index],
          status: _status[index],
          avatar: "assets/images/avatar/avatar$index.jpg"));

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Contacts"), Icon(Icons.search)],
        ),
      ),
      drawer: Drawer(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Text("Hello"),
          ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );

                await FirebaseAuth.instance.signOut().whenComplete(
                    () => Navigator.pop(context)); // turn off circular process
              },
              style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.lightBlue),
              ),
              child: const Text("Sign out"))
        ]),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          final friend = _contacts[index];
          return Card(
            child: ListTile(
              subtitle: Text(friend.status),
              title: Text(
                friend.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Container(
                margin: const EdgeInsets.all(8.0),
                child: Image.asset(friend.avatar),
              ),
            ),
          );
        },
      ),
    );
  }
}
