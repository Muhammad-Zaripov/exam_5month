import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FoodsButtons extends StatefulWidget {
  final String names;
  final int initialNumber;
  final void Function(String, int) onChanged;

  const FoodsButtons({
    super.key,
    required this.names,
    required this.initialNumber,
    required this.onChanged,
  });

  @override
  State<FoodsButtons> createState() => _FoodsButtonsState();
}

class _FoodsButtonsState extends State<FoodsButtons> {
  late int count;
  final databaseRef = FirebaseDatabase.instance.ref("orders");

  @override
  void initState() {
    super.initState();
    count = widget.initialNumber;
  }

  Future<void> updateToFirebase() async {
    await databaseRef.child(widget.names).set({
      "name": widget.names,
      "quantity": count,
    });
  }

  void increment() {
    setState(() {
      count++;
    });
    widget.onChanged(widget.names, count);
    updateToFirebase();
  }

  void decrement() {
    if (count > 0) {
      setState(() {
        count--;
      });
      widget.onChanged(widget.names, count);
      updateToFirebase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.network(
            "https://img.freepik.com/premium-vector/amazing-text-banner-minimal-handwriting-inscription-amazing-black-color-isolated-white_112545-5955.jpg?semt=ais_hybrid",
            width: 70,
            height: 70,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.image, size: 70, color: Colors.grey);
            },
          ),
          const SizedBox(height: 8),
          Text(
            widget.names,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text("$count ta", style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: count > 0 ? decrement : null,
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: count > 0 ? Colors.red : Colors.grey.shade300,
                ),
              ),
              IconButton(
                onPressed: increment,
                icon: const Icon(Icons.add_circle_outline, color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
