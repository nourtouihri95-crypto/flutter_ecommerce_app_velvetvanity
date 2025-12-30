import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'brand_logo.dart';
import 'promo_timer.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int currentStep = 0;

  // 🔥 PROMO
  bool promoActive = true;
  final double promoRate = 0.2; // 20%

  void nextStep() {
    if (currentStep < 3) {
      setState(() => currentStep++);
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    }
  }

  double discountedTotal(double total) {
    if (!promoActive) return total;
    return total * (1 - promoRate);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const BrandLogo(size: 60),
          const SizedBox(height: 10),

          // 🧭 PROGRESS BAR
          LinearProgressIndicator(
            value: (currentStep + 1) / 4,
            minHeight: 8,
            backgroundColor: Colors.pink.shade100,
            color: Colors.pink,
          ),

          const SizedBox(height: 15),

          // ⏱️ PROMO TIMER (VISIBLE SEULEMENT AU DÉBUT)
          if (promoActive && currentStep < 3)
            PromoTimer(
              duration: const Duration(minutes: 5),
              onExpire: () {
                setState(() {
                  promoActive = false;
                });
              },
            ),

          const SizedBox(height: 10),

          Expanded(child: _buildStepContent(cart)),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentStep > 0)
                  TextButton(
                    onPressed: previousStep,
                    child: const Text('Back'),
                  ),
                ElevatedButton(
                  onPressed: nextStep,
                  child: Text(currentStep == 3 ? 'Finish' : 'Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent(CartProvider cart) {
    switch (currentStep) {
      case 0:
        return _cartStep(cart);
      case 1:
        return _addressStep();
      case 2:
        return _paymentStep();
      case 3:
        return _confirmationStep(cart);
      default:
        return const SizedBox();
    }
  }

  // 🧾 STEP 1 — CART
  Widget _cartStep(CartProvider cart) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Your Cart',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        ...cart.items.map(
          (item) => ListTile(
            title: Text(item.product.name),
            trailing: Text(
              '${(item.product.price * item.quantity).toStringAsFixed(2)} €',
            ),
          ),
        ),

        const Divider(),

        Text(
          promoActive
              ? 'Promo total: ${discountedTotal(cart.totalPrice).toStringAsFixed(2)} €'
              : 'Total: ${cart.totalPrice.toStringAsFixed(2)} €',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // 🏠 STEP 2 — ADDRESS
  Widget _addressStep() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          Text(
            'Shipping Address',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          TextField(decoration: InputDecoration(labelText: 'Full name')),
          TextField(decoration: InputDecoration(labelText: 'Address')),
          TextField(decoration: InputDecoration(labelText: 'City')),
          TextField(decoration: InputDecoration(labelText: 'Postal code')),
        ],
      ),
    );
  }

  // 💳 STEP 3 — PAYMENT
  Widget _paymentStep() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          Text(
            'Payment',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          TextField(decoration: InputDecoration(labelText: 'Card number')),
          TextField(decoration: InputDecoration(labelText: 'Expiry date')),
          TextField(decoration: InputDecoration(labelText: 'CVV')),
        ],
      ),
    );
  }

  // ✅ STEP 4 — CONFIRMATION
  Widget _confirmationStep(CartProvider cart) {
    final totalPaid = discountedTotal(cart.totalPrice);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 80),
          const SizedBox(height: 20),
          const Text(
            'Order Confirmed!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Total paid: ${totalPaid.toStringAsFixed(2)} €',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              cart.clearCart();
              Navigator.pop(context);
            },
            child: const Text('Back to shop'),
          ),
        ],
      ),
    );
  }
}

