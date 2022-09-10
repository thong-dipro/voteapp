import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:like_button/like_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:vote_app/Models/teams.dart';
import 'package:vote_app/Screen/main.dart';
import 'package:vote_app/Values/AppStyle.dart';

class VotingItem extends StatefulWidget {
  const VotingItem({Key? key, required this.teams, required this.likeCount})
      : super(key: key);
  final Team teams;
  final int likeCount;
  @override
  State<VotingItem> createState() => _VotingItemState();
}

class _VotingItemState extends State<VotingItem> {
  bool isLike = false;
  late int likeCount = widget.likeCount;
  late Team teams = widget.teams;
  late String email = "";
  Future<void> getEmail() async {
    email = await box.getAt(0);
  }

  @override
  Widget build(BuildContext context) {
    var db =
        FirebaseFirestore.instance.collection("Repert1").snapshots().length;

//     Stream<int> getLike (){
//     int like = db.snapshots().length as int;
// return StreamBuilder<int>(builder: )
//     }

    return Card(
      child: Column(
        children: [
          Text(teams.Name, style: AppStyle.h1),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            child: Image.network(
              teams.Asset,
              height: 500,
              width: 300,
              fit: BoxFit.fitHeight,
              semanticLabel: "Team 1",
            ),
          ),
          Row(
            children: [
              FutureBuilder<int>(
                  future: db,
                  initialData: 0,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("data");
                    }
                    return LikeButton(
                      size: 40,
                      circleColor: const CircleColor(
                          start: Color(0xff00ddff), end: Colors.pink),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: Color(0xff33b5e5),
                        dotSecondaryColor: Colors.pink,
                      ),
                      onTap: (isLike) async {
                        final data = {
                          "Repert1": {"LikeUser": email}
                        };
                        // db.add(data);
                        this.isLike = !isLike;
                        likeCount += this.isLike ? 1 : -1;
                        return !isLike;
                      },
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite,
                          color: isLiked ? Colors.pink : Colors.grey,
                          size: 40,
                        );
                      },
                      likeCount: snapshot.data as int,
                      countBuilder: (likeCount, isLiked, text) {
                        final color = isLiked ? Colors.pink : Colors.grey;
                        return Text(
                          text,
                          style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: 31),
                        );
                      },
                    );
                  }),
              // Text(
              //   "$likecount",
              //   style: const TextStyle(fontSize: 20),
              // )
            ],
          )
        ],
      ),
    );
  }
}
