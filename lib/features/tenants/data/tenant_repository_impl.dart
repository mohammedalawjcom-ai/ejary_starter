import 'package:ejary/core/core.dart';
import 'package:ejary/features/domain.dart';

class TenantRepositoryImpl extends LocalCrud<Tenant> implements TenantRepository {
  TenantRepositoryImpl(StorageService s)
      : super(s, 'tenants', Tenant.fromJson, (e) => e.toJson(), (e) => e.id);
}
