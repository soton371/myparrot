import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myparrot/configs/my_urls.dart';
import 'package:myparrot/models/pending_msg_mod.dart';
import 'package:http/http.dart' as http;
part 'delivery_event.dart';
part 'delivery_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  DeliveryBloc() : super(DeliveryInitial()) {
    on<FetchDeliveryMsg>((event, emit) async{
      debugPrint("call FetchDeliveryMsg");
      emit(DeliveryFetchLoading());
      try {
        Uri url = Uri.parse("${MyUrls.delivery}/${event.deviceId}");
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final pendingMsgModel = pendingMsgModelFromJson(response.body);
          final data = pendingMsgModel.data;
          if (data != null && data.isNotEmpty) {
            List<Datum> deliveryMsgs = data;
            emit(DeliveryFetched(deliveryMsgList: deliveryMsgs));
          } else {
            emit(
                const DeliveryFetchFailed(errorMsg: "No Communication History"));
          }
        } else {
          emit(const DeliveryFetchFailed(errorMsg: "Internal server error"));
        }
      } on TimeoutException catch (e) {
        debugPrint("TimeoutException: $e");
        emit(const DeliveryFetchFailed(errorMsg: "Timeout please try again"));
      } on SocketException catch (e) {
        debugPrint("SocketException: $e");
        emit(const DeliveryFetchFailed(
            errorMsg: "Please check your internet connection"));
      } catch (e) {
        emit(const DeliveryFetchFailed(errorMsg: "Something went wrong"));
      }
    });
  }
}
