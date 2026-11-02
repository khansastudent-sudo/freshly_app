import 'package:flutter/material.dart';

class AddItemScreen extends StatefulWidget {
  final String initialStorage;
  const AddItemScreen({super.key, required this.initialStorage});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  late String _storage;
  DateTime _expiry = DateTime.now().add(const Duration(days: 7));

  @override
  void initState() {
    super.initState();
    _storage = widget.initialStorage;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _expiry,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (date != null) setState(() => _expiry = date);
  }

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an item name')),
      );
    } else {
      Navigator.pop(context, <String, dynamic>{
        'name': name,
        'storage': _storage,
        'expiry': _expiry,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Item 🌸')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              color: const Color(0xFFDCE9D3),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Add New Item',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold,
                            color: Color(0xFF355D42))),
                    const SizedBox(height: 22),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Food name', filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: _storage,
                      decoration: const InputDecoration(
                        labelText: 'Storage', filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'Shelf', child: Text('Shelf')),
                        DropdownMenuItem(value: 'Fridge', child: Text('Fridge')),
                      ],
                      onChanged: (value) {
                        if (value != null) setState(() => _storage = value);
                      },
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_month),
                      label: Text('Expiry: ${_expiry.day}/${_expiry.month}/${_expiry.year}'),
                    ),
                    const SizedBox(height: 18),
                    FilledButton(onPressed: _save, child: const Text('ADD ITEM')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
