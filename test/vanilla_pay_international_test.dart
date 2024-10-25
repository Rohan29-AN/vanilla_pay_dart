import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vanilla_pay_international/src/models/init_payment_response.dart'
    as init_payment_response;
import 'package:vanilla_pay_international/src/models/token_response.dart'
    as token_response;
import 'package:vanilla_pay_international/src/models/transaction_status_response.dart'
    as transaction_status_response;
import 'package:vanilla_pay_international/src/utils/utils.dart';
import 'package:vanilla_pay_international/vanilla_pay_international.dart';

import 'vanilla_pay_international_test.mocks.dart';

@GenerateMocks([VanillaPay])
void main() {
  late MockVanillaPay mockVanillaPay;

  setUp(() {
    mockVanillaPay = MockVanillaPay();
  });

  group('VanillaPay', () {
    test(
        'should return a valid token response when token generation is successful',
        () async {
      final tokenResponse = token_response.TokenResponse(
          codeRetour: 200,
          descRetour: 'Génération TOKEN.',
          detailRetour: "",
          data: token_response.Data(token: 'sample_token'));

      when(mockVanillaPay.generateToken())
          .thenAnswer((_) async => tokenResponse);

      //act
      final result = await mockVanillaPay.generateToken();

      //assert
      expect(result, isNotNull);
      expect(result?.codeRetour, 200);
      expect(result?.data?.token, 'sample_token');
    });

    test('should throw an exception when token generation fails', () async {
      when(mockVanillaPay.generateToken())
          .thenThrow(Exception('Failed to get token:'));
      expect(() async => await mockVanillaPay.generateToken(), throwsException);
    });

    test('should initialize payment successfully', () async {
      final response = init_payment_response.InitPaymentResponse(
          codeRetour: 200,
          descRetour: "Génération lien de paiement.",
          detailRetour: "",
          data: init_payment_response.Data(url: 'https://link.com'));

      const token = 'sample_token';

      when(mockVanillaPay.initializePayment(
              token,
              10.00,
              'EUR',
              'REF-001',
              'Cart01',
              'https//lien_milay.com/notify',
              'https//lien_milay.com/redirect'))
          .thenAnswer((_) async => response);

      final result = await mockVanillaPay.initializePayment(
          token,
          10.00,
          'EUR',
          'REF-001',
          'Cart01',
          'https//lien_milay.com/notify',
          'https//lien_milay.com/redirect');

      expect(result, isNotNull);
      expect(result?.codeRetour, 200);
      expect(result?.data.url, 'https://link.com');
    });
    test('should throw an exception when initializing payment fails', () async {
      const token = 'sample_token';
      when(mockVanillaPay.initializePayment(
              token,
              10.00,
              'EUR',
              'REF-001',
              'Cart01',
              'https//lien_milay.com/notify',
              'https//lien_milay.com/redirect'))
          .thenThrow(Exception('Error initializing payment'));
      expect(
          () async => await mockVanillaPay.initializePayment(
              token,
              10.00,
              'EUR',
              'REF-001',
              'Cart01',
              'https//lien_milay.com/notify',
              'https//lien_milay.com/redirect'),
          throwsException);
    });

    test(
        'should retrieve transaction status successfully for a valid payment link',
        () async {
      const token = 'sample_token';
      final transactionStatusResponse =
          transaction_status_response.TransactionStatusResponse(
              codeRetour: 200,
              descRetour: "Transaction status.",
              detailRetour: "detailRetour",
              data: transaction_status_response.Data(
                  referenceVPI: "VPI23011201010101",
                  panier: "panier123",
                  reference: "ABC-1234",
                  remarque: '',
                  etat: "SUCCESS"));

      when(mockVanillaPay.checkTransactionStatus(token, 'https://link.com'))
          .thenAnswer((_) async => transactionStatusResponse);
      final response = await mockVanillaPay.checkTransactionStatus(
          token, 'https://link.com');

      expect(response, isNotNull);
      expect(response?.codeRetour, 200);
      expect(response?.data?.etat, 'SUCCESS');
    });

    test('should throw an exception when transaction status retrieval fails',
        () async {
      const token = 'sample_token';

      when(mockVanillaPay.checkTransactionStatus(token, 'https://link.com'))
          .thenThrow(Exception('Error checking transaction status:'));
      expect(
          () async => await mockVanillaPay.checkTransactionStatus(
              token, 'https://link.com'),
          throwsException);
    });

    test('should return correct HMAC sha256 hash', () {
      String secret = 'shutt';
      String payload = 'vanilla pay international';
      String expectedHash =
          '2069B313561E4FE5BE48C8413E1DE1F1F983FF16D6314A6BF178AE5497A0B782';
      //Act
      String result = hashData(secret, payload);
      // Assert
      expect(result, expectedHash);
    });

    test('should return id from valid URL', () {
      //Arrange
      String url =
          'https://preprod.vanilla-pay.net/webpayment?id=eyJhbGciOiJIUzI1NiJ9.VlBJMjQwMjE2MDg0NTAzMDc.MOkDDnEvH4qPRcg6CJovac836-XA5kPIeeSGJErQ9k8';
      //Act
      String? id = getIdFromLink(url);
      //Assert
      expect(id,
          'eyJhbGciOiJIUzI1NiJ9.VlBJMjQwMjE2MDg0NTAzMDc.MOkDDnEvH4qPRcg6CJovac836-XA5kPIeeSGJErQ9k8');
    });

    test('should return empty if id is not present in the url', () {
      //Arrange
      String url = 'https://preprod.vanilla-pay.net/webpayment';
      //Act
      String? id = getIdFromLink(url);
      //Assert
      expect(id, '');
    });
  });
}
