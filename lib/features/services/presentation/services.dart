import 'package:ejary/core/core.dart';
import 'package:ejary/features/domain.dart';

class ServicesController extends GetxController {
  ServicesController(this.repo);
  final ServiceRepository repo;
  final items = <ServiceItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() => items.value = repo.all();

  Future<void> add() async {
    final r = await formDialog('add_service',
        const [FieldDef('name', 'name'), FieldDef('price', 'price', number: true)]);
    if (r == null || r['name']!.isEmpty) return;
    await repo.save(ServiceItem(id: newId(), name: r['name']!, price: double.tryParse(r['price']!) ?? 0));
    load();
  }

  Future<void> remove(ServiceItem s) async {
    await repo.delete(s.id);
    load();
  }
}

class ServicesBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => ServicesController(Get.find()));
}

class ServicesView extends GetView<ServicesController> {
  const ServicesView({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('services'.tr)),
        floatingActionButton: FloatingActionButton(onPressed: controller.add, child: const Icon(Icons.add)),
        body: Obx(() => controller.items.isEmpty
            ? const EmptyState()
            : ListView(children: [
                for (final s in controller.items)
                  ListTile(
                    leading: const Icon(Icons.room_service),
                    title: Text(s.name),
                    subtitle: Text('${'price'.tr}: ${s.price.toStringAsFixed(0)}'),
                    trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => controller.remove(s)),
                  ),
              ])),
      );
}
