import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myparrot/db/db_helper.dart';
import 'package:unique_identifier/unique_identifier.dart';

Future<void> generateIdentifier() async {
  String identifier = '';
  try {
    fetchIdentifier().then((value) async {
      if (value.isEmpty || value == "null") {
        identifier = (await UniqueIdentifier.serial)!;
        debugPrint("identifier: $identifier");
        await DatabaseHelper.instance.insertSerialNumber(identifier);
        return;
      }
    });
  } on PlatformException {
    identifier = 'Failed to get Unique Identifier';
    debugPrint("identifier: $identifier");
    await DatabaseHelper.instance.insertSerialNumber(identifier);
  }
}

Future<String> fetchIdentifier() async {
  String id = '';
  id = await DatabaseHelper.instance.fetchSerialNumber();
  return id;
}
