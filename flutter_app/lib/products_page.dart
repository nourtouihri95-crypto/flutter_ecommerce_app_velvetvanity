import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brand_logo.dart';
import 'product.dart';
import 'product_details_page.dart';
import 'favorites_provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Lips',
    'Face',
    'Eyes',
    'Blush',
    'Highlighter',
    'Bronzer',
    'Tools',
    'Fixing',
  ];

  final List<Product> products = [
    Product(
      name: 'Velvet Blush Compact',
      image: 'assets/images/1.png',
      price: 32,
      category: 'Blush',
      description:
          'Blush compact au fini velouté qui apporte une touche de fraîcheur naturelle.',
    ),
    Product(
      name: 'Matte Lipstick Nude',
      image: 'assets/images/2.png',
      price: 28,
      category: 'Lips',
      description:
          'Rouge à lèvres nude au fini mat intense et longue tenue.',
    ),
    Product(
      name: 'Eyeshadow Palette Pro',
      image: 'assets/images/3.png',
      price: 54,
      category: 'Eyes',
      description:
          'Palette professionnelle de teintes mates et irisées.',
    ),
    Product(
      name: 'Liquid Eyeliner Duo',
      image: 'assets/images/4.png',
      price: 22,
      category: 'Eyes',
      description:
          'Eyeliner liquide haute précision avec pointe fine pour un tracé net et intense toute la journée.',
    ),
    Product(
      name: 'Gloss Shine Rose',
      image: 'assets/images/5.png',
      price: 24,
      category: 'Lips',
      description:
          'Gloss brillant à la teinte rosée subtile. Apporte confort, hydratation et effet repulpant.',
    ),
    Product(
      name: 'Contour Face Kit',
      image: 'assets/images/6.png',
      price: 48,
      category: 'Face',
      description:
          'Kit contouring complet pour sculpter et définir le visage avec un rendu naturel.',
    ),
    Product(
      name: 'Classic Red Lipstick',
      image: 'assets/images/7.png',
      price: 29,
      category: 'Lips',
      description:
          'Rouge à lèvres rouge iconique à la pigmentation intense et à la tenue longue durée.',
    ),
    Product(
      name: 'Airbrush Foundation',
      image: 'assets/images/8.png',
      price: 45,
      category: 'Face',
      description:
          'Fond de teint effet airbrush pour un teint unifié, lisse et sans imperfections visibles.',
    ),
    Product(
      name: 'Nude Lipstick Set',
      image: 'assets/images/9.png',
      price: 35,
      category: 'Lips',
      description:
          'Coffret de rouges à lèvres nude incontournables, parfaits pour un look naturel chic.',
    ),
    Product(
      name: 'Luxury Blush Gold',
      image: 'assets/images/10.png',
      price: 38,
      category: 'Blush',
      description:
          'Blush lumineux aux reflets dorés pour sublimer les pommettes avec élégance.',
    ),
    Product(
      name: 'Soft Glow Highlighter',
      image: 'assets/images/11.png',
      price: 34,
      category: 'Highlighter',
      description:
          'Enlumineur délicat pour un éclat naturel et une peau visiblement lumineuse.',
    ),
    Product(
      name: 'Liquid Matte Lip',
      image: 'assets/images/12.png',
      price: 26,
      category: 'Lips',
      description:
          'Rouge à lèvres liquide mat ultra-pigmenté avec une texture légère et confortable.',
    ),
    Product(
      name: 'Diamond Highlighter',
      image: 'assets/images/13.png',
      price: 42,
      category: 'Highlighter',
      description:
          'Highlighter intense aux reflets diamant pour un glow spectaculaire.',
    ),
    Product(
      name: 'Chocolate Bronzer',
      image: 'assets/images/14.png',
      price: 36,
      category: 'Bronzer',
      description:
          'Bronzer chaud effet soleil pour réchauffer le teint et structurer le visage.',
    ),
    Product(
      name: 'Makeup Brush Set',
      image: 'assets/images/15.png',
      price: 59,
      category: 'Tools',
      description:
          'Set complet de pinceaux professionnels pour le teint, les yeux et les lèvres.',
    ),
    Product(
      name: 'Peach Blush Trio',
      image: 'assets/images/16.png',
      price: 33,
      category: 'Blush',
      description:
          'Trio de blushs pêche pour un effet bonne mine modulable selon l’intensité désirée.',
    ),
    Product(
      name: 'Natural Foundation',
      image: 'assets/images/17.png',
      price: 41,
      category: 'Face',
      description:
          'Fond de teint naturel à couvrance modulable pour un rendu seconde peau.',
    ),
    Product(
      name: 'Matte Finish Spray',
      image: 'assets/images/18.png',
      price: 27,
      category: 'Fixing',
      description:
          'Spray fixant matifiant pour prolonger la tenue du maquillage toute la journée.',
    ),
    Product(
      name: 'Soft Pink Blush',
      image: 'assets/images/19.png',
      price: 31,
      category: 'Blush',
      description:
          'Blush rose doux pour un teint frais et lumineux au quotidien.',
    ),
  ];

  List<Product> get filteredProducts {
    if (selectedCategory == 'All') {
      return products;
    }
    return products
        .where((p) => p.category == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const BrandLogo(size: 70),
          const SizedBox(height: 10),

          // 🔍 FILTRES PAR CATÉGORIE
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    selectedColor:
                        Theme.of(context).colorScheme.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // 🧴 GRID PRODUITS
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                final isFav = favorites.isFavorite(product);

                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) =>
                            ProductDetailsPage(product: product),
                        transitionsBuilder: (_, animation, __, child) {
                          final offsetAnimation = Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(animation);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: 1,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: const Color.fromARGB(255, 188, 40, 89),
                              ),
                              onPressed: () {
                                favorites.toggleFavorite(product);
                              },
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset(
                                product.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              product.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${product.price.toStringAsFixed(2)} €',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 183, 37, 86),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
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
