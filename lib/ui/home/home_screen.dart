import 'package:flutter/material.dart';
import 'package:tech_taste/data/categories_data.dart';
import 'package:tech_taste/data/restaurant_data.dart';
import 'package:tech_taste/model/restaurant.dart';
import 'package:tech_taste/ui/_core/app_text_styles.dart';
import 'package:tech_taste/ui/_core/widgets/appbar.dart';
import 'package:tech_taste/ui/home/widgets/category_widget.dart';
import 'package:tech_taste/ui/home/widgets/restaurant_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RestaurantData restaurantData = Provider.of<RestaurantData>(context);

    return Scaffold(
      drawer: Drawer(),
      appBar: getAppBar(context: context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 24.0,
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
                decoration: InputDecoration(
                  hintText: "Buscar restaurantes ou pratos...",
                  prefixIcon: Icon(Icons.search),
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
                          return CategoryWidget(
                            category: CategoriesData.listCategories[index],
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
              
              // Restaurantes
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16.0,
                children: [
                  Text("Bem avaliados ⭐", style: AppTextStyles.h3),
                  Column(
                    spacing: 12.0,
                    children: List.generate(
                      restaurantData.listRestaurant.length,
                      (index) {
                        Restaurant restaurant = restaurantData.listRestaurant[index];
                        return RestaurantWidget(restaurant: restaurant);
                      },
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}
