import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'store.dart';

class StoresPage extends StatefulWidget {
  const StoresPage({super.key});

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {

  // 🏬 FAKE STORES (GPS simulé)
  final List<Store> stores = [
    Store(
      name: 'Velvet Vanity Paris',
      address: '12 Rue de Rivoli, Paris',
      distance: 0.8,
      lat: 48.8566,
      lng: 2.3522,
    ),
    Store(
      name: 'Velvet Vanity La Défense',
      address: 'CNIT La Défense',
      distance: 2.1,
      lat: 48.8919,
      lng: 2.2416,
    ),
    Store(
      name: 'Velvet Vanity Boulogne',
      address: '21 Rue du Point du Jour',
      distance: 4.3,
      lat: 48.8397,
      lng: 2.2399,
    ),
  ];

  // 📞 INTENT — APPEL
  Future<void> callStore() async {
    final uri = Uri.parse('tel:+33123456789');
    await launchUrl(uri);
  }

  // 🗺️ INTENT — GOOGLE MAPS
  Future<void> openMaps(double lat, double lng) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  // 🌐 INTENT — SITE WEB
  Future<void> openWebsite() async {
    final uri = Uri.parse('https://www.sephora.fr');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Stores')),
      body: Column(
        children: [
          // 🔍 BARRE DE RECHERCHE (FAKE)
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              readOnly: true,
              decoration: const InputDecoration(
                hintText: 'Search nearest store',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

          // 📍 LISTE DES BOUTIQUES
          Expanded(
            child: ListView.builder(
              itemCount: stores.length,
              itemBuilder: (context, index) {
                final store = stores[index];

                return Card(
                  margin: const EdgeInsets.all(12),
                  child: ListTile(
                    title: Text(store.name),
                    subtitle: Text(
                      '${store.address}\n${store.distance} km away',
                    ),
                    isThreeLine: true,

                    // 🔘 INTENTS
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.phone),
                          onPressed: callStore,
                        ),
                        IconButton(
                          icon: const Icon(Icons.map),
                          onPressed: () =>
                              openMaps(store.lat, store.lng),
                        ),
                        IconButton(
                          icon: const Icon(Icons.public),
                          onPressed: openWebsite,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

