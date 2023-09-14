import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'send_msg_event.dart';
part 'send_msg_state.dart';

class SendMsgBloc extends Bloc<SendMsgEvent, SendMsgState> {
  SendMsgBloc() : super(SendMsgInitial()) {
    on<SendMsgEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
