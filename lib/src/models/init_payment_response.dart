class InitPaymentResponse {
  final int codeRetour;
  final String descRetour;
  final String detailRetour;
  final Data data;

  InitPaymentResponse({
    required this.codeRetour,
    required this.descRetour,
    required this.detailRetour,
    required this.data,
  });

  factory InitPaymentResponse.fromJson(Map<String, dynamic> json) {
    return InitPaymentResponse(
      codeRetour: json['CodeRetour'],
      descRetour: json['DescRetour'],
      detailRetour: json['DetailRetour'],
      data: Data.fromJson(json['Data'] ?? {}),
    );
  }
}

class Data {
  String url;

  Data({required this.url});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      url: json['url'] as String,
    );
  }

  @override
  String toString() {
    return 'Data{url: $url}';
  }
}
