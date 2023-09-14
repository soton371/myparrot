import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myparrot/configs/my_urls.dart';
import 'package:http/http.dart' as http;
import 'package:myparrot/models/delete_msg_mod.dart';
part 'delete_msg_event.dart';
part 'delete_msg_state.dart';

class DeleteMsgBloc extends Bloc<DeleteMsgEvent, DeleteMsgState> {
  DeleteMsgBloc() : super(DeleteMsgInitial()) {
    on<DoDeleteMsg>((event, emit) async{
      debugPrint("call DoDeleteMsg");
      emit(DeleteMsgLoading());
      
      try {
        Uri url = Uri.parse("${MyUrls.pending}/${event.msgId}");
        final response = await http.delete(url);
        if (response.statusCode == 200) {
          final deleteMsgModel = deleteMsgModelFromJson(response.body);
          if (deleteMsgModel.status == 1) {
            emit(DeleteMsgSuccess());
          } else {
            emit(const DeleteMsgFailed(
                errorMsg:
                    "Delete failed, please try again"));
          }
        } else {
          emit(const DeleteMsgFailed(errorMsg: "Internal server error"));
        }
      } on TimeoutException catch (e) {
        debugPrint("TimeoutException: $e");
        emit(const DeleteMsgFailed(errorMsg: "Timeout please try again"));
      } on SocketException catch (e) {
        debugPrint("SocketException: $e");
        emit(const DeleteMsgFailed(
            errorMsg: "Please check your internet connection"));
      } catch (e) {
        emit(const DeleteMsgFailed(errorMsg: "Something went wrong"));
      }
    });
  }
}
