import 'package:flutter/material.dart';
import 'package:food/cart_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  final List<Map<String, String>> categories = [
    {"name": "All", "icon": "10.png"},
    {"name": "Salad", "icon": "csal1.png"},
    {"name": "Pizza", "icon": "51.png"},
    {"name": "Burger", "icon": "2.png"},
    {"name": "Sushi", "icon": "13.png"},
    {"name": "Pasta", "icon": "11.png"},
  ];

  final List<Map<String, String>> allFoods = [
    {
      "category": "Salad",
      "image": "gsal.png",
      "title": "Green Salad",
      "subtitle": "Lettuce, Tomato, Cucumber",
      "price": "₹149"
    },
    {
      "category": "Salad",
      "image": "csal1.png",
      "title": "Caesar Salad",
      "subtitle": "Croutons, Romaine, Cheese",
      "price": "₹199"
    },
    {
      "category": "Pizza",
      "image": "7.png",
      "title": "Margherita Pizza",
      "subtitle": "Cheese, Basil, Sauce",
      "price": "₹249"
    },
    {
      "category": "Pizza",
      "image": "6.png",
      "title": "Veggie Pizza",
      "subtitle": "Onion, Capsicum, Cheese",
      "price": "₹299"
    },
    {
      "category": "Burger",
      "image": "3.png",
      "title": "Veg Burger",
      "subtitle": "Cheese, Tomato, Patty",
      "price": "₹249"
    },
    {
      "category": "Burger",
      "image": "2.png",
      "title": "Double Patty Chicken Burger",
      "subtitle": "Cheese, Tomato, Patty x2",
      "price": "₹349"
    },
    {
      "category": "Sushi",
      "image": "14.png",
      "title": "California Roll",
      "subtitle": "Crab, Avocado, Rice",
      "price": "₹699"
    },
    {
      "category": "Sushi",
      "image": "16.png",
      "title": "Spicy Prawn Tempura Roll",
      "subtitle": "Prawn,Spicy Mayo, Rice",
      "price": "₹799"
    },
    {
      "category": "Pasta",
      "image": "9.png",
      "title": "Spaghetti Bolognese",
      "subtitle": "Pasta, Meat Sauce",
      "price": "₹449"
    },
    {
      "category": "Pasta",
      "image": "12.png",
      "title": "Pesto Pasta",
      "subtitle": "Pasta, Basil, Cheese",
      "price": "₹399"
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredFoods = allFoods.where((food) {
      final matchesCategory =
          selectedCategory == 'All' || food['category'] == selectedCategory;
      final matchesSearch =
          food['title']!.toLowerCase().contains(searchQuery.toLowerCase());
      return searchQuery.isEmpty ? matchesCategory : matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Colors.deepPurple),
        title: const Text('Foodie', style: TextStyle(color: Colors.deepPurple)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('profile3.png'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What do you want to eat today?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for food',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category['name'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category['name']!;
                        searchQuery = '';
                        _searchController.clear();
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.deepOrange : Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: isSelected
                              ? Colors.deepOrange
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(category['icon']!, height: 30, width: 30),
                          const SizedBox(height: 4),
                          Text(
                            category['name']!,
                            style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black87),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              searchQuery.isNotEmpty
                  ? 'Search Results'
                  : '$selectedCategory Items',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filteredFoods.isEmpty
                  ? const Center(
                      child: Text('No results found',
                          style: TextStyle(fontSize: 16, color: Colors.grey)))
                  : ListView.builder(
                      itemCount: filteredFoods.length,
                      itemBuilder: (context, index) {
                        final food = filteredFoods[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: buildFoodCard(
                            food['image']!,
                            food['title']!,
                            food['subtitle']!,
                            food['price']!,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFoodCard(
      String imagePath, String title, String subtitle, String price) {
    final priceValue =
        double.tryParse(price.replaceAll(RegExp(r'\D'), '')) ?? 0;
    final item = CartItem(
      title: title,
      subtitle: subtitle,
      image: imagePath,
      price: priceValue,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Image.asset(imagePath, width: 80, height: 80, fit: BoxFit.contain),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Text(price,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                CartModel.addItem(item);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Item added to cart")),
                );
              },
              child: const Icon(Icons.add_circle, color: Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}
