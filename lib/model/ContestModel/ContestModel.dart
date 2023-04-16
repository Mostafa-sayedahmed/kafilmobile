// To parse this JSON data, do
//
//     final contestnetworkmodel = contestnetworkmodelFromJson(jsonString);

import 'dart:convert';

Contestnetworkmodel contestnetworkmodelFromJson(String str) => Contestnetworkmodel.fromJson(json.decode(str));

String contestnetworkmodelToJson(Contestnetworkmodel data) => json.encode(data.toJson());

class Contestnetworkmodel {
    Contestnetworkmodel({
        required this.id,
        required this.posts,
        required this.views,
        required this.accepted,
        required this.comment,
        required this.completed,
        required this.conditions,
        required this.contestDuration,
        required this.contestants,
        required this.deliveryDuration,
        required this.description,
        required this.firstWinner,
        required this.sectionId,
        required this.skills,
        required this.title,
        required this.userId,
        required this.userImg,
        required this.userName,
        required this.winnersNum,
    });

    String id;
    int posts;
    int views;
    bool accepted;
    int comment;
    bool completed;
    String conditions;
    String contestDuration;
    int contestants;
    String deliveryDuration;
    String description;
    String firstWinner;
    String sectionId;
    String skills;
    String title;
    String userId;
    String userImg;
    String userName;
    String winnersNum;

    factory Contestnetworkmodel.fromJson(Map<String, dynamic> json) => Contestnetworkmodel(
        id: json["id"],
        posts: json["Posts"],
        views: json["Views"],
        accepted: json["accepted"],
        comment: json["comment"],
        completed: json["completed"],
        conditions: json["conditions"],
        contestDuration: json["contestDuration"],
        contestants: json["contestants"],
        deliveryDuration: json["deliveryDuration"],
        description: json["description"],
        firstWinner: json["firstWinner"],
        sectionId: json["sectionId"],
        skills: json["skills"],
        title: json["title"],
        userId: json["userId"],
        userImg: json["userImg"],
        userName: json["userName"],
        winnersNum: json["winnersNum"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "Posts": posts,
        "Views": views,
        "accepted": accepted,
        "comment": comment,
        "completed": completed,
        "conditions": conditions,
        "contestDuration": contestDuration,
        "contestants": contestants,
        "deliveryDuration": deliveryDuration,
        "description": description,
        "firstWinner": firstWinner,
        "sectionId": sectionId,
        "skills": skills,
        "title": title,
        "userId": userId,
        "userImg": userImg,
        "userName": userName,
        "winnersNum": winnersNum,
    };
}
