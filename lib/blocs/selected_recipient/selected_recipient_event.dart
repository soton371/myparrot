part of 'selected_recipient_bloc.dart';

sealed class SelectedRecipientEvent extends Equatable {
  const SelectedRecipientEvent();

  @override
  List<Object> get props => [];
}


class CallSelectRecipient extends SelectedRecipientEvent {
  const CallSelectRecipient({required this.selectedRecipient});
  final RecipientModel selectedRecipient;
  @override
  List<Object> get props => [selectedRecipient];
}

class CallUnselectRecipient extends SelectedRecipientEvent {
}

class CallUnselectRecipientItem extends SelectedRecipientEvent {
  const CallUnselectRecipientItem({required this.selectedRecipient});
  final RecipientModel selectedRecipient;
  @override
  List<Object> get props => [selectedRecipient];
}
