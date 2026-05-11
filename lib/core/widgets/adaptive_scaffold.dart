import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AdaptiveScaffold extends ConsumerWidget {
  final Widget child;
  final String? title;
  
  const AdaptiveScaffold({super.key, required this.child, this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isDesktop = screenWidth > 800;
    
    if (isDesktop) {
      return _DesktopLayout(child: child, title: title);
    } else {
      return _MobileLayout(child: child, title: title);
    }
  }
}

class _DesktopLayout extends StatefulWidget {
  final Widget child;
  final String? title;
  
  const _DesktopLayout({required this.child, this.title});

  @override
  State<_DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<_DesktopLayout> {
  int _selectedIndex = 0;

  void _navigateTo(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0: GoRouter.of(context).go('/'); break;
      case 1: GoRouter.of(context).go('/favorites'); break;
      case 2: GoRouter.of(context).go('/settings'); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _navigateTo,
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.directions_bus), label: Text('Маршруты')),
              NavigationRailDestination(icon: Icon(Icons.favorite_border), label: Text('Избранное')),
              NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Настройки')),
            ],
          ),
          const VerticalDivider(thickness: 1),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}

class _MobileLayout extends StatefulWidget {
  final Widget child;
  final String? title;
  
  const _MobileLayout({required this.child, this.title});

  @override
  State<_MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<_MobileLayout> {
  int _selectedIndex = 0;

  void _navigateTo(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0: GoRouter.of(context).go('/'); break;
      case 1: GoRouter.of(context).go('/favorites'); break;
      case 2: GoRouter.of(context).go('/settings'); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? 'Minsk Transport')),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateTo,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.directions_bus), label: 'Маршруты'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Избранное'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Настройки'),
        ],
      ),
    );
  }
}
