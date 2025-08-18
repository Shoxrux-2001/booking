import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/features/home/viewmodel/food_viewmodel.dart';
import 'package:restaurant/gen/assets.gen.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/history');
        break;
      case 2:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.foods.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            viewModel.fetchFoods();
          });
        }
        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(child: Image.asset(Assets.images.biryani)),
              ),
            ],
            leading: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Icon(Icons.menu),
            ),
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.push(
                      '/map',
                      extra: {
                        'latitude': 22.3569,
                        'longitude': 91.7832,
                        'title': 'Agrabad 435, Chittagong',
                      },
                    );
                  },
                  icon: const Icon(Icons.location_on, color: Colors.green),
                ),
                const Text(
                  "Agrabad 435, Chittagong",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : viewModel.error != null
              ? Center(child: Text(viewModel.error!))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 5,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter your text",
                            prefixIcon: const Icon(Icons.search),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 140,
                        child: PageView(
                          children: [_buildBanner(), _buildBanner()],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Today New Arrivals",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  "Best of the day 5-7 min",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: viewModel.foods.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final food = viewModel.foods[index];
                            return GestureDetector(
                              onTap: () {
                                context.push(
                                  '/map',
                                  extra: {
                                    'latitude': food.latitude ?? 22.3569,
                                    'longitude': food.longitude ?? 91.7832,
                                    'title': food.name,
                                  },
                                );
                              },
                              child: _buildFoodCard(
                                imagePath: food.image,
                                title: food.name,
                                location: food.location,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              "Popular Restaurants",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              "View All",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: viewModel.foods.length,
                          itemBuilder: (context, index) {
                            final food = viewModel.foods[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    food.image,
                                    width: 100,
                                    height: 100,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          food.name,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: Colors.green,
                                            ),
                                            Expanded(
                                              child: Text(food.location),
                                            ),
                                            const SizedBox(width: 10),
                                            GestureDetector(
                                              onTap: () {
                                                context.go("/book");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5,
                                                  ),
                                                  child: Text(
                                                    "Book",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.green,
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }

  Widget _buildBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.fastfood),
            alignment: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(40),
          gradient: LinearGradient(
            colors: [Color(0xFFFF9F06), Color(0xFFFFE1B4)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Image.asset(Assets.images.fastfood)],
          ),
        ),
      ),
    );
  }

  Widget _buildFoodCard({
    required String imagePath,
    required String title,
    required String location,
  }) {
    return SizedBox(
      width: 150,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                imagePath,
                width: 150,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.green, size: 16),
                  Expanded(
                    child: Text(
                      location,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
