import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myparrot/db/db_helper.dart';
import 'package:unique_identifier/unique_identifier.dart';

part 'identifier_event.dart';
part 'identifier_state.dart';

class IdentifierBloc extends Bloc<IdentifierEvent, IdentifierState> {
  String identifier = '';
  IdentifierBloc() : super(IdentifierInitial()) {
    on<FetchIdentifierEvent>((event, emit) async {
      debugPrint("call FetchIdentifierEvent");
      identifier = await DatabaseHelper.instance.fetchSerialNumber();
      if (identifier == 'null' || identifier.isEmpty) {
        try {
          identifier = (await UniqueIdentifier.serial) ?? 'null';
          await DatabaseHelper.instance.insertSerialNumber(identifier);
        } catch (e) {
          identifier = 'null';
          await DatabaseHelper.instance.insertSerialNumber(identifier);
        }
      }
      debugPrint("identifier: $identifier");
    });
  }
}
