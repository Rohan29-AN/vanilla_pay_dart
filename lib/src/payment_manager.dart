import 'package:vanilla_pay_international/src/models/init_payment_body.dart';
import 'package:vanilla_pay_international/src/models/init_payment_response.dart';
import 'package:vanilla_pay_international/src/models/token_response.dart';
import 'package:vanilla_pay_international/src/models/transaction_status_response.dart';
import 'package:vanilla_pay_international/src/service/vpi_service.dart';
import 'package:vanilla_pay_international/src/utils/utils.dart';

class PaymentManager {
  final VanillaPayService vanillaService;
  final String keySecret;

  PaymentManager(
      {required String env,
      required String vpiVersion,
      required String clientId,
      required String clientSecret,
      required this.keySecret})
      : vanillaService = VanillaPayService(
            env: env,
            vpiVersion: vpiVersion,
            clientId: clientId,
            clientSecret: clientSecret);

  /// This function is used to generate the token used during transactions, which remains valid for 20 minutes.
  /// It returns a [Future<TokenResponse>] that will be completed with the generated token or an exception if token generation fails.
  Future<TokenResponse?> generateToken() async {
    try {
      return await vanillaService.generateToken();
    } catch (e) {
      rethrow;
    }
  }

  /// Initiates a payment process by generating a payment link for the customer to access and complete the payment.
  ///
  /// - [token]: The generated token used for authentication and authorization
  /// - [montant]: The amount of the transaction
  /// - [devise]: The currency of the transaction
  /// - [reference]: The external reference associated with the transaction
  /// - [panier]: The identifier for the transaction
  /// - [notifUrl]: The URL to be called when the payment is finished
  /// - [redirectUrl]: The URL to redirect the customer after completing the payment
  ///
  /// Returns a [Future<InitPaymentResponse>] that will be completed with the response of the payment initialization or an exception if initialization fails.
  Future<InitPaymentResponse?> initializePayment(
      String token,
      double montant,
      String devise,
      String reference,
      String panier,
      String notifUrl,
      String redirectUrl) async {
    try {
      InitPaymentBody body = InitPaymentBody(
        montant: montant,
        devise: devise,
        reference: reference,
        panier: panier,
        notifUrl: notifUrl,
        redirectUrl: redirectUrl,
      );

      return await vanillaService.initializePayment(token, body);
    } catch (e) {
      rethrow;
    }
  }

  /// Retrieves the status of a transaction using the provided payment link.
  ///
  /// - [token]: The generated token used for authentication and authorization.
  /// - [paymentLink]: The payment link associated with the transaction.
  ///
  /// Returns a [Future<TransactionStatusResponse>] that will be completed with the status of the transaction or an exception if retrieval fails.
  Future<TransactionStatusResponse?> checkTransactionStatus(
      String token, String paymentLink) async {
    try {
      return await vanillaService.checkTransactionStatus(token, paymentLink);
    } catch (e) {
      rethrow;
    }
  }

  /// Validates the authenticity of the provided data by verifying the signature against the hashed body using the ClientSECRET.
  ///
  /// - [vpiSignature]: The signature extracted from the headers.
  /// - [body]: The data to be hashed and compared against the signature.
  ///
  /// Returns `true` if the data is authentic, otherwise returns `false`.
  bool validateDataAuthenticity(String vpiSignature, String body) {
    // Hash the provided body using the KeySecret
    String hashedData = hashData(keySecret, body);
    // compare the hashed body with the provided signature
    return hashedData == vpiSignature;
  }
}
