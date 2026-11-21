import 'package:ejary/core/core.dart';
import 'package:ejary/features/domain.dart';

class TenantsController extends GetxController {
  TenantsController(this.repo);
  final TenantRepository repo;
  final items = <Tenant>[].obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() => items.value = repo.all();

  Future<void> add() async {
    final r = await formDialog('add_tenant', const [FieldDef('name', 'name'), FieldDef('phone', 'phone', number: true)]);
    if (r == null || r['name']!.isEmpty) return;
    await repo.save(Tenant(id: newId(), name: r['name']!, phone: r['phone']!));
    load();
  }

  Future<void> remove(Tenant t) async {
    await repo.delete(t.id);
    load();
  }
}

class TenantsBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => TenantsController(Get.find()));
}

class TenantsView extends GetView<TenantsController> {
  const TenantsView({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('tenants'.tr)),
        floatingActionButton: FloatingActionButton(onPressed: controller.add, child: const Icon(Icons.add)),
        body: Obx(() => controller.items.isEmpty
            ? const EmptyState()
            : ListView(children: [
                for (final t in controller.items)
                  ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(t.name),
                    subtitle: Text(t.phone),
                    trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => controller.remove(t)),
                  ),
              ])),
      );
}
