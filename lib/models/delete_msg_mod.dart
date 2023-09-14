// To parse this JSON data, do
//
//     final deleteMsgModel = deleteMsgModelFromJson(jsonString);

import 'dart:convert';

DeleteMsgModel deleteMsgModelFromJson(String str) => DeleteMsgModel.fromJson(json.decode(str));

String deleteMsgModelToJson(DeleteMsgModel data) => json.encode(data.toJson());

class DeleteMsgModel {
    int? status;
    String? message;

    DeleteMsgModel({
        this.status,
        this.message,
    });

    factory DeleteMsgModel.fromJson(Map<String, dynamic> json) => DeleteMsgModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
