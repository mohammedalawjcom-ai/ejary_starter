import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ejary/core/core.dart';
import 'package:ejary/core/theme.dart';
import 'package:ejary/core/translations.dart';
import 'package:ejary/routes/app_pages.dart';
import 'package:ejary/routes/initial_binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => StorageService().init(), permanent: true);
  runApp(const EjaryApp());
}

class EjaryApp extends StatelessWidget {
  const EjaryApp({super.key});
  @override
  Widget build(BuildContext context) {
    final s = Get.find<StorageService>();
    return GetMaterialApp(
      title: 'Ejary',
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: Locale(s.read<String>('lang') ?? 'ar'),
      fallbackLocale: const Locale('en'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: (s.read<bool>('dark') ?? false) ? ThemeMode.dark : ThemeMode.light,
      initialBinding: InitialBinding(),
      initialRoute: Routes.dashboard,
      getPages: AppPages.pages,
    );
  }
}
