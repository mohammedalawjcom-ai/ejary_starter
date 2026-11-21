import 'package:ejary/core/core.dart';
import 'package:ejary/features/domain.dart';

class PaymentsController extends GetxController {
  PaymentsController(this.repo, this.leases, this.tenants);
  final PaymentRepository repo;
  final LeaseRepository leases;
  final TenantRepository tenants;

  final payments = <Payment>[].obs;
  final filter = 'all'.obs; // all | paid | unpaid | overdue
  Map<String, String> names = {};

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() {
    final tn = {for (final t in tenants.all()) t.id: t.name};
    names = {for (final l in leases.all()) l.id: tn[l.tenantId] ?? '-'};
    payments.value = repo.all()..sort((a, b) => a.month.compareTo(b.month));
  }

  bool isOverdue(Payment p) => !p.paid && p.month.compareTo(ymOf(DateTime.now())) < 0;

  List<Payment> get filtered {
    switch (filter.value) {
      case 'paid':
        return payments.where((p) => p.paid).toList();
      case 'unpaid':
        return payments.where((p) => !p.paid).toList();
      case 'overdue':
        return payments.where(isOverdue).toList();
      default:
        return payments.toList();
    }
  }

  Future<void> toggle(Payment p) async {
    p.paidDate = p.paid ? null : fmt(DateTime.now());
    await repo.save(p);
    load();
  }
}

class PaymentsBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => PaymentsController(Get.find(), Get.find(), Get.find()));
}

class PaymentsView extends GetView<PaymentsController> {
  const PaymentsView({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('payments'.tr)),
        body: Column(children: [
          Obx(() => Wrap(spacing: 8, children: [
                for (final f in const ['all', 'paid', 'unpaid', 'overdue'])
                  ChoiceChip(label: Text(f.tr), selected: controller.filter.value == f,
                      onSelected: (_) => controller.filter.value = f),
              ])),
          Expanded(
            child: Obx(() {
              final list = controller.filtered;
              if (list.isEmpty) return const EmptyState();
              return ListView(children: [
                for (final p in list)
                  ListTile(
                    leading: Icon(p.paid ? Icons.check_circle : Icons.pending,
                        color: p.paid ? Colors.green : (controller.isOverdue(p) ? Colors.red : Colors.orange)),
                    title: Text('${controller.names[p.leaseId] ?? '-'}  •  ${p.month}'),
                    subtitle: Text(p.paid ? '${'paid'.tr} ${p.paidDate}' : (controller.isOverdue(p) ? 'overdue'.tr : 'unpaid'.tr)),
                    trailing: Text(p.amount.toStringAsFixed(0), style: const TextStyle(fontWeight: FontWeight.bold)),
                    onTap: () => controller.toggle(p),
                  ),
              ]);
            }),
          ),
        ]),
      );
}
