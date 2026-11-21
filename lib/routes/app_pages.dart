import 'package:get/get.dart';
import 'package:ejary/core/middleware.dart';
import 'package:ejary/features/auth/presentation/login.dart';
import 'package:ejary/features/dashboard/presentation/dashboard.dart';
import 'package:ejary/features/properties/presentation/properties.dart';
import 'package:ejary/features/properties/presentation/property_detail.dart';
import 'package:ejary/features/services/presentation/services.dart';
import 'package:ejary/features/tenants/presentation/tenants.dart';
import 'package:ejary/features/leases/presentation/leases.dart';
import 'package:ejary/features/payments/presentation/payments.dart';
import 'package:ejary/features/settings/presentation/settings.dart';

abstract class Routes {
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const properties = '/properties';
  static const propertyDetail = '/properties/detail';
  static const services = '/services';
  static const tenants = '/tenants';
  static const leases = '/leases';
  static const payments = '/payments';
  static const settings = '/settings';
}

class AppPages {
  static final _guard = [AuthMiddleware()];
  static final pages = <GetPage>[
    GetPage(name: Routes.login, page: () => const LoginView(), binding: LoginBinding()),
    GetPage(name: Routes.dashboard, page: () => const DashboardView(), binding: DashboardBinding(), middlewares: _guard),
    GetPage(name: Routes.properties, page: () => const PropertiesView(), binding: PropertiesBinding(), middlewares: _guard),
    GetPage(name: Routes.propertyDetail, page: () => const PropertyDetailView(), binding: PropertyDetailBinding(), middlewares: _guard),
    GetPage(name: Routes.services, page: () => const ServicesView(), binding: ServicesBinding(), middlewares: _guard),
    GetPage(name: Routes.tenants, page: () => const TenantsView(), binding: TenantsBinding(), middlewares: _guard),
    GetPage(name: Routes.leases, page: () => const LeasesView(), binding: LeasesBinding(), middlewares: _guard),
    GetPage(name: Routes.payments, page: () => const PaymentsView(), binding: PaymentsBinding(), middlewares: _guard),
    GetPage(name: Routes.settings, page: () => const SettingsView(), binding: SettingsBinding(), middlewares: _guard),
  ];
}
