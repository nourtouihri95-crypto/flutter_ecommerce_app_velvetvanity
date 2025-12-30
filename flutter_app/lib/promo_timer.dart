import 'dart:async';
import 'package:flutter/material.dart';

class PromoTimer extends StatefulWidget {
  final Duration duration;
  final VoidCallback onExpire;

  const PromoTimer({
    super.key,
    required this.duration,
    required this.onExpire,
  });

  @override
  State<PromoTimer> createState() => _PromoTimerState();
}

class _PromoTimerState extends State<PromoTimer> {
  late Duration remaining;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    remaining = widget.duration;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remaining.inSeconds == 0) {
        t.cancel();
        widget.onExpire();
      } else {
        setState(() {
          remaining -= const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = remaining.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.pink),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.timer, color: Colors.pink),
          const SizedBox(width: 10),
          Text(
            'Promo -20% : $minutes:$seconds',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
        ],
      ),
    );
  }
}
