import 'package:flutter/material.dart';

import 'products_page.dart';
import 'favorites_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';
import 'stores_page.dart';


class MainNavigation extends StatefulWidget {
  final String fullname;
  final String role;
  final String email;

  const MainNavigation({
    super.key,
    required this.fullname,
    required this.role,
    required this.email,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const ProductsPage(),
      const FavoritesPage(),
      const CartPage(),
      const StoresPage(), // 🆕 STORES
      ProfilePage(
        fullname: widget.fullname,
        role: widget.role,
        email: widget.email,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on), // 🆕 STORES
            label: 'Stores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

