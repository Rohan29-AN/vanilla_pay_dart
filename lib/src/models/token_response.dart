class TokenResponse {
  int? codeRetour;
  String? descRetour;
  String? detailRetour;
  Data? data;

  TokenResponse(
      {required this.codeRetour,
      required this.descRetour,
      required this.detailRetour,
      required this.data});

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
        codeRetour: json['CodeRetour'] as int,
        descRetour: json['DescRetour'] as String,
        detailRetour: json['DetailRetour'] as String,
        data: json['Data'] as Data);
  }
}

class Data {
  String? token;

  Data({required this.token});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['Token'] as String,
    );
  }
}
