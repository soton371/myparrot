import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myparrot/configs/my_urls.dart';
import 'package:http/http.dart' as http;
import 'package:myparrot/models/send_msg_mod.dart';
part 'edit_msg_event.dart';
part 'edit_msg_state.dart';

class EditMsgBloc extends Bloc<EditMsgEvent, EditMsgState> {
  EditMsgBloc() : super(EditMsgInitial()) {
    on<DoEditMsg>((event, emit) async{
      debugPrint("call DoEditMsg");
      emit(EditMsgLoading());
      final payload = {
        "message": event.message,
        "scheduled_at": event.scheduledAt,
        "phones": event.phones,
        "name": event.name
      };
      try {
        Uri url = Uri.parse("${MyUrls.pending}/${event.msgId}");
        final response = await http.post(url, body: payload);
        if (response.statusCode == 200) {
          final editMsgModel = sendMsgModelFromJson(response.body);
          if (editMsgModel.status == 1) {
            emit(EditMsgSuccess());
          } else {
            emit(const EditMsgFailed(
                errorMsg:
                    "Please choose a valid future date and time for scheduling"));
          }
        } else {
          emit(const EditMsgFailed(errorMsg: "Internal server error"));
        }
      } on TimeoutException catch (e) {
        debugPrint("TimeoutException: $e");
        emit(const EditMsgFailed(errorMsg: "Timeout please try again"));
      } on SocketException catch (e) {
        debugPrint("SocketException: $e");
        emit(const EditMsgFailed(
            errorMsg: "Please check your internet connection"));
      } catch (e) {
        emit(const EditMsgFailed(errorMsg: "Something went wrong"));
      }
    });
  }
}
