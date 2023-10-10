import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/end_points.dart';
import 'package:mobile/data/local/cache_helper.dart';
import 'package:mobile/data/models/branch_model.dart';
import 'package:mobile/data/network/responses/getBranches_response.dart';
import 'package:mobile/data/remote/dio_helper.dart';
import 'package:mobile/presentation/widgets/toast.dart';

part 'branches_state.dart';

class BranchesCubit extends Cubit<List<BranchModel>> {
  BranchesCubit() : super([]);

  static BranchesCubit get(context) => BlocProvider.of(context);

  GetBranchesResponse? getBranchesResponse;

  Future getBranches() async {
    await DioHelper.postData(
      url: branches,
      body: {
        'vendorId': CacheHelper.getDataFromSharedPreference(key: "userId"),
      },
    ).then((value) {
      final myData = Map<String, dynamic>.from(value.data);
      getBranchesResponse = GetBranchesResponse.fromJson(myData);
      if (getBranchesResponse!.status == 200) {
        return getBranchesResponse!.branches;
      } else {
        showToast(getBranchesResponse!.message);
        return getBranchesResponse!.message;
      }
    }).catchError((error) {
      //showToast(error.toString());
    });
    return getBranchesResponse!.branches;
  }

  void get myBranches async => emit(await getBranches());
}
