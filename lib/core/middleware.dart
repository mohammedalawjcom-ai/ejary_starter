import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ejary/features/auth/data/auth_service.dart';
import 'package:ejary/routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) =>
      Get.find<AuthService>().loggedIn ? null : const RouteSettings(name: Routes.login);
}
