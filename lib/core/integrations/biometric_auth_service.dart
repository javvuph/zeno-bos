import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class BiometricAuthService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isBiometricAvailable() async {
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    return canAuthenticate;
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      debugPrint("Biometrics Retrieval Failed: $e");
      return <BiometricType>[];
    }
  }

  Future<bool> authenticate(
      {String reason = 'Please authenticate to proceed'}) async {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: reason,
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
      return didAuthenticate;
    } on LocalAuthException catch (e) {
      debugPrint("Biometric Authentication Failed: $e");
      return false;
    } on PlatformException catch (e) {
      debugPrint("Platform Error: $e");
      return false;
    }
  }
}
