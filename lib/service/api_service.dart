import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_shot/models/failure.dart';
import 'package:news_shot/models/news_model.dart';
import 'package:news_shot/models/source_model.dart';

const kAppToken = '51257deb5221498a92339fe411cbade4';
const kBaseURL = 'https://newsapi.org/v2/';
const kTopHeadlinesEndPoint = 'top-headlines';
const kSourceEndPoint = 'sources';
const kCountry = 'in';
const kPageSize = 100;

const kParamCountry = 'country';
const kParamApiKey = 'apiKey';
const kParamCategory = 'category';
const kParamSources = 'sources';
const kParamPageSize = 'pageSize';

@injectable
class ApiService {
  final _dio = Dio();

  Future<NewsModel> fetchNews({String source, String category}) async {
    final params = <String, dynamic>{};
    params[kParamApiKey] = kAppToken;
    params[kParamPageSize] = kPageSize;

    if (source == null) {
      params[kParamCountry] = kCountry;
      params[kParamCategory] = category;
    } else {
      params[kParamSources] = source;
    }

    final response = await _dio
        .get(
          '$kBaseURL/$kTopHeadlinesEndPoint',
          queryParameters: params,
        )
        .catchError(
          (e) => throw getFailure(e),
        );

    final model = NewsModel.fromJson(response.data as Map<String, dynamic>);
    return model;
  }

  Future<SourceModel> fetchSources() async {
    final params = <String, dynamic>{};
    params[kParamApiKey] = kAppToken;
    params[kParamCountry] = kCountry;

    final response = await _dio
        .get(
          '$kBaseURL/$kSourceEndPoint',
          queryParameters: params,
        )
        .catchError(
          (e) => throw getFailure(e),
        );

    final model = SourceModel.fromJson(response.data as Map<String, dynamic>);
    return model;
  }

  Failure getFailure(dynamic error) {
    if (error is DioError) {
      final dioError = error;
      return Failure(
        404,
        dioError.response.data['Error'].toString(),
      );
    } else {
      return Failure(
        404,
        'Something went wrong!',
      );
    }
  }
}
