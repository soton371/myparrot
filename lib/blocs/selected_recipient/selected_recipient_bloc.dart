import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myparrot/models/recipient_mod.dart';

part 'selected_recipient_event.dart';
part 'selected_recipient_state.dart';

class SelectedRecipientBloc extends Bloc<SelectedRecipientEvent, SelectedRecipientState> {
  List<RecipientModel> selectedRecipientList = [];
  SelectedRecipientBloc() : super(SelectedRecipientInitial()) {
    on<CallSelectRecipient>((event, emit) {
      debugPrint("CallSelectRecipient");
      selectedRecipientList.add(event.selectedRecipient);
      emit(SelectRecipientValue(selectRecipientList: selectedRecipientList, selectedCount: selectedRecipientList.length));
    });
    //for unselect 
    on<CallUnselectRecipient>((event, emit) {
      debugPrint("CallUnselectRecipient");
      selectedRecipientList=[];
      emit(UnselectRecipientState());
    });
    //for unselect notification item
    on<CallUnselectRecipientItem>((event, emit) {
      debugPrint("CallUnselectRecipientItem");
      selectedRecipientList.remove(event.selectedRecipient);
      if (selectedRecipientList.isEmpty) {
        emit(UnselectRecipientState());
        return;
      }
      emit(UnselectRecipientItemState(selectRecipientList: selectedRecipientList, selectedCount: selectedRecipientList.length));
    });
  }
}
