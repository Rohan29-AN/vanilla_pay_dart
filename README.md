# Vanilla Pay International Dart Package

With this module, developers can effortlessly integrate Vanilla Pay International's payment service into their cross-platform Flutter applications.

## Introduction

The Vanilla Pay International Dart package provides a convenient way to integrate Vanilla Pay International services into your Flutter applications (Android & iOs). It allows you to generate tokens, initialize payments, check transaction statuses, and validate data authenticity with ease.

## Installation

To use this package, add `vanilla_pay_international` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  vanilla_pay_international: ^1.0.0
```

Then, run `flutter pub get` to install the package.

## Usage

### Initialize Payment Manager

To use the Vanilla Pay International services, you need to initialize a `PaymentManager` instance:

```dart
import 'package:vanilla_pay_international/vanilla_pay_international.dart';

void main() {
  PaymentManager paymentManager = PaymentManager(
    env: 'PROD',
    vpiVersion: '1.0.0',
    clientId: 'your_client_id',
    clientSecret: 'your_client_secret',
    keySecret: 'your_key_secret',
  );
}
```

### Generate Token
Use the `generateToken()` method to generate a token, which remains valid for 20 minutes:
```dart
TokenResponse? tokenResponse = await paymentManager.generateToken();
```

Response (tokenResponse):
```json
{
    "CodeRetour": 200,
    "DescRetour": "Génération TOKEN.",
    "DetailRetour": "",
    "Data": {
    	"Token": "Bearer <token>"
 	}
}
```
### Initialize Payment

Initiate a payment process using the `initializePayment()` method:

- `token`: The generated token.
- `montant`: The amount of the transaction.
- `devise`: The currency of the transaction (e.g EUR).
- `reference`: The pro external reference.
- `panier`: The identifier for the transaction.
- `notifUrl`: URL called when the payment is finished.
- `redirectUrl`: URL to redirect the customer after completing the payment.



```dart
InitPaymentResponse? initPaymentResponse = await paymentManager.initializePayment(
  token,
  montant,
  devise,
  reference,
  panier,
  notifUrl,
  redirectUrl,
);
```

Response (initPaymentResponse):
```json
{
    "CodeRetour": 200,
    "DescRetour": "Génération lien de paiement.",
    "DetailRetour": "",
    "Data": {
        "url": "https://link.com"
    }
}
```

### Check Transaction Status

Retrieve the status of a transaction using the `getTransactionsStatus()` method:

- `token`: The generated token.
- `paymentLink`: The payment link.


```dart
TransactionStatusResponse? transactionStatusResponse = await paymentManager.checkTransactionStatus(
  token,
  paymentLink,
);
```

Response (status):
```json
{
    "CodeRetour": 200,
    "DescRetour": "Transaction status.",
    "DetailRetour": "",
    "Data": {
        "reference_VPI": "VPI23011201010101",
	    "panier" : "panier123",
        "reference": "ABC-1234",
        "montant": 58.5,
        "etat": "SUCCESS"
    }
}
```

### Validate Data Authenticity

Validate the authenticity of provided data using the `validateDataAuthenticity()` method:

- `vpiSignature`: The signature extracted from the headers.
- `body`: The data to be hashed and compared against the signature.


```dart
bool isAuthentic = paymentManager.validateDataAuthenticity(vpiSignature, body);
```

## Contributions and Issues

Contributions and bug reports are welcome! Please feel free to submit a pull request or open an issue on the GitHub repository: [Here](https://github.com/Rohan29-AN/vanilla_pay_dart.git).

---
**Copyright**   © 2024  Vanilla Pay. All rights reserved.  