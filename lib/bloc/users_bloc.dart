import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/user_repo.dart';
import '../model/user_model.dart';
import '../model/users_model.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc({required this.repo}) : super(UserInitialState()) {
    on<GetUsersEvent>((event, emit) async {
      if (character.isNotEmpty) {
        emit(UsersSuccessState(model: character));
      } else {
        emit(UserLoadingState());
      }
      try {
        final results = await repo.getUsers(
          name: event.name,
          page: event.page,
          status: event.status,
          gender: event.gender,
        );
        if (event.isSearch) {
          character = [];
          character.addAll(results.results ?? []);
        }
        if (!event.isSearch) {
          character.addAll(results.results ?? []);
          emit(
            UsersSuccessState(
                model: character,
                pageLength: results.info!.pages!,
                userCount: results.info!.count!,
                isLoading: false),
          );
        } else {
          emit(
            UsersSuccessState(
                model: results.results ?? [],
                pageLength: results.info!.pages!,
                userCount: results.info!.count!,
                isLoading: false),
          );
        }
      } catch (e) {
        emit(
          UserErrorState(
            searchType: event.gender != ''
                ? true
                : event.status != ''
                    ? true
                    : false,
          ),
        );
      }
    });
  }

  final UserRepo repo;
  List<Results> character = [];
}

abstract class UsersEvent {}

class GetUsersEvent extends UsersEvent {
  GetUsersEvent({
    required this.name,
    required this.page,
    this.isSearch = false,
    this.status = '',
    this.gender = '',
  });
  final String name;
  final int page;
  String status;
  String gender;
  bool isSearch;
}

abstract class UsersState {}

class UserInitialState extends UsersState {}

class UserLoadingState extends UsersState {}

class UsersSuccessState extends UsersState {
  UsersSuccessState({
    required this.model,
    this.isLoading = true,
    this.pageLength = 1,
    this.userCount = 0,
  });
  final List<Results> model;
  bool isLoading;
  int pageLength;
  int userCount;
}

class UserSuccessState extends UsersState {
  UserSuccessState({required this.model});
  final UserModel model;
}

class UserErrorState extends UsersState {
  final bool searchType;

  UserErrorState({this.searchType = false});
}
