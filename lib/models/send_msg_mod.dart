// To parse this JSON data, do
//
//     final sendMsgModel = sendMsgModelFromJson(jsonString);

import 'dart:convert';

SendMsgModel sendMsgModelFromJson(String str) => SendMsgModel.fromJson(json.decode(str));

String sendMsgModelToJson(SendMsgModel data) => json.encode(data.toJson());

class SendMsgModel {
    Data? data;
    int? status;
    String? message;

    SendMsgModel({
        this.data,
        this.status,
        this.message,
    });

    factory SendMsgModel.fromJson(Map<String, dynamic> json) => SendMsgModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
        "message": message,
    };
}

class Data {
    String? deviceId;
    String? name;
    String? message;
    String? scheduledAt;
    String? phones;
    String? date;
    String? status;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    Data({
        this.deviceId,
        this.name,
        this.message,
        this.scheduledAt,
        this.phones,
        this.date,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        deviceId: json["device_id"],
        name: json["name"],
        message: json["message"],
        scheduledAt: json["scheduled_at"],
        phones: json["phones"],
        date: json["date"],
        status: json["status"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "device_id": deviceId,
        "name": name,
        "message": message,
        "scheduled_at": scheduledAt,
        "phones": phones,
        "date": date,
        "status": status,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
