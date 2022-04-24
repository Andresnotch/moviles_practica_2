part of 'listen_bloc.dart';

abstract class ListenState extends Equatable {
  const ListenState();

  @override
  List<Object> get props => [];
}

class ListenInitial extends ListenState {}

class ListeningState extends ListenState {}

class FailedListeningState extends ListenState {}
