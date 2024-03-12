import 'dart:convert';

import 'package:vanilla_pay_international/src/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:vanilla_pay_international/src/models/init_payment_body.dart';
import 'package:vanilla_pay_international/src/models/init_payment_response.dart';
import 'package:vanilla_pay_international/src/models/token_response.dart';
import 'package:vanilla_pay_international/src/models/transaction_status_response.dart';
import 'package:vanilla_pay_international/src/utils/utils.dart';

class VanillaPayService {
  final String env;
  final String vpiVersion;
  final String clientId;
  final String clientSecret;

  VanillaPayService(
      {required this.env,
      required this.vpiVersion,
      required this.clientId,
      required this.clientSecret});

  Future<TokenResponse?> generateToken() async {
    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Client-Id': clientId,
        'Client-Secret': clientSecret,
        'VPI-Version': vpiVersion
      };

      final response = await http.get(
          Uri.parse('${getBaseUrl(env)}$getTokenEndPoint'),
          headers: headers);

      if (response.statusCode == 200) {
        return TokenResponse.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to get token: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching token: $e');
      throw Exception('Error fetching token: $e');
    }
  }

  Future<InitPaymentResponse?> initializePayment(
      String token, InitPaymentBody body) async {
    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Client-Id': clientId,
        'Client-Secret': clientSecret,
        'VPI-Version': vpiVersion,
        'Authorization': token
      };

      final response = await http.post(
        Uri.parse('${getBaseUrl(env)}$initPayementEndPoint'),
        headers: headers,
        body: jsonEncode(body.toJson()),
      );
      if (response.statusCode == 200) {
        return InitPaymentResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      } else {
        print('Failed to initialize payment: ${response.statusCode}');
        throw Exception('Failed to initialize payment: ${response.statusCode}');
      }
    } catch (e) {
      print('Error initializing payment: $e');
      throw Exception('Error initializing payment: $e');
    }
  }

  Future<TransactionStatusResponse?> checkTransactionStatus(
      String token, String paymentLink) async {
    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'VPI-Version': vpiVersion,
        'Authorization': token
      };

      String? id = getIdFromLink(paymentLink);

      final response = await http.get(
          Uri.parse('${getBaseUrl(env)}$transactionStatusEndPoint/$id'),
          headers: headers);
      if (response.statusCode == 200) {
        return TransactionStatusResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      } else {
        throw Exception(
            'Failed to check transaction status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error checking transaction status: $e');
    }
  }
}
