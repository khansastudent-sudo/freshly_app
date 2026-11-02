
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedStorage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Freshly 🌿'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Storage',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF345B35),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: storageCard(
                    'My Shelf',
                    Icons.kitchen_outlined,
                    0,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: storageCard(
                    'My Fridge',
                    Icons.kitchen,
                    1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35),
            const Text(
              'Expiring Soon',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF345B35),
              ),
            ),
            const SizedBox(height: 12),
            const Card(
              child: ListTile(
                leading: Icon(
                  Icons.warning_amber,
                  color: Colors.orange,
                ),
                title: Text('Fresh Milk'),
                subtitle: Text('Expires in 2 days'),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(
                  Icons.warning_amber,
                  color: Colors.orange,
                ),
                title: Text('Cabbage'),
                subtitle: Text('Expires in 5 days'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget storageCard(
    String title,
    IconData icon,
    int index,
  ) {
    final isSelected = selectedStorage == index;

    return Card(
      color: isSelected
          ? const Color(0xFFD9EFC8)
          : const Color(0xFFF6F8E8),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedStorage = index;
          });
        },
        child: SizedBox(
          height: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 55,
                color: const Color(0xFF345B35),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
