import 'package:dartz/dartz.dart';
import 'package:wikipidia/src/core/services/api_service.dart';
import 'package:wikipidia/src/infrastructure/models/api_error.dart';
import 'package:wikipidia/src/infrastructure/models/apiresult.dart';
import 'package:wikipidia/src/infrastructure/models/suggestion.dart';
import 'package:wikipidia/src/injection.dart';

abstract class ResultRepository {
  Future<Either<ApiError, PageResult>> getResult({String titel});
}

class ResultImplementation implements ResultRepository {
  final ApiService _apiService = getIt<ApiService>();

  @override
  Future<Either<ApiError, PageResult>> getResult({String titel}) async {
    try {
      var responce = await (await _apiService.getDioClient())
          .get(ApiService.RESULt + titel);
      if (responce.statusCode == 200) {
        Iterable it = responce.data["query"]["pages"];
        PageResult result = it.map((e) => PageResult.fromJson(e)).first;
        return Right(result);
      } else {
        return Left(ApiError(error: "${responce.statusMessage}"));
      }
    } catch (e) {
      print(e);
      return Left(ApiError(error: e.toString()));
    }
  }
}
