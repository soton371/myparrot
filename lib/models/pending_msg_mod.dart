// To parse this JSON data, do
//
//     final pendingMsgModel = pendingMsgModelFromJson(jsonString);

import 'dart:convert';

PendingMsgModel pendingMsgModelFromJson(String str) => PendingMsgModel.fromJson(json.decode(str));

String pendingMsgModelToJson(PendingMsgModel data) => json.encode(data.toJson());

class PendingMsgModel {
    List<Datum>? data;
    int? status;
    String? message;

    PendingMsgModel({
        this.data,
        this.status,
        this.message,
    });

    factory PendingMsgModel.fromJson(Map<String, dynamic> json) => PendingMsgModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
        "message": message,
    };
}

class Datum {
    int? id;
    String? deviceId;
    String? name;
    String? message;
    String? phones;
    String? scheduledAt;
    String? date;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.deviceId,
        this.name,
        this.message,
        this.phones,
        this.scheduledAt,
        this.date,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        deviceId: json["device_id"],
        name: json["name"],
        message: json["message"],
        phones: json["phones"],
        scheduledAt: json["scheduled_at"],
        date: json["date"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "device_id": deviceId,
        "name": name,
        "message": message,
        "phones": phones,
        "scheduled_at": scheduledAt,
        "date": date,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
