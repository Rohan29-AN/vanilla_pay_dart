class InitPaymentBody{
   int? codeRetour;
   String? descRetour;
   String? detailRetour;
    Data? data;
  
  InitPaymentBody({
    this.codeRetour,
    this.descRetour,
    this.detailRetour,
    this.data,
  });
}

class Data{
  String? url;

  Data({this.url})

}