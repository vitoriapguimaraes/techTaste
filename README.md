# Tech Taste

> Aplicativo mobile desenvolvido em Flutter para facilitar a experiência de delivery de comida, permitindo aos usuários explorar restaurantes, selecionar pratos do cardápio e realizar pedidos de forma intuitiva.  
> Desenvolvido na plataforma FireStudio Google.

![Demonstração do sistema](https://github.com/vitoriapguimaraes/techTaste/blob/main/demo/navigation.gif)

## Funcionalidades Principais

- **Tela de Splash** com animação de abertura
- **Tela Inicial** com categorias e lista de restaurantes
- **Tela de Restaurante** exibindo cardápio completo e opção de adicionar pratos ao carrinho
- **Tela de Checkout** mostrando todos os pratos selecionados
- **Navegação intuitiva** entre telas com transições suaves
- **Carrinho de compras** com gerenciamento de estado em tempo real

## Tecnologias Utilizadas

- **Flutter** - Framework multiplataforma para desenvolvimento mobile
- **Dart** - Linguagem de programação
- **Provider** - Gerenciamento de estado
- **Badges** - Componentes visuais para indicadores

## Arquitetura

O projeto segue uma arquitetura organizada e escalável:

- **Model**: Classes de dados (`Restaurant`, `Dish`)
- **Data**: Providers e carregamento de dados via JSON
- **UI**: Interface do usuário organizada por telas
  - `_core`: Tema, cores e providers compartilhados
  - `splash`: Tela de abertura
  - `home`: Tela inicial com categorias e restaurantes
  - `restaurant`: Detalhes do restaurante e cardápio
  - `checkout`: Finalização do pedido

O gerenciamento de estado é feito com **Provider**, permitindo que o carrinho de compras seja compartilhado entre as telas de forma reativa.

## Documentação

📚 **Documentação completa disponível:**

- **[Documentação Técnica](DOCUMENTACAO_TECNICA.md)** - Estrutura de dados, fluxos de navegação, arquitetura de componentes e diagramas
- **[Guia de Desenvolvimento](GUIA_DESENVOLVIMENTO.md)** - Exemplos práticos e referência rápida para desenvolvedores
- **[Como Visualizar o App](COMO_VISUALIZAR.md)** - Instruções para rodar o projeto sem Flutter instalado

## Como Executar

1. Clone o repositório:

   ```bash
   git clone https://github.com/vitoriapguimaraes/techTaste.git
   ```

2. Navegue até o diretório do projeto:

   ```bash
   cd Flutter-TechTaste
   ```

3. Instale as dependências:

   ```bash
   flutter pub get
   ```

4. Conecte um dispositivo Android ou iOS, ou inicie um emulador.

5. Execute o aplicativo:
   ```bash
   flutter run
   ```

## Como Usar

1. Abra o aplicativo Tech Taste no seu dispositivo
2. Aguarde a tela de splash inicial
3. Explore as categorias de restaurantes e escolha um restaurante
4. Navegue pelo cardápio, selecione os pratos desejados e adicione-os ao carrinho
5. Revise seu pedido e finalize a compra na tela de checkout

## Estrutura de Diretórios

```
/techTaste
├── lib/
│   ├── data/           # Dados mockados e providers
│   │   ├── categories_data.dart
│   │   └── restaurant_data.dart
│   ├── model/          # Modelos de dados
│   │   ├── dish.dart
│   │   └── restaurant.dart
│   ├── ui/             # Interface do usuário
│   │   ├── _core/      # Tema e providers compartilhados
│   │   ├── splash/     # Tela de splash
│   │   ├── home/       # Tela inicial
│   │   ├── restaurant/ # Tela de restaurante
│   │   └── checkout/   # Tela de checkout
│   └── main.dart       # Ponto de entrada do app
├── assets/             # Imagens e dados JSON
│   ├── banners/
│   ├── categories/
│   ├── dishes/
│   ├── restaurants/
│   └── data.json
├── demo/               # GIFs e screenshots
└── README.md
```

## Status

✅ Concluído

> Veja as [issues abertas](https://github.com/vitoriapguimaraes/techTaste/issues) para sugestões de melhorias e próximos passos.

## Aprendizados

Este projeto foi desenvolvido como parte de um curso de iniciação ao Flutter, onde foram aplicados conceitos importantes:

- Estruturação de projetos Flutter
- Gerenciamento de estado com Provider
- Navegação entre telas
- Carregamento de dados via JSON
- Componentização e reutilização de widgets
- Organização de código seguindo boas práticas

## Mais Sobre Mim

Acesse os arquivos disponíveis na [Pasta Documentos](https://github.com/vitoriapguimaraes/vitoriapguimaraes/tree/main/DOCUMENTOS) para mais informações sobre minhas qualificações e certificações.
