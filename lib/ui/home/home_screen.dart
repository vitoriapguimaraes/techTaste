import 'package:flutter/material.dart';
import 'package:tech_taste/data/categories_data.dart';
import 'package:tech_taste/data/restaurant_data.dart';
import 'package:tech_taste/model/restaurant.dart';
import 'package:tech_taste/ui/_core/app_colors.dart';
import 'package:tech_taste/ui/_core/app_text_styles.dart';
import 'package:tech_taste/ui/_core/widgets/appbar.dart';
import 'package:tech_taste/ui/home/widgets/category_widget.dart';
import 'package:tech_taste/ui/home/widgets/restaurant_widget.dart';
import 'package:provider/provider.dart';
import 'package:tech_taste/ui/_core/widgets/web_constrained_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  String? selectedCategory;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Restaurant> getFilteredRestaurants(RestaurantData restaurantData) {
    var filtered = restaurantData.listRestaurant;

    // Filtro por busca
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((restaurant) {
        // Busca no nome do restaurante
        bool matchesName = restaurant.name
            .toLowerCase()
            .contains(searchQuery.toLowerCase());

        // Busca nos pratos
        bool matchesDish = restaurant.dishes.any((dish) =>
            dish.name.toLowerCase().contains(searchQuery.toLowerCase()));

        return matchesName || matchesDish;
      }).toList();
    }

    // Filtro por categoria
    if (selectedCategory != null) {
      filtered = filtered.where((restaurant) {
        return restaurant.categories.contains(selectedCategory);
      }).toList();
    }

    return filtered;
  }

  void clearFilters() {
    setState(() {
      searchQuery = "";
      selectedCategory = null;
      _searchController.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    final filteredRestaurants = getFilteredRestaurants(restaurantData);
    final hasActiveFilters = searchQuery.isNotEmpty || selectedCategory != null;

    return Scaffold(
      drawer: Drawer(),
      appBar: getAppBar(context: context),
      body: WebConstrainedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 24.0,
              // ... rest of the build method unchanged
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Center(child: Image.asset('assets/logo.png', width: 147)),
                
                // Boas-vindas
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.0,
                  children: [
                    Text("Olá! 👋", style: AppTextStyles.h1),
                    Text(
                      "O que você gostaria de comer hoje?",
                      style: AppTextStyles.bodySecondary,
                    ),
                  ],
                ),
                
                // Campo de busca
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Buscar restaurantes ou pratos...",
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                searchQuery = "";
                                _searchController.clear();
                              });
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Color(0xFF343541),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 16.0,
                    ),
                  ),
                ),
                
                // Categorias
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16.0,
                  children: [
                    Text("Escolha por categoria", style: AppTextStyles.h3),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 12.0,
                        children: List.generate(
                          CategoriesData.listCategories.length,
                          (index) {
                            final category = CategoriesData.listCategories[index];
                            return CategoryWidget(
                              category: category,
                              isSelected: selectedCategory == category,
                              onTap: () {
                                setState(() {
                                  if (selectedCategory == category) {
                                    selectedCategory = null;
                                  } else {
                                    selectedCategory = category;
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                
                // Banner promocional
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset("assets/banners/banner_promo.png"),
                ),
                
                // Indicador de filtros ativos
                if (hasActiveFilters)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${filteredRestaurants.length} ${filteredRestaurants.length == 1 ? 'restaurante encontrado' : 'restaurantes encontrados'}",
                        style: AppTextStyles.bodySecondary,
                      ),
                      TextButton.icon(
                        onPressed: clearFilters,
                        icon: Icon(Icons.clear, size: 16.0),
                        label: Text("Limpar filtros"),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                
                // Restaurantes
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16.0,
                  children: [
                    if (!hasActiveFilters)
                      Text("Bem avaliados ⭐", style: AppTextStyles.h3),
                    
                    // Lista de restaurantes ou estado vazio
                    if (filteredRestaurants.isEmpty)
                      _EmptySearchResults(onClearFilters: clearFilters)
                    else
                      Column(
                        spacing: 12.0,
                        children: List.generate(
                          filteredRestaurants.length,
                          (index) {
                            Restaurant restaurant = filteredRestaurants[index];
                            return RestaurantWidget(restaurant: restaurant);
                          },
                        ),
                      ),
                  ],
                ),
                
                // Footer
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Center(
                    child: Text(
                      "Desenvolvido por github.com/vitoriapguimaraes",
                      style: AppTextStyles.caption.copyWith(fontSize: 11.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptySearchResults extends StatelessWidget {
  final VoidCallback onClearFilters;

  const _EmptySearchResults({required this.onClearFilters});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 48.0),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 16.0),
            Text(
              "Nenhum resultado encontrado",
              style: AppTextStyles.h3,
            ),
            SizedBox(height: 8.0),
            Text(
              "Tente buscar por outro termo ou categoria",
              style: AppTextStyles.bodySecondary,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.0),
            ElevatedButton.icon(
              onPressed: onClearFilters,
              icon: Icon(Icons.clear),
              label: Text("Limpar filtros"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
