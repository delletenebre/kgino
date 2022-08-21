import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class KrsNavigationRailDestination extends NavigationRailDestination {
  final PageRouteInfo route;

  KrsNavigationRailDestination({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required this.route,
  }) : super(
    icon: Icon(icon),
    selectedIcon: Icon(selectedIcon),
    label: Text(label),
  );
}