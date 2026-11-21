import 'package:get/get.dart';
import 'package:ejary/core/storage_service.dart';
import 'package:ejary/routes/app_pages.dart';

/// Permanent service. Demo credentials: admin / 1234 (replace with a real API).
class AuthService extends GetxService {
  AuthService(this._s);
  final StorageService _s;
  bool get loggedIn => _s.read<bool>('logged') ?? false;

  Future<bool> login(String u, String p) async {
    final ok = u == 'admin' && p == '1234';
    if (ok) await _s.write('logged', true);
    return ok;
  }

  Future<void> logout() async {
    await _s.write('logged', false);
    Get.offAllNamed(Routes.login);
  }
}
