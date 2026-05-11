import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/favorites_provider.dart';
import '../../../data/repositories/route_repository.dart';
import '../../../core/widgets/adaptive_scaffold.dart';
import '../../routes/widgets/route_card.dart';
import '../../routes/screens/route_detail_screen.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  final RouteRepository _repository = RouteRepository();

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Избранное')),
      body: favorites.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Нет избранных маршрутов'),
                ],
              ),
            )
          : FutureBuilder(
              future: Future.wait(favorites.map((id) => _repository.getRouteById(id))),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                final routes = snapshot.data?.whereType().toList() ?? [];
                
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: routes.length,
                  itemBuilder: (context, index) {
                    final route = routes[index];
                    return Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RouteDetailScreen(routeId: route.id!),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(route.type.icon, color: route.type.color),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Маршрут ${route.routeNumber}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text('${route.startStop} → ${route.endStop}'),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  ref.read(favoritesProvider.notifier).removeFavorite(route.id!);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
