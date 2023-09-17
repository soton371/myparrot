part of 'selected_recipient_bloc.dart';

sealed class SelectedRecipientState extends Equatable {
  const SelectedRecipientState();
  
  @override
  List<Object> get props => [];
}

final class SelectedRecipientInitial extends SelectedRecipientState {}


class SelectRecipientValue extends SelectedRecipientState {
  const SelectRecipientValue({required this.selectRecipientList, required this.selectedCount});
  final List<RecipientModel> selectRecipientList;
  final int selectedCount;
  @override
  List<Object> get props => [selectRecipientList, selectedCount];
}

class UnselectRecipientState extends SelectedRecipientState {
}

class UnselectRecipientItemState extends SelectedRecipientState {
  const UnselectRecipientItemState({required this.selectRecipientList, required this.selectedCount});
  final List<RecipientModel> selectRecipientList;
  final int selectedCount;
  @override
  List<Object> get props => [selectRecipientList, selectedCount];
}
