class TransactionStatusResponse {
  int? codeRetour;
  String? descRetour;
  String? detailRetour;
  Data? data;

  TransactionStatusResponse(
      {required this.codeRetour,
      required this.descRetour,
      required this.detailRetour,
      required this.data});

  factory TransactionStatusResponse.fromJson(Map<String, dynamic> json) {
    return TransactionStatusResponse(
        codeRetour: json['CodeRetour'] as int,
        descRetour: json['DescRetour'] as String,
        detailRetour: json['DetailRetour'] as String,
        data: json['Data'] != null ? Data.fromJson(json['Data']) : null);
  }
}

class Data {
  String? referenceVPI;
  String? panier;
  String? reference;
  String? remarque;
  String? etat;

  Data(
      {required this.referenceVPI,
      required this.panier,
      required this.reference,
      required this.remarque,
      required this.etat});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        referenceVPI: json['reference_VPI'] as String,
        panier: json['panier'] as String,
        reference: json['reference'] as String,
        remarque: json['remarque'] as String,
        etat: json['etat'] as String);
  }
}
