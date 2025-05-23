import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/api_global_model.dart';
import '../../models/get_user_details_model.dart';
import '../../models/order_history_model.dart';
import '../../models/user_login_model.dart';
import 'api/api_constants.dart';
import 'api/api_endpoints.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: BaseUrl.apiBaseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(ApiEndpoints.userLogin)
  Future<LoginModel> userLogin(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiEndpoints.sendOtp)
  Future<ApiGlobalModel> sendOtp(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiEndpoints.verifyOtp)
  Future<ApiGlobalModel> verifyOtp(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiEndpoints.logout)
  Future<ApiGlobalModel> logout(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiEndpoints.pickupTime)
  Future<ApiGlobalModel> pickupTime(
    @Body() Map<String, dynamic> body,
  );

  // Toggle Active status
  @POST(ApiEndpoints.deliveryStatus)
  Future<ApiGlobalModel> deliveryStatus(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiEndpoints.deliveryTime)
  Future<ApiGlobalModel> deliveryTime(
    @Body() Map<String, dynamic> body,
  );

  @GET('${ApiEndpoints.orderHistory}/{userId}')
  Future<OrderHistoryModel> orderHistory(
    @Path('userId') String userId,
  );

  //* Invoice main generate
  @POST(ApiEndpoints.orderInvoiceGenerate)
  Future<ApiGlobalModel> orderInvoiceGenerate(
    @Field("orderId") String orderId,
  );

  @GET('${ApiEndpoints.getUserDetails}/{userId}')
  Future<GetUserDetailsModel> getUserDetails(
    @Path('userId') String userId,
  );

  //* Edit profile
  @PUT('${ApiEndpoints.updateUserDetails}/{userId}')
  @MultiPart()
  Future<ApiGlobalModel> editProfile(
    @Path('userId') String userId,
    @Part(name: 'username') String username,
    @Part(name: 'email') String email,
    @Part(name: 'address') String address,
    @Part(name: 'contact') String contact,
    @Part(name: "profileImage") File? profileImage,
  );
}
