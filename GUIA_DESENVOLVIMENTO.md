# Tech Taste - Guia Rápido de Desenvolvimento

## 🚀 Início Rápido

Este guia fornece exemplos práticos de como trabalhar com o código do Tech Taste.

---

## 📦 Como Adicionar um Novo Restaurante

### 1. Adicione os dados no `assets/data.json`

```json
{
  "id": "novo-uuid-aqui",
  "imagePath": "restaurants/novo-restaurante.png",
  "name": "Nome do Novo Restaurante",
  "description": "Descrição curta e atrativa",
  "stars": 4.5,
  "distance": 3,
  "categories": ["Principais", "Bebidas"],
  "dishes": [
    {
      "id": "uuid-do-prato",
      "imagePath": "dishes/novo-restaurante/prato1.png",
      "name": "Nome do Prato",
      "description": "Descrição detalhada do prato",
      "price": 25
    }
  ]
}
```

### 2. Adicione as imagens

- Imagem do restaurante: `assets/restaurants/novo-restaurante.png`
- Imagens dos pratos: `assets/dishes/novo-restaurante/prato1.png`

### 3. Reinicie o app

O `RestaurantData` carregará automaticamente os novos dados.

---

## 🍽️ Como Adicionar um Novo Prato

Adicione dentro do array `dishes` de um restaurante existente:

```json
{
  "id": "uuid-unico",
  "imagePath": "dishes/restaurante-existente/novo-prato.png",
  "name": "Novo Prato Delicioso",
  "description": "Descrição completa do prato",
  "price": 30
}
```

---

## 🎨 Como Modificar o Tema

Edite `lib/ui/_core/app_theme.dart`:

```dart
static ThemeData appTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: AppColors.background, // Cor de fundo
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.background,
    elevation: 0,
  ),
  // Adicione mais personalizações aqui
);
```

Cores disponíveis em `lib/ui/_core/app_colors.dart`.

---

## 🛒 Como Usar o BagProvider

### Adicionar item ao carrinho

```dart
// No widget
final bagProvider = Provider.of<BagProvider>(context, listen: false);

// Ao clicar no botão
onPressed: () {
  bagProvider.addDish(dish);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('${dish.name} adicionado!')),
  );
}
```

### Remover item do carrinho

```dart
onPressed: () {
  bagProvider.removeDish(dish);
}
```

### Obter total de itens

```dart
// Com listen: true para atualizar automaticamente
final bagProvider = Provider.of<BagProvider>(context);
int totalItems = bagProvider.totalItems;

// Usar no badge
Badge(
  label: Text('$totalItems'),
  child: Icon(Icons.shopping_bag),
)
```

### Obter valor total

```dart
final bagProvider = Provider.of<BagProvider>(context);
int total = bagProvider.totalPrice;

Text('Total: R\$ $total');
```

---

## 📱 Como Navegar Entre Telas

### De Home para Restaurant

```dart
// No RestaurantWidget
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RestaurantScreen(
        restaurant: restaurant, // Passa o objeto completo
      ),
    ),
  );
}
```

### De qualquer tela para Checkout

```dart
// Na CustomAppBar
onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CheckoutScreen(),
    ),
  );
}
```

### Voltar para tela anterior

```dart
onPressed: () {
  Navigator.pop(context);
}
```

---

## 🔍 Como Acessar a Lista de Restaurantes

### Em qualquer widget

```dart
// Com listen: true (atualiza automaticamente)
final restaurantData = Provider.of<RestaurantData>(context);
List<Restaurant> restaurants = restaurantData.listRestaurant;

// Com listen: false (não atualiza)
final restaurantData = Provider.of<RestaurantData>(context, listen: false);
```

### Filtrar restaurantes por categoria

```dart
List<Restaurant> filterByCategory(String category) {
  return restaurantData.listRestaurant.where((restaurant) {
    return restaurant.categories.contains(category);
  }).toList();
}
```

### Buscar restaurante por nome

```dart
Restaurant? findRestaurant(String name) {
  return restaurantData.listRestaurant.firstWhere(
    (restaurant) => restaurant.name.toLowerCase().contains(name.toLowerCase()),
    orElse: () => null,
  );
}
```

---

## 🎯 Exemplos de Widgets Personalizados

### Card de Prato

```dart
class DishCard extends StatelessWidget {
  final Dish dish;
  final VoidCallback onAdd;

  const DishCard({required this.dish, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(dish.imagePath),
          Text(dish.name),
          Text('R\$ ${dish.price}'),
          ElevatedButton(
            onPressed: onAdd,
            child: Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
```

### Badge de Carrinho Customizado

```dart
Consumer<BagProvider>(
  builder: (context, bagProvider, child) {
    return badges.Badge(
      showBadge: bagProvider.totalItems > 0,
      badgeContent: Text(
        '${bagProvider.totalItems}',
        style: TextStyle(color: Colors.white),
      ),
      child: IconButton(
        icon: Icon(Icons.shopping_bag),
        onPressed: () {
          // Navegar para checkout
        },
      ),
    );
  },
)
```

---

## 🐛 Debugging Comum

### Problema: Imagens não aparecem

**Solução:** Verifique se:

1. O caminho no JSON está correto
2. A imagem existe em `assets/`
3. O `pubspec.yaml` inclui o diretório:
   ```yaml
   assets:
     - assets/
     - assets/restaurants/
     - assets/dishes/
   ```

### Problema: Provider não atualiza UI

**Solução:** Use `listen: true` ou `Consumer`:

```dart
// Opção 1: listen: true
final bagProvider = Provider.of<BagProvider>(context, listen: true);

// Opção 2: Consumer
Consumer<BagProvider>(
  builder: (context, bagProvider, child) {
    return Text('${bagProvider.totalItems}');
  },
)
```

### Problema: JSON não carrega

**Solução:** Verifique:

1. Sintaxe JSON válida (use JSONLint)
2. Arquivo está em `assets/data.json`
3. `await restaurantData.getRestaurants()` foi chamado no `main()`

---

## 📊 Estrutura de Dados Resumida

```
Restaurant
├── id: String
├── name: String
├── description: String
├── imagePath: String
├── stars: double
├── distance: int
├── categories: List<String>
└── dishes: List<Dish>
    └── Dish
        ├── id: String
        ├── name: String
        ├── description: String
        ├── price: int
        └── imagePath: String
```

---

## 🔄 Ciclo de Vida do App

```
1. main() executa
   ↓
2. RestaurantData.getRestaurants() carrega JSON
   ↓
3. MultiProvider registra providers
   ↓
4. MyApp inicia
   ↓
5. SplashScreen exibe (3s)
   ↓
6. HomeScreen exibe lista de restaurantes
   ↓
7. Usuário navega e adiciona itens ao carrinho
   ↓
8. BagProvider notifica listeners
   ↓
9. UI atualiza automaticamente
```

---

## 💡 Dicas de Boas Práticas

1. **Sempre use `const` quando possível** para melhor performance
2. **Separe widgets grandes** em componentes menores
3. **Use `listen: false`** quando não precisa de atualizações automáticas
4. **Valide dados do JSON** antes de usar
5. **Adicione tratamento de erros** em operações assíncronas

---

## 📚 Recursos Adicionais

- [Documentação Técnica Completa](DOCUMENTACAO_TECNICA.md)
- [Como Visualizar o App](COMO_VISUALIZAR.md)
- [Flutter Provider Docs](https://pub.dev/packages/provider)
- [Flutter Navigation](https://docs.flutter.dev/cookbook/navigation)

---

**Última atualização:** Janeiro 2026
