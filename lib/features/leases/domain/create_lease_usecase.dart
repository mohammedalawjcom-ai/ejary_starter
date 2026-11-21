import 'package:ejary/core/utils.dart';
import 'package:ejary/features/properties/domain/property.dart';
import 'package:ejary/features/services/domain/service_item.dart';
import 'package:ejary/features/tenants/domain/tenant.dart';
import 'package:ejary/features/payments/domain/payment.dart';
import 'lease.dart';

class CreateLeaseUseCase {
  CreateLeaseUseCase(this.sections, this.services, this.leases, this.payments);
  final SectionRepository sections;
  final ServiceRepository services;
  final LeaseRepository leases;
  final PaymentRepository payments;

  Future<void> call(Unit unit, Tenant tenant, DateTime start, int months) async {
    final sec = sections.all().firstWhere((s) => s.id == unit.sectionId);
    final svc = services.all().where((s) => sec.serviceIds.contains(s.id)).fold<double>(0, (a, s) => a + s.price);
    final amount = unit.rent + sec.surcharge + svc;
    final end = DateTime(start.year, start.month + months, start.day);
    final lease = Lease(id: newId(), unitId: unit.id, tenantId: tenant.id,
        start: fmt(start), end: fmt(end), amount: amount);
    await leases.save(lease);
    for (var i = 0; i < months; i++) {
      final d = DateTime(start.year, start.month + i, 1);
      await payments.save(Payment(id: '${newId()}_$i', leaseId: lease.id, month: ymOf(d), amount: amount));
    }
  }
}
