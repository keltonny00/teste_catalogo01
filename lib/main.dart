import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importe para abrir URLs

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Produtos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue, // Cor de fundo da AppBar
          foregroundColor: Colors.white, // Cor do texto e ícones na AppBar
        ),
      ),
      home: const ProductListScreen(),
    );
  }
}

// --- Modelo de Produto ---
class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final String externalBuyLink;
  final String category; // Adicionando categoria para filtragem

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.externalBuyLink,
    required this.category,
  });
}

// --- Dados de Exemplo ---
final List<Product> dummyProducts = [
  Product(
    id: 'p1',
    name: 'JBL Wave Flex 2',
    description: 'FA vida é curta demais para ser entediante O som de qualidade ficou mais fácil e divertido. Os fones de ouvido JBL Wave Flex 2 apresentam o empolgante som JBL Pure Bass, além da tecnologia Smart Ambient para que você decida quanto do mundo exterior deseja ouvir. Gerencie chamadas nítidas e claras no modo viva-voz com apenas um toque nos fones de ouvido. Use o aplicativo JBL Headphones para personalizar seu som e idioma de avisos de voz. Conecte-se perfeitamente com até 8 dispositivos Bluetooth® e alterne sem esforço entre si. Graças ao seu formato, o Wave Flex 2 se destaca por seu design ergonômico confortável. E com até 40 horas de reprodução, eles são um ótimo companheiro de som diário.',
    imageUrl: 'assets/imagens/fone.png', // Imagem placeholder
    price: 369.99,
    externalBuyLink: 'https://www.jbl.com.br/fones-de-ouvido/WAVE-FLEX-2.html', // Link de exemplo
    category: 'Eletrônicos',
  ),
  Product(
    id: 'p2',
    name: 'Smartwatch Bazik Prime W93 Pro Max',
    description: 'O Bazik Prime W93 Pro Max é um smartwatch premium com design sofisticado e tecnologia de ponta, ideal para quem busca conectividade, monitoramento avançado e um estilo de vida dinâmico. Equipado com uma tela AMOLED de alta resolução, GPS integrado e assistente de voz, ele combina funcionalidade e personalização, garantindo uma experiência completa.',
    imageUrl: 'assets/imagens/smartwatch.png',
    price: 349.90,
    externalBuyLink: 'https://lojabasike.com.br/collections/smartwatches/products/smartwatch-bazik-prime-w93-pro-max-46mm-tela-amoled-bluetooth-gps',
    category: 'Eletrônicos',
  ),
  Product(
    id: 'p3',
    name: 'Notebook Gamer G15',
    description: 'Notebook gamer de 15" feito para quem quer estilo e desempenho. Com os processadores Intel® Core™ mais recentes, placas de vídeo NVIDIA® GeForce RTX™ e teclado em português.',
    imageUrl: 'assets/imagens/notebook.png',
    price: 4899.00,
    externalBuyLink: 'https://www.dell.com/pt-br/shop/cty/pdp/spd/g-series-15-5530-laptop/g5530u25001w?tfcid=31768715&gacd=9657105-15015-5761040-275878141-0&dgc=ST&cid=71700000115426311&gclsrc=aw.ds&gad_source=1&gad_campaignid=20672029416&gclid=Cj0KCQjwgIXCBhDBARIsAELC9ZiASSSzeqfl2AbktSantBxplKzPTe3we8W9k-ihR_SH1adBOo3d5m0aAhfbEALw_wcB#customization-anchor',
    category: 'Informática',
  ),
  Product(
    id: 'p4',
    name: 'Mouse Sem Fio Vertical Ortopédico Power Fit Vinik',
    description: 'Mouse confortável para uso prolongado, com conexão sem fio e alta precisão.',
    imageUrl: 'assets/imagens/mouse.png',
    price: 82.99,
    externalBuyLink: 'https://www.kabum.com.br/produto/241097/mouse-sem-fio-vertical-ortopedico-power-fit-vinik-1600-dpi-recarregavel-usb-preto-pm300?utm_id=22427039975&gad_source=1&gad_campaignid=22427039975&gclid=Cj0KCQjwgIXCBhDBARIsAELC9Zgn4YmDn4LduFbPL3Y3c_wnck8nmrOyTIRuxr87KVob5C8cgdysdjkaAogxEALw_wcB',
    category: 'Informática',
  ),
  Product(
    id: 'p5',
    name: 'Teclado Mecânico Gamer HyperX Alloy MKW100',
    description: 'O HyperX Alloy MKW100 é um teclado mecânico de custo acessível com um tamanho grande ótimo para jogos, trabalho e escola. Personalize seu teclado com iluminação RGB dinâmica e efeitos que você pode configurar facilmente com o Software HyperX NGENUITY. O Alloy MKW100 tem uma estrutura durável de alumínio escovado e conta com uma responsividade confiável graças aos switches mecânicos à prova de poeira[2] com classificação de até 50 milhões de toques. Jogue confortavelmente com o descanso para pulso incluído ou remova-o para adequá-lo a suas necessidades.',
    imageUrl: 'assets/imagens/teclado.png',
    price: 249.99,
    externalBuyLink: 'https://www.kabum.com.br/produto/371586/teclado-mecanico-gamer-hyperx-alloy-mkw100-rgb-switch-red-full-size-us-preto-4p5e1aa-aba',
    category: 'Informática',
  ),
];

// --- Tela de Listagem de Produtos ---
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String selectedCategory = 'Todos';

  List<Product> get _filteredProducts {
    if (selectedCategory == 'Todos') {
      return dummyProducts;
    } else {
      return dummyProducts.where((product) => product.category == selectedCategory).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Produtos'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Categorias',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Todos'),
              selected: selectedCategory == 'Todos', // Destaca o item selecionado
              onTap: () {
                setState(() {
                  selectedCategory = 'Todos';
                });
                Navigator.pop(context); // Fecha o drawer
              },
            ),
            ListTile(
              title: const Text('Eletrônicos'),
              selected: selectedCategory == 'Eletrônicos',
              onTap: () {
                setState(() {
                  selectedCategory = 'Eletrônicos';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Informática'),
              selected: selectedCategory == 'Informática',
              onTap: () {
                setState(() {
                  selectedCategory = 'Informática';
                });
                Navigator.pop(context);
              },
            ),
            const Divider(), // Linha divisória
            ListTile(
              title: const Text('Lojas Físicas'),
              leading: const Icon(Icons.location_on), // Ícone para "Lojas Físicas"
              onTap: () {
                Navigator.pop(context); // Fecha o drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StoreMapScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: _filteredProducts.isEmpty
          ? const Center(
              child: Text(
                'Nenhum produto encontrado nesta categoria.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 itens por linha
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.7, // Ajuste para melhor visualização do card
              ),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                return ProductGridItem(product: product);
              },
            ),
    );
  }
}

// --- Item de Produto no Grid ---
class ProductGridItem extends StatelessWidget {
  final Product product;

  const ProductGridItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), // Bordas arredondadas
      clipBehavior: Clip.antiAlias, // Garante que a imagem respeite as bordas
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Hero( // Animação de transição da imagem
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.error, color: Colors.red));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'R\$ ${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: product),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Cor do botão
                  foregroundColor: Colors.white, // Cor do texto do botão
                ),
                child: const Text('Ver Detalhes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Tela de Detalhes do Produto ---
class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  // CORREÇÃO: Adicione BuildContext context como parâmetro aqui
  Future<void> _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Usamos o context passado como parâmetro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível abrir o link: $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Hero( // Animação de transição da imagem
                tag: product.id,
                child: ClipRRect( // Para aplicar bordas arredondadas à imagem grande
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    product.imageUrl,
                    height: 250,
                    width: double.infinity, // Preenche a largura disponível
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox( // Garante que o CircularProgressIndicator tenha um tamanho fixo
                        height: 250,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 250,
                        child: Center(child: Icon(Icons.broken_image, size: 100, color: Colors.grey)),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'R\$ ${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.green[800],
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15.0),
            const Text(
              'Descrição do Produto:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                // CORREÇÃO: Chame o método passando o context
                onPressed: () => _launchURL(context, product.externalBuyLink),
                icon: const Icon(Icons.shopping_cart),
                label: const Text(
                  'Comprar Agora',
                  style: TextStyle(fontSize: 18.0),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nenhum detalhe adicional disponível no momento.')),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  side: const BorderSide(color: Colors.blue),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                child: const Text(
                  'Ver Mais Detalhes',
                  style: TextStyle(fontSize: 18.0, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Tela de Mapas de Lojas Físicas ---
class StoreMapScreen extends StatelessWidget {
  const StoreMapScreen({super.key});

  // CORREÇÃO: Adicione BuildContext context como parâmetro aqui
  Future<void> _launchMapsUrl(BuildContext context) async {
    // Coordenadas de um local em Igarassu, Pernambuco (exemplo)
    const String latitude = '-7.8398';
    const String longitude = '-34.9080';
    // String para abrir o Google Maps com coordenadas.
    // Lembre-se que "q=latitude,longitude" é para pesquisar um local.
    // Para um ponto específico, "ll=latitude,longitude" é mais comum, mas q é mais robusto.
    final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';


    final Uri uri = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Usamos o context passado como parâmetro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o aplicativo de mapas.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lojas Físicas'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Localização das Nossas Lojas',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Imagem estática do mapa para visualização rápida.
              // As coordenadas são um exemplo de Igarassu, Pernambuco.
              // NOTA: Para usar a API Static Maps, você precisa de uma chave API do Google Maps.
              // Substitua 'YOUR_Maps_STATIC_API_KEY' pela sua chave.
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  // Use as coordenadas de Igarassu, Pernambuco
                  'https://maps.googleapis.com/maps/api/staticmap?center=-7.8398,-34.9080&zoom=14&size=400x250&markers=color:red%7Clabel:L%7C-7.8398,-34.9080&key=YOUR_Maps_STATIC_API_KEY', // <<< SUBSTITUA PELA SUA CHAVE API AQUI
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 250,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map_outlined, size: 80, color: Colors.grey),
                        Text('Mapa indisponível', style: TextStyle(color: Colors.grey)),
                        Text('Verifique sua chave de API ou conexão.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                // CORREÇÃO: Chame o método passando o context
                onPressed: () => _launchMapsUrl(context),
                icon: const Icon(Icons.location_on),
                label: const Text('Abrir no Google Maps'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Clique no botão acima para abrir a localização de nossas lojas no seu aplicativo de mapas favorito.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}