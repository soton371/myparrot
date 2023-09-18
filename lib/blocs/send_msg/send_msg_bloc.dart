import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:myparrot/configs/my_urls.dart';
import 'package:http/http.dart' as http;
import 'package:myparrot/models/send_msg_mod.dart';
part 'send_msg_event.dart';
part 'send_msg_state.dart';

class SendMsgBloc extends Bloc<SendMsgEvent, SendMsgState> {
  SendMsgBloc() : super(SendMsgInitial()) {
    on<DoSendMsg>((event, emit) async {
      debugPrint("call DoSendMsg");
      emit(SendMsgLoading());
      final payload = {
        "message": event.message,
        "scheduled_at": event.scheduledAt,
        "phones": event.phone,
        "name": event.name,
        "device_id": event.deviceId
      };
      try {
        Uri url = Uri.parse(MyUrls.sendSms);
        final response = await http.post(url, body: payload);
        if (response.statusCode == 200) {
          final sendMsgModel = sendMsgModelFromJson(response.body);
          if (sendMsgModel.status == 1) {
            emit(SendMsgSuccess());
          } else {
            emit(const SendMsgFailed(
                errorMsg:
                    "Please choose a valid future date and time for scheduling"));
          }
        } else {
          emit(const SendMsgFailed(errorMsg: "Internal server error"));
        }
      } on TimeoutException catch (e) {
        debugPrint("TimeoutException: $e");
        emit(const SendMsgFailed(errorMsg: "Timeout please try again"));
      } on SocketException catch (e) {
        debugPrint("SocketException: $e");
        emit(const SendMsgFailed(
            errorMsg: "Please check your internet connection"));
      } catch (e) {
        emit(const SendMsgFailed(errorMsg: "Something went wrong"));
      }
    });
  }
}
