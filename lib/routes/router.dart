import 'package:d_rank/features/presentation/aac/aac_screen.dart';
import 'package:d_rank/features/presentation/club_details/club_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AACScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'club-details',
          builder: (BuildContext context, GoRouterState state) {
            return const ClubDetailsScreen();
          },
        ),
      ],
    ),
  ],
);
