import 'dart:async';
import 'dart:math';

class Api {
  Future<String> sendReport(Map<String, dynamic> requestData) {
    final completer = Completer<String>();

    // Simulate an API request delay of 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      // Generate a random number to determine success or failure
      final random = Random();
      if (random.nextBool()) {
        // Successful response
        String response = 'Fake API response for ${requestData.toString()}';
        completer.complete(response);
      } else {
        // Failure response
        completer.completeError('API request failed');
      }
    });

    return completer.future;
  }
}
