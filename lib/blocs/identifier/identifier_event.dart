part of 'identifier_bloc.dart';

sealed class IdentifierEvent extends Equatable {
  const IdentifierEvent();

  @override
  List<Object> get props => [];
}

class FetchIdentifierEvent extends IdentifierEvent {
  
}