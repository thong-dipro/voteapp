import 'dart:ffi';

class Team {
  String Asset;
  String Name;
  String Desc;
  int Like;
  Team(this.Name, this.Asset, this.Desc, this.Like);
  factory Team.fromJson(dynamic json) {
    return Team(json['Name'] as String, json['Asset'] as String,
        json["Desc"] as String, json["Like"] as int);
  }
}
