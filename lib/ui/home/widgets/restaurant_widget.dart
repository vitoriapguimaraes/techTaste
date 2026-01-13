import 'package:flutter/material.dart';
import 'package:tech_taste/model/restaurant.dart';
import 'package:tech_taste/ui/_core/app_colors.dart';
import 'package:tech_taste/ui/_core/app_text_styles.dart';
import 'package:tech_taste/ui/restaurant/restaurant_screen.dart';

class RestaurantWidget extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: AppColors.cardColor,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return RestaurantScreen(restaurant: restaurant);
              },
            ),
          );
        },
        borderRadius: BorderRadius.circular(16.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            spacing: 16.0,
            children: [
              // Imagem do restaurante
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'assets/${restaurant.imagePath}',
                  width: 80.0,
                  height: 80.0,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Informações
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 6.0,
                  children: [
                    // Nome
                    Text(
                      restaurant.name,
                      style: AppTextStyles.h3.copyWith(fontSize: 17.0),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    // Descrição
                    Text(
                      restaurant.description,
                      style: AppTextStyles.bodySecondary.copyWith(fontSize: 13.0),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    // Avaliação e distância
                    Row(
                      children: [
                        // Estrelas
                        Row(
                          spacing: 2.0,
                          children: List.generate(
                            restaurant.stars.toInt(),
                            (index) => Icon(
                              Icons.star,
                              size: 16.0,
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          restaurant.stars.toString(),
                          style: AppTextStyles.caption.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        
                        SizedBox(width: 12.0),
                        
                        // Distância
                        Icon(
                          Icons.location_on,
                          size: 14.0,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 2.0),
                        Text(
                          "${restaurant.distance}km",
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Ícone de navegação
              Icon(
                Icons.arrow_forward_ios,
                size: 16.0,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
