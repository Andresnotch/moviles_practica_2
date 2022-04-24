import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'listen_event.dart';
part 'listen_state.dart';

class ListenBloc extends Bloc<ListenEvent, ListenState> {
  ListenBloc() : super(ListenInitial()) {
    on<ListenNowEvent>(listenNow);
  }

  FutureOr<void> listenNow(event, emit) async {
    emit(ListeningState());
    await Future.delayed(Duration(seconds: 5), () {});

    emit(ListenInitial());
  }
}
