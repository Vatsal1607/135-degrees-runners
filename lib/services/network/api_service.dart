import 'package:dio/dio.dart';
import '../../models/api_global_model.dart';
import '../../models/user_login_model.dart';
import 'api_client.dart';
import 'interceptor/dio_interceptor.dart';

class ApiService {
  late ApiClient apiClient;

  ApiService() {
    final dio = Dio();
    dio.interceptors.add(DioInterceptor());
    apiClient = ApiClient(dio);
  }

  Future<LoginModel> userLogin({
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.userLogin(
      body,
    );
  }

  Future<ApiGlobalModel> sendOtp({
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.sendOtp(body);
  }

  Future<ApiGlobalModel> verifyOtp({
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.verifyOtp(body);
  }

  Future<ApiGlobalModel> logout({
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.logout(body);
  }

  Future<ApiGlobalModel> pickupTime({
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.pickupTime(body);
  }

  Future<ApiGlobalModel> deliveryStatus({
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.deliveryStatus(body);
  }

  Future<ApiGlobalModel> deliveryTime({
    required Map<String, dynamic> body,
  }) async {
    return await apiClient.deliveryTime(body);
  }
}
