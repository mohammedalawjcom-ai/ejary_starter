import 'package:ejary/core/core.dart';
import 'package:ejary/features/domain.dart';

class PaymentRepositoryImpl extends LocalCrud<Payment> implements PaymentRepository {
  PaymentRepositoryImpl(StorageService s)
      : super(s, 'payments', Payment.fromJson, (e) => e.toJson(), (e) => e.id);
}
