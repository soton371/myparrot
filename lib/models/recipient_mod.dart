
import 'package:myparrot/db/db_helper.dart';

class RecipientModel {
  int? id;
  String name;
  String number;

  RecipientModel({this.id, required this.name, required this.number});

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnNumber: number,
    };
  }
}