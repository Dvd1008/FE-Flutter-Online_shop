import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductsProvider()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Online Shop',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.deepOrange),
        ),
        home: LoginScreen(),
        routes: {
          CartScreen.routeName: (ctx) => CartScreen(),
          AccountScreen.routeName: (ctx) => AccountScreen(),
        },
      ),
    );
  }
}

// Login Screen
class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => ShopScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 241, 239, 240), Color.fromARGB(255, 101, 178, 241)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to D-STORE',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 6, 5, 5),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Username'),
                        ),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _login(context),
                          child: Text('Login'), 
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color.fromARGB(255, 15, 14, 14),
                            backgroundColor: Color.fromARGB(255, 98, 128, 237),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('Sign Up'),
                          style: TextButton.styleFrom(
                            foregroundColor: Color.fromARGB(255, 55, 57, 169),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Product Model
class Product {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });
}

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Formal Shirt',
      price: 29.99,
      imageUrl: 'assets/images/Red-shirt.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Long Pants',
      price: 39.99,
      imageUrl: 'assets/images/Pants.jpeg',
    ),
    Product(
      id: 'p3',
      title: 'Shoes',
      price: 79.99,
      imageUrl: 'assets/images/Black-shoes.jpeg',
    ),
    Product(
      id: 'p4',
      title: 'Shorts Pants',
      price: 19.99,
      imageUrl: 'assets/images/Gray-shorts.jpeg',
    ),
    Product(
      id: 'p5',
      title: 'Hoodie',
      price: 29.99,
      imageUrl: 'assets/images/White-hoodie.jpeg',
    ),
    Product(
      id: 'p6',
      title: 'Hat',
      price: 14.99,
      imageUrl: 'assets/images/Pink-hat.jpeg',
    ),
    Product(
      id: 'p7',
      title: 'Socks',
      price: 4.99,
      imageUrl: 'assets/images/Black-shocks.jpeg',
    ),
    Product(
      id: 'p8',
      title: 'Jacket',
      price: 49.99,
      imageUrl: 'assets/images/Olive-jacket.jpg',
    ),
    Product(
      id: 'p9',
      title: 'Sweater',
      price: 24.99,
      imageUrl: 'assets/images/Sweater.jpg',
    ),
    Product(
      id: 'p10',
      title: 'Bag',
      price: 39.99,
      imageUrl: 'assets/images/Bag.jpeg',
    ),
    Product(
      id: 'p11',
      title: 'T-shirt',
      price: 9.99,
      imageUrl: 'assets/images/T-shirt.jpeg',
    ),
    Product(
      id: 'p12',
      title: 'Underwear',
      price: 2.99,
      imageUrl: 'assets/images/Undewear.jpeg',
    ),
    Product(
      id: 'p13',
      title: 'Slippers',
      price: 19.99,
      imageUrl: 'assets/images/Slippers.jpeg',
    ),
    Product(
      id: 'p14',
      title: 'Singlet Shirt',
      price: 5.99,
      imageUrl: 'assets/images/Singlet.jpeg',
    ),
    Product(
      id: 'p15',
      title: 'Varsity',
      price: 59.99,
      imageUrl: 'assets/images/Varsity.jpeg',
    ),
    Product(
      id: 'p16',
      title: 'Batik',
      price: 29.99,
      imageUrl: 'assets/images/Batik.jpeg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> searchItems(String query) {
    return _items.where((item) => item.title.toLowerCase().contains(query.toLowerCase())).toList();
  }
}

// Cart Provider
class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1,
          price: existingCartItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

// Cart Item Model
class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

// Shop Screen
class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final cart = Provider.of<CartProvider>(context);
    final products = _searchQuery.isEmpty
        ? productsData.items
        : productsData.searchItems(_searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text('D-STORE'),
        ),
        leading: PopupMenuButton<int>(
          onSelected: (item) => onSelected(context, item),
          itemBuilder: (context) => [
            PopupMenuItem<int>(
              value: 0,
              child: Row(
                children: [
                  Icon(Icons.home, color: Color.fromARGB(229, 0, 0, 0)),
                  SizedBox(width: 8),
                  Text('Home'),
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: Row(
                children: [
                  Icon(Icons.shopping_cart, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Cart'),
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 2,
              child: Row(
                children: [
                  Icon(Icons.account_circle, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Account'),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(productsData),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        itemBuilder: (ctx, i) => ProductItem(
          products[i].id,
          products[i].title,
          products[i].price,
          products[i].imageUrl,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        // Navigate to Home
        break;
      case 1:
        Navigator.of(context).pushNamed(CartScreen.routeName);
        break;
      case 2:
        Navigator.of(context).pushNamed(AccountScreen.routeName);
        break;
    }
  }
}

// Product Item
class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  ProductItem(this.id, this.title, this.price, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {},
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(Icons.favorite_border),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {},
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
              ),
              Text(
                '\$$price',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(id, price, title);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Item add to cart!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}


// Cart Screen
class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.titleLarge?.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    child: Text('ORDER NOW'),
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartListItem(
                id: cart.items.values.toList()[i].id,
                productId: cart.items.keys.toList()[i],
                title: cart.items.values.toList()[i].title,
                quantity: cart.items.values.toList()[i].quantity,
                price: cart.items.values.toList()[i].price,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Cart List Item
class CartListItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartListItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: const Color.fromARGB(255, 239, 108, 108),
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('\$$price'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity).toStringAsFixed(2)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}

// Product Search Delegate
class ProductSearchDelegate extends SearchDelegate<String> {
  final ProductsProvider productsProvider;

  ProductSearchDelegate(this.productsProvider);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = productsProvider.searchItems(query);

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return ListTile(
          title: Text(product.title),
          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          leading: Image.asset(
            product.imageUrl,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
          onTap: () {
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = productsProvider.searchItems(query);

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final product = suggestions[index];
        return ListTile(
          title: Text(product.title),
          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          leading: Image.asset(
            product.imageUrl,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
          onTap: () {
            query = product.title;
            showResults(context);
          },
        );
      },
    );
  }
}

// Account Screen
class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text('Manage Account'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ManageAccountScreen(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy Settings'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => PrivacySettingsScreen(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => LoginScreen()),
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}

// Placeholder screens for Manage Account and Privacy Settings
class ManageAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Account'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit Profile'),
            onTap: () {
              // Navigate to Edit Profile Screen
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Change Password'),
            onTap: () {
              // Navigate to Change Password Screen
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Update Email'),
            onTap: () {
              // Navigate to Update Email Screen
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}

class PrivacySettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Manage Passwords'),
            onTap: () {
              // Navigate to Manage Passwords Screen
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shield),
            title: Text('Two-Factor Authentication'),
            onTap: () {
              // Navigate to Two-Factor Authentication Screen
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Clear Search History'),
            onTap: () {
              // Navigate to Clear Search History Screen
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
