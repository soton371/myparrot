import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myparrot/configs/my_urls.dart';
import 'package:myparrot/models/pending_msg_mod.dart';
import 'package:http/http.dart' as http;
part 'failed_event.dart';
part 'failed_state.dart';

class FailedBloc extends Bloc<FailedEvent, FailedState> {
  FailedBloc() : super(FailedInitial()) {
    on<FetchFailedMsg>((event, emit) async{
      debugPrint("call FetchDeliveryMsg");
      emit(FailedFetchLoading());
      try {
        Uri url = Uri.parse("${MyUrls.failed}/${event.deviceId}");
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final pendingMsgModel = pendingMsgModelFromJson(response.body);
          final data = pendingMsgModel.data;
          if (data != null && data.isNotEmpty) {
            List<Datum> failedMsgs = data;
            failedMsgs.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
            emit(FailedFetched(failedMsgList: failedMsgs));
          } else {
            emit(
                const FailedFetchFailed(errorMsg: "No Communication History"));
          }
        } else {
          emit(const FailedFetchFailed(errorMsg: "Internal server error"));
        }
      } on TimeoutException catch (e) {
        debugPrint("TimeoutException: $e");
        emit(const FailedFetchFailed(errorMsg: "Timeout please try again"));
      } on SocketException catch (e) {
        debugPrint("SocketException: $e");
        emit(const FailedFetchFailed(
            errorMsg: "Please check your internet connection"));
      } catch (e) {
        emit(const FailedFetchFailed(errorMsg: "Something went wrong"));
      }
    });
  }
}
