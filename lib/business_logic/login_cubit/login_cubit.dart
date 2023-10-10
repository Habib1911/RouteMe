import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile/data/local/cache_helper.dart';
import 'package:mobile/data/network/responses/login_response.dart';
import 'package:mobile/data/remote/dio_helper.dart';
import 'package:mobile/presentation/widgets/toast.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginResponse? loginResponse;

  Future userLogin({
    required String? server,
    required String? email,
    required String? password,
    required String endPoint,
    required VoidCallback afterSuccess,
    required VoidCallback afterFail,
  }) async {
    emit(LoginLoadingState());
    await DioHelper.postData(url: endPoint, body: {
      'server': server,
      'email': email,
      'password': password,
    }).then((value) {
      final myData = Map<String, dynamic>.from(value.data);
      loginResponse = LoginResponse.fromJson(myData);
      if (loginResponse!.status == 200) {
        emit(LoginSuccessState(loginResponse!));
        CacheHelper.saveDataSharedPreference(
            key: 'userId', value: loginResponse!.user![0].id);
        CacheHelper.saveDataSharedPreference(
            key: 'vendor', value: loginResponse!.user![0].name);
        CacheHelper.saveDataSharedPreference(
            key: 'type', value: loginResponse!.user![0].type);
        CacheHelper.saveDataSharedPreference(
            key: 'server', value: loginResponse!.user![0].server);
        CacheHelper.saveDataSharedPreference(
            key: 'email', value: loginResponse!.user![0].email);
        CacheHelper.saveDataSharedPreference(
            key: 'password', value: loginResponse!.user![0].password);
        CacheHelper.saveDataSharedPreference(
            key: 'isLogin', value: true);
        afterSuccess();
        showToast(translate('loginSuccessful'));
      } else {
        afterFail();
        showToast(loginResponse!.message);
      }
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      //showToast(error.toString());
    });
  }
}
