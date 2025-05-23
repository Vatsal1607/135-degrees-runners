class GetUserDetailsModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  GetUserDetailsModel({this.success, this.statusCode, this.message, this.data});

  GetUserDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? username;
  String? email;
  String? address;
  int? contact;
  String? role;
  String? profileImage; // <-- added field
  bool? isActive;
  bool? isDelete;
  String? createdAt;
  String? updatedAt;
  int? iV;
  Null? otp;

  Data(
      {this.sId,
      this.username,
      this.email,
      this.address,
      this.contact,
      this.role,
      this.profileImage,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.otp});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    address = json['address'];
    contact = json['contact'];
    role = json['role'];
    profileImage = json['profileImage'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    data['email'] = email;
    data['address'] = address;
    data['contact'] = contact;
    data['role'] = role;
    data['profileImage'] = profileImage;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['otp'] = otp;
    return data;
  }
}
