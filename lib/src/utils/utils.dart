import 'dart:convert';
import 'package:crypto/crypto.dart';


/// Hashes the [payload] using the SHA256 algorithm and a secret key.
///
/// [secret]: The secret key used for hashing.
/// 
/// [payload]: The value to be hashed.
/// 
/// Returns the hashed value.
String hashData(String secret, String payload) {
  var bytes = utf8.encode(payload);
  var hmacSha256 = Hmac(sha256, utf8.encode(secret)); 
  var digest = hmacSha256.convert(bytes);
  return digest.toString().toUpperCase();
}


String? getIdFromLink(String url) {
  try {
    final uri = Uri.parse(url);
    final queryParams = uri.queryParameters;
    
    if (queryParams.containsKey('id')) {
      return queryParams['id'];
    } else {
      return '';
    }
  } catch (e) {
    print('Error parsing URL: $e');
    return null;
  }
}

