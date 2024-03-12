class InitPaymentBody {
  double? montant;
  String? devise;
  String? reference;
  String? panier;
  String? notifUrl;
  String? redirectUrl;

  InitPaymentBody({
    this.montant,
    this.devise,
    this.reference,
    this.panier,
    this.notifUrl,
    this.redirectUrl,
  });
}
