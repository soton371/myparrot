// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) => MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
    String? name;
    String? number;
    String? message;
    String? sendTime;

    MessageModel({
        this.name,
        this.number,
        this.message,
        this.sendTime,
    });

    factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        name: json["name"],
        number: json["number"],
        message: json["message"],
        sendTime: json["sendTime"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
        "message": message,
        "sendTime": sendTime,
    };
}
