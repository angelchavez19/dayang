import 'package:dayang/layouts/app.dart';
import 'package:dayang/views/onboarding.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const OnboardingView()),
    GoRoute(path: '/app', builder: (context, state) => const AppLayout()),
  ],
);
