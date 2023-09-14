part of 'identifier_bloc.dart';

sealed class IdentifierState extends Equatable {
  const IdentifierState();
  
  @override
  List<Object> get props => [];
}

final class IdentifierInitial extends IdentifierState {}
