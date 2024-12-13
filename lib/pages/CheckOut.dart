import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final List<Map<String, dynamic>> _items = [
    {
      'imageUrl': 'https://via.placeholder.com/100', 
      'name': 'Double Burger',
      'description': 'Egg - Salad',
      'price': 18.75,
      'quantity': 1,
    },
    {
      'imageUrl': 'https://via.placeholder.com/100',
      'name': 'Mix Salad',
      'description': 'Egg - Salad',
      'price': 5.50,
      'quantity': 1,
    },
    {
      'imageUrl': 'https://via.placeholder.com/100',
      'name': 'Fish Salad',
      'description': 'Egg - Salad',
      'price': 12.50,
      'quantity': 1,
    },
    {
      'imageUrl': 'https://via.placeholder.com/100',
      'name': 'Cheese Pizza',
      'description': 'Egg - Salad',
      'price': 22.50,
      'quantity': 1,
    },
  ];

  double _deliveryFee = 5.0;
  double _discount = 5.50;

  double get _totalPrice {
    double total = _items.fold(
      0,
          (sum, item) => sum + (item['price'] * item['quantity']),
    );
    return total - _discount + _deliveryFee;
  }

  void _updateQuantity(int index, int change) {
    setState(() {
      _items[index]['quantity'] += change;
      if (_items[index]['quantity'] < 1) {
        _items[index]['quantity'] = 1; // Ensure quantity is at least 1
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return CheckoutItem(
                  imageUrl: item['imageUrl'],
                  name: item['name'],
                  description: item['description'],
                  price: item['price'],
                  quantity: item['quantity'],
                  onAdd: () => _updateQuantity(index, 1),
                  onRemove: () => _updateQuantity(index, -1),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount', style: TextStyle(color: Colors.grey)),
                    Text('\$$_discount', style: TextStyle(color: Colors.black)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery Fee', style: TextStyle(color: Colors.grey)),
                    Text('\$$_deliveryFee', style: TextStyle(color: Colors.black)),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      '\$${_totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.orange),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle checkout
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Check Out'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Cart tab selected
        onTap: (index) {
          // Handle navigation
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
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

class CheckoutItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CheckoutItem({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(description, style: TextStyle(color: Colors.grey)),
                  Text(
                    '\$${(price * quantity).toStringAsFixed(2)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.orange),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove, color: Colors.orange),
                  onPressed: onRemove,
                ),
                Text(
                  '$quantity',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.orange),
                  onPressed: onAdd,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
