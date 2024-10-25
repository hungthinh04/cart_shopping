import 'package:flutter/material.dart';
import 'package:baitap/models/cart.dart';
import 'package:baitap/models/product.dart';
import 'package:baitap/screens/cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final Cart cart;

  ProductDetailScreen({required this.product, required this.cart});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  bool isPurchased = false;
  final TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    quantityController.text = quantity.toString();
  }

  @override
  void dispose() {
    quantityController.dispose(); 
    super.dispose();
  }

  void _updateQuantityFromInput(String value) {
    setState(() {
      quantity = int.tryParse(value) ?? 1;
      quantityController.text = quantity.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(widget.product.imageUrl, height: 200, width: 200),
            ),
            SizedBox(height: 16),
            Text(
              '${widget.product.price} đ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              widget.product.description,
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            
            if (isPurchased) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) {
                          quantity--;
                          quantityController.text = quantity.toString();
                        }
                      });
                    },
                  ),
                  Container(
                    child: Expanded(
                      child: TextField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: _updateQuantityFromInput,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++;
                        quantityController.text = quantity.toString();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
            
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Expanded(
                    
                    child: ElevatedButton(
                      onPressed: () {
                        if (isPurchased) {
                          // Add product to cart with the selected quantity
                          widget.cart.addItemWithQuantity(widget.product, quantity);

                          // Navigate to CartScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartScreen(cart: widget.cart),
                            ),
                          );
                        } else {
                          setState(() {
                            isPurchased = true;
                          });
                        }
                      },
                      
                      child: Text(isPurchased ? 'HOÀN TẤT' : 'MUA'),
                      style: ElevatedButton.styleFrom(
                       minimumSize: Size(double.infinity, 60), // Set height to 50
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
