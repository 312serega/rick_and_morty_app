import 'package:dio/dio.dart';

import '../model/user_model.dart';
import '../model/users_model.dart';

class UserRepo {
  UserRepo({required this.dio});
  final Dio dio;

  Future<UsersResponseModel> getUsers({
    required String name,
    required int page,
    String? status,
    String? gender,
  }) async {
    final results = await dio.get(
      'character',
      queryParameters: {
        if (name != '') 'name': name,
        'page': page,
        if (status != '') 'status': status,
        if (gender != '') 'gender': gender
      },
    );
    return UsersResponseModel.fromJson(results.data);
  }

  Future<UserModel> getUser({required String id}) async {
    final results = await dio.get(
      'character/$id',
    );
    return UserModel.fromJson(results.data);
  }
}
