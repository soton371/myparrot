// To parse this JSON data, do
//
//     final calendarModel = calendarModelFromJson(jsonString);

import 'dart:convert';

CalendarModel calendarModelFromJson(String str) => CalendarModel.fromJson(json.decode(str));

String calendarModelToJson(CalendarModel data) => json.encode(data.toJson());

class CalendarModel {
    List<Counter>? counter;
    int? status;
    String? message;

    CalendarModel({
        this.counter,
        this.status,
        this.message,
    });

    factory CalendarModel.fromJson(Map<String, dynamic> json) => CalendarModel(
        counter: json["counter"] == null ? [] : List<Counter>.from(json["counter"]!.map((x) => Counter.fromJson(x))),
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "counter": counter == null ? [] : List<dynamic>.from(counter!.map((x) => x.toJson())),
        "status": status,
        "message": message,
    };
}

class Counter {
    String? date;
    String? pendingCount;
    String? deliveryCount;
    String? failedCount;

    Counter({
        this.date,
        this.pendingCount,
        this.deliveryCount,
        this.failedCount,
    });

    factory Counter.fromJson(Map<String, dynamic> json) => Counter(
        date: json["date"],
        pendingCount: json["pending_count"],
        deliveryCount: json["delivery_count"],
        failedCount: json["failed_count"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "pending_count": pendingCount,
        "delivery_count": deliveryCount,
        "failed_count": failedCount,
    };
}
