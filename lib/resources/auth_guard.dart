// import 'package:auto_route/auto_route.dart';
// import 'package:get/get.dart';

// import '../controllers/auth_controller.dart';
// import 'krs_router.gr.dart';

// class AuthGuard extends AutoRedirectGuard {
//   late final AuthController authController;

//   AuthGuard() {
//     authController = Get.find<AuthController>();
//     authController.addListener(reevaluate);
//   }

//   @override
//   Future<bool> canNavigate(RouteMatch route) async {
//     return authController.status.isSuccess;
//   }

//   @override
//   Future<void> onNavigation(
//       NavigationResolver resolver, StackRouter router) async {
//     if (await canNavigate(resolver.route)) {
//       resolver.next();
//     } else {
//       redirect(const SigninRoute(), resolver: resolver);
//     }
//   }
// }