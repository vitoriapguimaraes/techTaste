import 'package:flutter/material.dart';
import 'package:tech_taste/model/dish.dart';
import 'package:tech_taste/ui/_core/app_colors.dart';
import 'package:tech_taste/ui/_core/app_text_styles.dart';
import 'package:tech_taste/ui/_core/bag_provider.dart';
import 'package:tech_taste/ui/_core/widgets/web_constrained_box.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});
    BagProvider bagProvider = Provider.of<BagProvider>(context);
    final itemsMap = bagProvider.getMapByAmount();
    final isEmpty = itemsMap.isEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
        actions: [
          if (!isEmpty)
            TextButton(
              onPressed: () {
                bagProvider.clearBag();
              },
              child: Text("Limpar", style: TextStyle(color: AppColors.mainColor)),
            ),
        ],
      ),
      body: WebConstrainedBox(
        child: isEmpty
            ? _EmptyCart()
            : Column(
                children: [
                  // Lista de itens
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16.0),
                      itemCount: itemsMap.keys.length,
                      itemBuilder: (context, index) {
                        Dish dish = itemsMap.keys.toList()[index];
                        int quantity = itemsMap[dish]!;
                        return _CartItem(dish: dish, quantity: quantity);
                      },
                    ),
                  ),
                  
                  // Rodapé com total
                  _CheckoutFooter(bagProvider: bagProvider),
                ],
              ),
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 100,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 16.0),
          Text(
            "Seu carrinho está vazio",
            style: AppTextStyles.h3,
          ),
          SizedBox(height: 8.0),
          Text(
            "Adicione itens para começar seu pedido",
            style: AppTextStyles.bodySecondary,
          ),
        ],
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  final Dish dish;
  final int quantity;

  const _CartItem({required this.dish, required this.quantity});

  @override
  Widget build(BuildContext context) {
    final bagProvider = Provider.of<BagProvider>(context, listen: false);

    return Card(
      margin: EdgeInsets.only(bottom: 12.0),
      elevation: 2.0,
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
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 70,
                    height: 70,
                    color: AppColors.lightBackgroundColor,
                    child: Icon(Icons.restaurant, color: AppColors.textSecondary),
                  );
                },
              ),
            ),
            
            // Informações
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.0,
                children: [
                  Text(
                    dish.name,
                    style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "R\$ ${dish.price.toStringAsFixed(2)}",
                    style: AppTextStyles.price.copyWith(fontSize: 15.0),
                  ),
                ],
              ),
            ),
            
            // Controles de quantidade
            Container(
              decoration: BoxDecoration(
                color: AppColors.lightBackgroundColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      bagProvider.removeDish(dish);
                    },
                    icon: Icon(Icons.remove, size: 20.0),
                    padding: EdgeInsets.all(8.0),
                    constraints: BoxConstraints(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      quantity.toString(),
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      bagProvider.addAllDishes([dish]);
                    },
                    icon: Icon(Icons.add, size: 20.0),
                    padding: EdgeInsets.all(8.0),
                    constraints: BoxConstraints(),
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

class _CheckoutFooter extends StatelessWidget {
  final BagProvider bagProvider;

  const _CheckoutFooter({required this.bagProvider});

  @override
  Widget build(BuildContext context) {
    final subtotal = bagProvider.totalPrice;
    final deliveryFee = 5.0;
    final total = subtotal + deliveryFee;

    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          spacing: 12.0,
          children: [
            // Subtotal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Subtotal", style: AppTextStyles.body),
                Text(
                  "R\$ ${subtotal.toStringAsFixed(2)}",
                  style: AppTextStyles.body,
                ),
              ],
            ),
            
            // Taxa de entrega
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Taxa de entrega", style: AppTextStyles.body),
                Text(
                  "R\$ ${deliveryFee.toStringAsFixed(2)}",
                  style: AppTextStyles.body,
                ),
              ],
            ),
            
            Divider(color: AppColors.dividerColor),
            
            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: AppTextStyles.h3),
                Text(
                  "R\$ ${total.toStringAsFixed(2)}",
                  style: AppTextStyles.h3.copyWith(color: AppColors.mainColor),
                ),
              ],
            ),
            
            SizedBox(height: 8.0),
            
            // Botão finalizar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Pedido Confirmado! 🎉"),
                      content: Text(
                        "Seu pedido foi realizado com sucesso!\n\nTotal: R\$ ${total.toStringAsFixed(2)}",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            bagProvider.clearBag();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Text(
                  "Finalizar Pedido",
                  style: AppTextStyles.button.copyWith(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
