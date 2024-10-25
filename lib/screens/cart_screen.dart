import 'package:flutter/material.dart';
import 'package:baitap/models/cart.dart';

class CartScreen extends StatefulWidget {
  final Cart cart;

  CartScreen({required this.cart});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cart.items.length,
              itemBuilder: (ctx, index) {
                final cartItem = widget.cart.items[index];
                return Card(
                  child: ListTile(
                    leading: Image.asset(cartItem.product.imageUrl,
                        width: 50, height: 50),
                    title: Text(cartItem.product.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Giá: ${cartItem.product.price} đ'), // Product price
                        Text('Số lượng: ${cartItem.quantity}'), // Quantity
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (cartItem.quantity > 1) {
                              // Giảm số lượng sản phẩm
                              setState(() {
                                widget.cart.decreaseQuantity(cartItem);
                              });
                            } else {
                              // Hiển thị hộp thoại xác nhận xóa khi số lượng sản phẩm là 1
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Xác nhận'),
                                    content: Text(
                                        'Bạn có chắc chắn muốn xóa sản phẩm này?'),
                                    actions: [
                                      TextButton(
                                        child: Text('Hủy'),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Đóng hộp thoại
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Xóa'),
                                        onPressed: () {
                                          setState(() {
                                            widget.cart.removeItem(
                                                cartItem); // Xóa sản phẩm
                                          });
                                          Navigator.of(context)
                                              .pop(); // Đóng hộp thoại
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                        Text(
                          '${cartItem.quantity}',
                          style: TextStyle(fontSize: 24.0),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              widget.cart.increaseQuantity(cartItem);
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: Text('${cartItem.totalPrice} đ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0)),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Xác nhận'),
                                  content: Text(
                                      'Bạn có chắc chắn muốn xóa sản phẩm này?'),
                                  actions: [
                                    TextButton(
                                      child: Text('Hủy'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Xóa'),
                                      onPressed: () {
                                        setState(() {
                                          widget.cart.removeItem(cartItem);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween,
              children: [
                Text(
                  'Tổng tiền: ${widget.cart.totalPrice} đ',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
  if (widget.cart.totalPrice > 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Thanh toán thành công')),
    );
    
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        widget.cart.clearCart();
      });
      Navigator.of(context).pop();
    });
    
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Thanh toán không thành công')),
    );
  }
},


                  child: Text('Thanh toán', style: TextStyle(fontSize: 20.0)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
