import 'package:dartz/dartz.dart';
import 'package:wikipidia/src/core/services/api_service.dart';
import 'package:wikipidia/src/infrastructure/models/api_error.dart';
import 'package:wikipidia/src/infrastructure/models/suggestion.dart';
import 'package:wikipidia/src/injection.dart';

abstract class SuggestionRepository {
  Future<Either<ApiError, List<Suggestion>>> getSuggestions({String text});
}

class SuggestionImplementation implements SuggestionRepository {
  final ApiService _apiService = getIt<ApiService>();
  @override
  Future<Either<ApiError, List<Suggestion>>> getSuggestions(
      {String text}) async {
    List<Suggestion> _suggestionList = [];
    try {
      var responce =
          await (await _apiService.getDioClient()).get(ApiService.QUERY + text);
      if (responce.statusCode == 200) {
        Iterable it = responce.data["query"]["pages"];
        _suggestionList = it.map((e) => Suggestion.fromJson(e)).toList();
        return Right(_suggestionList);
      } else {
        return Left(ApiError(error: "${responce.statusMessage}"));
      }
    } catch (e) {
      print(e);
      return Left(ApiError(error: e.toString()));
    }
  }
}
