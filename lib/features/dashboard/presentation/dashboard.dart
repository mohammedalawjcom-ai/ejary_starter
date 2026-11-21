import 'package:ejary/core/core.dart';
import 'package:ejary/features/domain.dart';
import 'package:ejary/routes/app_pages.dart';

class DashboardController extends GetxController {
  DashboardController(this.props, this.units, this.leases, this.payments, this.tenants);
  final PropertyRepository props;
  final UnitRepository units;
  final LeaseRepository leases;
  final PaymentRepository payments;
  final TenantRepository tenants;

  int propCount = 0, unitCount = 0, occupied = 0, tenantCount = 0, expiring = 0;
  double expected = 0, collected = 0, overdue = 0;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() {
    final now = DateTime.now();
    final ym = ymOf(now);
    final active = leases.all().where((l) => l.isActive(now)).toList();
    final pays = payments.all();
    propCount = props.all().length;
    unitCount = units.all().length;
    tenantCount = tenants.all().length;
    occupied = active.length;
    expected = active.fold<double>(0, (a, l) => a + l.amount);
    collected = pays.where((p) => p.paid && p.month == ym).fold<double>(0, (a, p) => a + p.amount);
    overdue = pays.where((p) => !p.paid && p.month.compareTo(ym) < 0).fold<double>(0, (a, p) => a + p.amount);
    expiring = active.where((l) => DateTime.parse(l.end).difference(now).inDays <= 60).length;
    update();
  }
}

class DashboardBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => DashboardController(Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
}

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  Widget _stat(String label, String value, IconData icon, {Color? color}) => Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(label.tr, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
          ]),
        ),
      );

  Widget _nav(String key, IconData icon, String route) => ListTile(
        leading: Icon(icon),
        title: Text(key.tr),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Get.toNamed(route)?.then((_) => controller.load()),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('dashboard'.tr), actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () => Get.toNamed(Routes.settings)),
        ]),
        body: GetBuilder<DashboardController>(
          builder: (c) => ListView(padding: const EdgeInsets.all(12), children: [
            GridView.count(
              crossAxisCount: 2, shrinkWrap: true, childAspectRatio: 1.5,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _stat('properties', '${c.propCount}', Icons.apartment),
                _stat('total_units', '${c.unitCount}', Icons.door_front_door),
                _stat('occupied', '${c.occupied} / ${c.unitCount}', Icons.key),
                _stat('tenants', '${c.tenantCount}', Icons.people),
                _stat('expected_income', c.expected.toStringAsFixed(0), Icons.trending_up),
                _stat('collected', c.collected.toStringAsFixed(0), Icons.payments, color: Colors.green),
                _stat('overdue', c.overdue.toStringAsFixed(0), Icons.warning_amber, color: Colors.red),
                _stat('expiring', '${c.expiring}', Icons.event_busy, color: Colors.orange),
              ],
            ),
            const Divider(),
            _nav('properties', Icons.apartment, Routes.properties),
            _nav('services', Icons.room_service, Routes.services),
            _nav('tenants', Icons.people, Routes.tenants),
            _nav('leases', Icons.description, Routes.leases),
            _nav('payments', Icons.payments, Routes.payments),
          ]),
        ),
      );
}
