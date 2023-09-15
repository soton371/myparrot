import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myparrot/configs/my_urls.dart';
import 'package:myparrot/models/pending_msg_mod.dart';

part 'pending_event.dart';
part 'pending_state.dart';

class PendingBloc extends Bloc<PendingEvent, PendingState> {
  List<Datum> pendingMsgList = []; //for calendar query list view
  PendingBloc() : super(PendingInitial()) {
    on<FetchPendingMsg>((event, emit) async {
      debugPrint("call FetchPendingMsg");
      emit(PendingFetchLoading());
      try {
        Uri url = Uri.parse("${MyUrls.pending}/${event.deviceId}");
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final pendingMsgModel = pendingMsgModelFromJson(response.body);
          final data = pendingMsgModel.data;
          if (data != null && data.isNotEmpty) {
            pendingMsgList = data;  //for calendar query list view
            List<Datum> pendingMsgs = data;
            pendingMsgs.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
            emit(PendingFetched(pendingMsgList: pendingMsgs));
          } else {
            emit(
                const PendingFetchFailed(errorMsg: "No Communication History"));
          }
        } else {
          emit(const PendingFetchFailed(errorMsg: "Internal server error"));
        }
      } on TimeoutException catch (e) {
        debugPrint("TimeoutException: $e");
        emit(const PendingFetchFailed(errorMsg: "Timeout please try again"));
      } on SocketException catch (e) {
        debugPrint("SocketException: $e");
        emit(const PendingFetchFailed(
            errorMsg: "Please check your internet connection"));
      } catch (e) {
        emit(const PendingFetchFailed(errorMsg: "Something went wrong"));
      }
    });
  }
}
