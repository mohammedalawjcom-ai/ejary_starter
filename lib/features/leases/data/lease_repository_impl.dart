import 'package:ejary/core/core.dart';
import 'package:ejary/features/domain.dart';

class LeaseRepositoryImpl extends LocalCrud<Lease> implements LeaseRepository {
  LeaseRepositoryImpl(StorageService s)
      : super(s, 'leases', Lease.fromJson, (e) => e.toJson(), (e) => e.id);
}
