import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en': _en, 'ar': _ar};
}

const _en = {
  'app_name': 'Ejary', 'login': 'Login', 'username': 'Username', 'password': 'Password',
  'invalid': 'Invalid credentials', 'dashboard': 'Dashboard', 'properties': 'Properties',
  'services': 'Services', 'tenants': 'Tenants', 'leases': 'Leases', 'payments': 'Payments',
  'settings': 'Settings', 'save': 'Save', 'cancel': 'Cancel', 'name': 'Name', 'address': 'Address',
  'phone': 'Phone', 'price': 'Monthly price', 'sections': 'Sections', 'rent': 'Monthly rent',
  'surcharge': 'Section surcharge (VIP etc.)', 'tier': 'Section type', 'standard': 'Standard',
  'vip': 'VIP', 'shop': 'Shop', 'infra': 'With infrastructure', 'add_property': 'Add property',
  'add_section': 'Add section', 'add_unit': 'Add unit', 'add_service': 'Add service',
  'add_tenant': 'Add tenant', 'add_lease': 'New lease', 'months': 'Months', 'units': 'Units',
  'total_units': 'Total units', 'occupied': 'Occupied', 'vacant': 'Vacant',
  'expected_income': 'Expected monthly income', 'collected': 'Collected this month',
  'overdue': 'Overdue amount', 'expiring': 'Leases ending in 60 days', 'paid': 'Paid',
  'unpaid': 'Unpaid', 'all': 'All', 'language': 'Arabic / English', 'dark_mode': 'Dark mode',
  'logout': 'Logout', 'empty': 'Nothing here yet', 'ends': 'Ends', 'select_unit': 'Select unit',
  'select_tenant': 'Select tenant', 'no_vacant': 'No vacant units', 'no_tenants': 'Add a tenant first',
  'delete': 'Delete', 'tap_toggle': 'Tap to toggle paid',
};

const _ar = {
  'app_name': 'إيجاري', 'login': 'تسجيل الدخول', 'username': 'اسم المستخدم', 'password': 'كلمة المرور',
  'invalid': 'بيانات الدخول غير صحيحة', 'dashboard': 'لوحة التحكم', 'properties': 'العقارات',
  'services': 'الخدمات', 'tenants': 'المستأجرون', 'leases': 'العقود', 'payments': 'المدفوعات',
  'settings': 'الإعدادات', 'save': 'حفظ', 'cancel': 'إلغاء', 'name': 'الاسم', 'address': 'العنوان',
  'phone': 'الهاتف', 'price': 'السعر الشهري', 'sections': 'الأقسام', 'rent': 'الإيجار الشهري',
  'surcharge': 'رسوم إضافية للقسم (VIP ...)', 'tier': 'نوع القسم', 'standard': 'عادي',
  'vip': 'VIP', 'shop': 'محل تجاري', 'infra': 'ببنية تحتية', 'add_property': 'إضافة عقار',
  'add_section': 'إضافة قسم', 'add_unit': 'إضافة وحدة', 'add_service': 'إضافة خدمة',
  'add_tenant': 'إضافة مستأجر', 'add_lease': 'عقد جديد', 'months': 'عدد الأشهر', 'units': 'الوحدات',
  'total_units': 'إجمالي الوحدات', 'occupied': 'مؤجرة', 'vacant': 'شاغرة',
  'expected_income': 'الدخل الشهري المتوقع', 'collected': 'المحصّل هذا الشهر',
  'overdue': 'المبالغ المتأخرة', 'expiring': 'عقود تنتهي خلال 60 يوماً', 'paid': 'مدفوع',
  'unpaid': 'غير مدفوع', 'all': 'الكل', 'language': 'عربي / English', 'dark_mode': 'الوضع الداكن',
  'logout': 'تسجيل الخروج', 'empty': 'لا توجد بيانات بعد', 'ends': 'ينتهي', 'select_unit': 'اختر الوحدة',
  'select_tenant': 'اختر المستأجر', 'no_vacant': 'لا توجد وحدات شاغرة', 'no_tenants': 'أضف مستأجراً أولاً',
  'delete': 'حذف', 'tap_toggle': 'اضغط لتغيير حالة الدفع',
};
