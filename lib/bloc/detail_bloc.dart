import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/user_repo.dart';
import '../model/user_model.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc({required this.repo}) : super(DetailInitialState()) {
    on<GetDetailEvent>((event, emit) async {
      emit(DetailLoadingState());
      try {
        final results = await repo.getUser(id: event.id);
        emit(DetailSuccessState(model: results));
      } catch (e) {
        emit(DetailErrorState());
      }
    });
  }

  final UserRepo repo;
}

abstract class DetailEvent {}

class GetDetailEvent extends DetailEvent {
  GetDetailEvent({required this.id});
  final String id;
}

abstract class DetailState {}

class DetailInitialState extends DetailState {}

class DetailLoadingState extends DetailState {}

class DetailSuccessState extends DetailState {
  DetailSuccessState({required this.model});
  final UserModel model;
}

class DetailErrorState extends DetailState {}
