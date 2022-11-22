import 'dart:convert';

import 'package:d_rank/features/model/data_model.dart';
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
          name: 'club-details',
          path: 'club-details/:data',
          builder: (BuildContext context, GoRouterState state) {
            return ClubDetailsScreen(
              data: DataModel.fromJson(
                jsonDecode(state.params['data']!),
              ),
            );
          },
        ),
      ],
    ),
  ],
);
