import 'package:ejary/core/core.dart';
import 'package:ejary/features/auth/data/auth_service.dart';
import 'package:ejary/routes/app_pages.dart';

class LoginController extends GetxController {
  LoginController(this.auth);
  final AuthService auth;
  final user = TextEditingController();
  final pass = TextEditingController();

  Future<void> submit() async {
    if (await auth.login(user.text.trim(), pass.text)) {
      Get.offAllNamed(Routes.dashboard);
    } else {
      toast('invalid');
    }
  }

  @override
  void onClose() {
    user.dispose();
    pass.dispose();
    super.onClose();
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => LoginController(Get.find()));
}

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.apartment, size: 72),
                Text('app_name'.tr, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 24),
                TextField(controller: controller.user,
                    decoration: InputDecoration(labelText: 'username'.tr, border: const OutlineInputBorder())),
                const SizedBox(height: 12),
                TextField(controller: controller.pass, obscureText: true,
                    decoration: InputDecoration(labelText: 'password'.tr, border: const OutlineInputBorder())),
                const SizedBox(height: 16),
                SizedBox(width: double.infinity,
                    child: FilledButton(onPressed: controller.submit, child: Text('login'.tr))),
                const SizedBox(height: 8),
                const Text('admin / 1234', style: TextStyle(color: Colors.grey)),
              ]),
            ),
          ),
        ),
      );
}
