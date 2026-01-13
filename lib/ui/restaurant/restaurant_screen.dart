import 'package:flutter/material.dart';
import 'package:tech_taste/model/dish.dart';
import 'package:tech_taste/model/restaurant.dart';
import 'package:tech_taste/ui/_core/app_colors.dart';
import 'package:tech_taste/ui/_core/app_text_styles.dart';
import 'package:tech_taste/ui/_core/bag_provider.dart';
import 'package:tech_taste/ui/_core/widgets/appbar.dart';
import 'package:provider/provider.dart';
import 'package:tech_taste/ui/_core/widgets/web_constrained_box.dart';

class RestaurantScreen extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantScreen({super.key, required this.restaurant});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: restaurant.name),
      body: WebConstrainedBox(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header do restaurante
              Container(
                padding: EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset(
                        'assets/${restaurant.imagePath}',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      restaurant.description,
                      style: AppTextStyles.bodySecondary,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 16.0,
                      children: [
                        // Avaliação
                        Row(
                          spacing: 4.0,
                          children: [
                            Icon(Icons.star, color: AppColors.mainColor, size: 20.0),
                            Text(
                              restaurant.stars.toString(),
                              style: AppTextStyles.body.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        // Distância
                        Row(
                          spacing: 4.0,
                          children: [
                            Icon(Icons.location_on, color: AppColors.textSecondary, size: 20.0),
                            Text(
                              "${restaurant.distance}km",
                              style: AppTextStyles.body,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Cardápio
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16.0,
                  children: [
                    Text("Cardápio 🍽️", style: AppTextStyles.h2),
                    
                    // Lista de pratos
                    ...List.generate(restaurant.dishes.length, (index) {
                      Dish dish = restaurant.dishes[index];
                      return _DishCard(dish: dish);
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DishCard extends StatelessWidget {
  final Dish dish;
  const _DishCard({required this.dish});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: AppColors.cardColor,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          spacing: 12.0,
          children: [
            // Imagem do prato (CORRIGIDO!)
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                'assets/${dish.imagePath}',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: AppColors.lightBackgroundColor,
                    child: Icon(Icons.restaurant, color: AppColors.textSecondary),
                  );
                },
              ),
            ),
            
            // Informações do prato
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6.0,
                children: [
                  Text(
                    dish.name,
                    style: AppTextStyles.h3.copyWith(fontSize: 16.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    dish.description,
                    style: AppTextStyles.bodySecondary.copyWith(fontSize: 12.0),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "R\$ ${dish.price.toStringAsFixed(2)}",
                    style: AppTextStyles.price.copyWith(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            
            // Botão adicionar
            Material(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(12.0),
              child: InkWell(
                onTap: () {
                  context.read<BagProvider>().addAllDishes([dish]);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${dish.name} adicionado ao carrinho!"),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: AppColors.successColor,
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
