abstract class ApiService {
  Future get(String endpoint, {Map<String, dynamic>? params});
}
