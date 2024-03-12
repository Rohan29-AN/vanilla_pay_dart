class ApiError {
  int? status;
  String? message;

  ApiError({this.status, this.message});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      status: json['status'] as int,
      message: json['message'] as String,
    );
  }
}
