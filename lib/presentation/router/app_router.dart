import 'package:flutter/material.dart';
import 'package:mobile/presentation/screens/Driver/end_task_screen.dart';
import 'package:mobile/presentation/screens/Driver/my_tasks_screen.dart';
import 'package:mobile/presentation/screens/Driver/previous_tasks_screen.dart';
import 'package:mobile/presentation/screens/Driver/task_details_screen.dart';
import 'package:mobile/presentation/screens/shared/login_screen.dart';
import 'package:mobile/presentation/screens/shared/reset_password_screen.dart';
import 'package:mobile/presentation/screens/shared/splash_screen.dart';
import 'package:mobile/presentation/screens/vendor/branch_map_screen.dart';
import 'package:mobile/presentation/screens/vendor/pickup_map_screen.dart';
import 'package:mobile/presentation/screens/vendor/home_layout.dart';
import 'package:mobile/presentation/screens/vendor/order_details_screen.dart';
import 'package:mobile/presentation/screens/shared/settings_screen.dart';
import 'package:mobile/presentation/screens/shared/verify_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/verify':
        return MaterialPageRoute(builder: (_) => VerifyScreen(
          data: settings.arguments,
        ));
      case '/reset':
        return MaterialPageRoute(builder: (_) => ResetPassword(
          data: settings.arguments,
        ));
      case '/tasks':
        return MaterialPageRoute(builder: (_) => const MyTasksScreen());
      case '/previous':
        return MaterialPageRoute(builder: (_) => const PreviousTasksScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const Settings());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeLayout());
      case '/pickupMap':
        return MaterialPageRoute(
            builder: (_) => PickupMapScreen(
                  data: settings.arguments,
                ));
      case '/branchMap':
        return MaterialPageRoute(
            builder: (_) => BranchMapsScreen(
                  data: settings.arguments,
                ));
      case '/orderDetails':
        return MaterialPageRoute(builder: (_) => const OrderDetailsScreen());
      case '/startTask':
        return MaterialPageRoute(
            builder: (_) => TaskDetailsScreen(
                  data: settings.arguments,
                ));
      case '/endTask':
        return MaterialPageRoute(
            builder: (_) => EndTaskScreen(
              data: settings.arguments,
            ));
      default:
        return null;
    }
  }
}
