// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote_app/Models/teams.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vote_app/Screen/VotingItem.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  int likecount = 20;
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    Stream<List<Team>> readTeam() => FirebaseFirestore.instance
        .collection("Team")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Team.fromJson(doc.data())).toList());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voting"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Headline',
              style: TextStyle(fontSize: 30),
            ),
            Expanded(
              child: StreamBuilder<List<Team>>(
                stream: readTeam(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Error while loading data");
                  } else if (snapshot.hasData) {
                    final teams = snapshot.data;
                    if (teams != null) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: teams.length,
                          itemBuilder: (context, index) {
                            var db = FirebaseFirestore.instance
                                .collection("Repert1");
                            int like = db.snapshots().length as int;
                            return VotingItem(
                              teams: teams[index],
                              likeCount: like,
                              user: widget().user,
                            );
                          });
                    } else {
                      return const Text("Hello");
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Team team1 = Team(
              "Name",
              "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
              "Desc",
              20);
          var db = FirebaseFirestore.instance.collection("Repert");
          final data = {
            "Name": "Name",
            "Asset":
                "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
            "Desc": "Moo ta",
            "Like": 20
          };
          db.add(data);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildTeam(Team team) => ListTile(
        title: Text(team.Name),
        subtitle: Text(team.Desc),
      );

  Widget likeWidget(int count) => const Text("323");
}
