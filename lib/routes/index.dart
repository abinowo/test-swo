import 'package:go_router/go_router.dart';
import 'package:swo/pages/main.dart';

initRoutes() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScreen(),
      ),
    ],
  );
}
