import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/responsive_card.dart';
import '../../../data/models/transport_route.dart';
import '../../../data/repositories/route_repository.dart';
import '../../../localization/app_localizations.dart';
import '../widgets/route_card.dart';
import '../providers/route_provider.dart';

class RoutesScreen extends ConsumerStatefulWidget {
  const RoutesScreen({super.key});

  @override
  ConsumerState<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends ConsumerState<RoutesScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedFilter;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      setState(() {
        switch (_tabController.index) {
          case 1: _selectedFilter = 'bus'; break;
          case 2: _selectedFilter = 'trolley'; break;
          case 3: _selectedFilter = 'tram'; break;
          default: _selectedFilter = null;
        }
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routesAsync = ref.watch(routesProvider);
    
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Поиск маршрутов...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
        ),
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Все'),
            Tab(text: 'Автобусы'),
            Tab(text: 'Троллейбусы'),
            Tab(text: 'Трамваи'),
          ],
        ),
        Expanded(
          child: routesAsync.when(
            data: (routes) {
              var filteredRoutes = routes;
              
              if (_selectedFilter != null) {
                filteredRoutes = filteredRoutes
                    .where((r) => r.type.value == _selectedFilter)
                    .toList();
              }
              
              if (_searchQuery.isNotEmpty) {
                filteredRoutes = filteredRoutes
                    .where((r) => r.routeNumber.contains(_searchQuery) ||
                                 r.routeName.contains(_searchQuery))
                    .toList();
              }
              
              if (filteredRoutes.isEmpty) {
                return const Center(child: Text('Маршруты не найдены'));
              }
              
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: filteredRoutes.length,
                itemBuilder: (context, index) {
                  final route = filteredRoutes[index];
                  return ResponsiveCard(
                    onTap: () => context.push('/route/${route.id}'),
                    child: RouteCard(route: route),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('Ошибка: $error')),
          ),
        ),
      ],
    );
  }
}
