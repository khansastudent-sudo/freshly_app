import 'package:flutter/material.dart';
import 'add_item_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;
  final List<Map<String, dynamic>> _items = [
    {'name': 'Fresh Milk', 'storage': 'Fridge',
     'expiry': DateTime.now().add(const Duration(days: 2))},
    {'name': 'Cabbage', 'storage': 'Fridge',
     'expiry': DateTime.now().add(const Duration(days: 5))},
  ];

  Future<void> _addItem(String storage) async {
    final item = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => AddItemScreen(initialStorage: storage)),
    );
    if (!mounted) return;
    if (item != null) setState(() => _items.add(item));
  }

  void _openItem(Map<String, dynamic> item) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(
          name: item['name'] as String,
          storage: item['storage'] as String,
          expiry: item['expiry'] as DateTime,
        ),
      ),
    );
  }

  int _daysLeft(Map<String, dynamic> item) {
    final expiry = item['expiry'] as DateTime;
    final today = DateUtils.dateOnly(DateTime.now());
    return DateUtils.dateOnly(expiry).difference(today).inDays;
  }
  Widget _itemTile(Map<String, dynamic> item) {
    final days = _daysLeft(item);
return Card(
  color: const Color(0xFFFFE8DA),
  elevation: 3,
  shadowColor: const Color(0x33D9A7A0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18),
  ),
  child: ListTile(

        leading: const Icon(Icons.shopping_basket, color: Color(0xFF628C55)),
        title: Text(item['name'] as String),
        subtitle: Text(days < 0 ? 'Expired ${-days} days ago'
            : days == 0 ? 'Expires today'
            : 'Expires in $days days'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _openItem(item),
      ),
    );
  }

  Widget _itemList(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return const Center(child: Padding(
        padding: EdgeInsets.all(30),
        child: Text('No items yet. Tap + to add your first item!'),
      ));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) => _itemTile(items[index]),
    );
  }

  Widget _storageCard(String name, IconData icon, Color color) {
    return Expanded(
     
child: Card(
  color: color,
  elevation: 5,
  shadowColor: const Color(0x5587A878),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24),
  ),
  clipBehavior: Clip.antiAlias,
  child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => setState(() => _tab = name == 'Shelf' ? 1 : 2),
          child: SizedBox(
            height: 176,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
Icon(
  icon,
  size: 78,
  color: const Color(0xFF42707A),
),  

                const SizedBox(height: 12),
                Text(name, style: const TextStyle(
                    fontSize: 19, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titles = ['Your Storage', 'My Shelf', 'My Fridge', 'Reminders'];
    final current = _tab == 1 ? 'Shelf' : 'Fridge';
    final storageItems = _items.where((item) => item['storage'] == current).toList();
    final reminders = _items.where((item) => _daysLeft(item) <= 7).toList()
      ..sort((a, b) => _daysLeft(a).compareTo(_daysLeft(b)));

    return Scaffold(
backgroundColor: const Color(0xFFFFE4D6),
      appBar: AppBar(title: const Text('Freshly 🍒')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titles[_tab], style: const TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold,
              color: Color(0xFF3C6043),
            )),
            const SizedBox(height: 16),
            if (_tab == 0) ...[
              Row(children: [
                _storageCard('Shelf', Icons.inventory_2_outlined, const Color(0xFFD8EBC9)),
                _storageCard('Fridge', Icons.kitchen, const Color(0xFFC9E5E7)),
              ]),
              const SizedBox(height: 28),
              const Text('Expiring Soon', style: TextStyle(
                fontSize: 23, fontWeight: FontWeight.bold,
                color: Color(0xFF3C6043),
              )),
              _itemList(reminders),
            ] else if (_tab == 1 || _tab == 2) ...[
              Center(child: Icon(
                _tab == 1 ? Icons.inventory_2_outlined : Icons.kitchen,
                size: 135, color: const Color(0xFF739E9B),
              )),
              _itemList(storageItems),
            ] else ...[
              _itemList(reminders),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFBFE6E6),
        onPressed: () => _addItem(_tab == 1 ? 'Shelf' : 'Fridge'),
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        backgroundColor: const Color(0xFFA7DDE5),
        onDestinationSelected: (index) => setState(() => _tab = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.inventory_2_outlined), label: 'Shelf'),
          NavigationDestination(icon: Icon(Icons.kitchen), label: 'Fridge'),
          NavigationDestination(icon: Icon(Icons.notifications_outlined), label: 'Reminders'),
        ],
      ),
    );
  }
}
