import 'package:ejary/core/core.dart';
import 'package:ejary/features/domain.dart';

class LeasesController extends GetxController {
  LeasesController(this.leaseRepo, this.units, this.sections, this.tenants, this.payments, this.createLease);
  final LeaseRepository leaseRepo;
  final UnitRepository units;
  final SectionRepository sections;
  final TenantRepository tenants;
  final PaymentRepository payments;
  final CreateLeaseUseCase createLease;

  final items = <Lease>[].obs;
  Map<String, String> tenantNames = {}, unitNames = {};

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() {
    final secName = {for (final s in sections.all()) s.id: s.name};
    tenantNames = {for (final t in tenants.all()) t.id: t.name};
    unitNames = {for (final u in units.all()) u.id: '${secName[u.sectionId] ?? ''} - ${u.name}'};
    items.value = leaseRepo.all();
  }

  Future<void> add() async {
    final now = DateTime.now();
    final taken = leaseRepo.all().where((l) => l.isActive(now)).map((l) => l.unitId).toSet();
    final vacant = units.all().where((u) => !taken.contains(u.id)).toList();
    if (vacant.isEmpty) return toast('no_vacant');
    final ts = tenants.all();
    if (ts.isEmpty) return toast('no_tenants');
    final u = await pickDialog<Unit>('select_unit', vacant, (u) => unitNames[u.id] ?? u.name);
    if (u == null) return;
    final t = await pickDialog<Tenant>('select_tenant', ts, (t) => t.name);
    if (t == null) return;
    final r = await formDialog('add_lease', const [FieldDef('months', 'months', number: true, initial: '12')]);
    if (r == null) return;
    // Lease starts on the 1st of the current month; payments are generated monthly.
    await createLease(u, t, DateTime(now.year, now.month, 1), (int.tryParse(r['months']!) ?? 12).clamp(1, 120));
    load();
  }

  Future<void> remove(Lease l) async {
    for (final p in payments.all().where((p) => p.leaseId == l.id)) {
      await payments.delete(p.id);
    }
    await leaseRepo.delete(l.id);
    load();
  }
}

class LeasesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeasesController(Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
  }
}

class LeasesView extends GetView<LeasesController> {
  const LeasesView({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('leases'.tr)),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: controller.add, icon: const Icon(Icons.add), label: Text('add_lease'.tr)),
        body: Obx(() => controller.items.isEmpty
            ? const EmptyState()
            : ListView(children: [
                for (final l in controller.items)
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: Text('${controller.tenantNames[l.tenantId] ?? '-'}  •  ${controller.unitNames[l.unitId] ?? '-'}'),
                    subtitle: Text('${l.amount.toStringAsFixed(0)}  |  ${'ends'.tr}: ${l.end}'),
                    trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => controller.remove(l)),
                  ),
              ])),
      );
}
