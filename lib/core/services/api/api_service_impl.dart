import 'package:d_rank/core/services/api/api_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ApiService)
class ApiServiceImpl implements ApiService {
  final Dio _dio = Dio(
    BaseOptions(),
  );

  @override
  Future get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      final request = await _dio.get(
        endpoint,
        queryParameters: params ?? {},
      );
      if (request.statusCode! >= 200 && request.statusCode! < 300) {
        return request.data;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        return e.response;
      }
      return e.response!.statusCode;
    }
  }
}
