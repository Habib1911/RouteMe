import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile/constants/end_points.dart';
import 'package:mobile/data/local/cache_helper.dart';
import 'package:mobile/data/network/responses/successful_response.dart';
import 'package:mobile/data/remote/dio_helper.dart';
import 'package:mobile/presentation/widgets/toast.dart';

part 'add_branch_state.dart';

class AddBranchCubit extends Cubit<AddBranchState> {
  AddBranchCubit() : super(AddBranchInitial());

  static AddBranchCubit get(context) => BlocProvider.of(context);

  SuccessfulResponse? successfulResponse;

  Future addNewBranch({
    required String name,
    required String phone,
    required double lon,
    required double lat,
    required String address,
  }) async {
    await DioHelper.postData(
      url: addBranch,
      body: {
        'vendorId': CacheHelper.getDataFromSharedPreference(key: "userId"),
        'branchName': name,
        'phone': phone,
        'lon': lon,
        'lat': lat,
        'address': address,
      },
    ).then((value) {
      final myData = Map<String, dynamic>.from(value.data);
      successfulResponse = SuccessfulResponse.fromJson(myData);
      showToast(successfulResponse!.message);
    }).catchError((error) {
      //showToast(error.toString());
    });
    return successfulResponse!.message;
  }
}
