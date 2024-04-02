import 'package:cook_with_me/modules/home/home_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter getRouter() => GoRouter(routes: [
      GoRoute(
          path: "/",
          pageBuilder: (context, state) =>
              NoTransitionPage<void>(child: HomeScreen())),
    ]);
