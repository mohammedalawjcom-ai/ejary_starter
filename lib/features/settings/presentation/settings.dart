import 'package:ejary/core/core.dart';
import 'package:ejary/features/auth/data/auth_service.dart';

class SettingsController extends GetxController {
  SettingsController(this.store, this.auth);
  final StorageService store;
  final AuthService auth;
  late final isDark = (store.read<bool>('dark') ?? false).obs;
  late final lang = (store.read<String>('lang') ?? 'ar').obs;

  Future<void> setDark(bool v) async {
    isDark.value = v;
    Get.changeThemeMode(v ? ThemeMode.dark : ThemeMode.light);
    await store.write('dark', v);
  }

  Future<void> setLang(bool arabic) async {
    lang.value = arabic ? 'ar' : 'en';
    Get.updateLocale(Locale(lang.value));
    await store.write('lang', lang.value);
  }
}

class SettingsBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => SettingsController(Get.find(), Get.find()));
}

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('settings'.tr)),
        body: ListView(children: [
          Obx(() => SwitchListTile(
              secondary: const Icon(Icons.language), title: Text('language'.tr),
              value: controller.lang.value == 'ar', onChanged: controller.setLang)),
          Obx(() => SwitchListTile(
              secondary: const Icon(Icons.dark_mode), title: Text('dark_mode'.tr),
              value: controller.isDark.value, onChanged: controller.setDark)),
          ListTile(leading: const Icon(Icons.logout), title: Text('logout'.tr), onTap: controller.auth.logout),
        ]),
      );
}
