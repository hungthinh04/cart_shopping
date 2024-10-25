import 'package:baitap/models/cart.dart';
import 'package:baitap/models/product.dart';
import 'package:baitap/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  final Cart cart;

  HomeScreen({required this.cart});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> products = [
    Product('Air Jordan 4 RM', """Những đôi giày thể thao này tái hiện lại chiếc AJ4 dễ nhận biết ngay lập tức cho cuộc sống thường xuyên di chuyển. Chúng tôi tập trung vào sự thoải mái và độ bền trong khi vẫn giữ được nét truyền thống mà bạn yêu thích. Max Air ở gót chân đệm từng bước của bạn và các bộ phận của phần trên cánh, mắt và gót chân được hòa quyện thành một chiếc lồng chắc chắn, linh hoạt bao bọc giày để tăng thêm độ chắc chắn cho chuyến đi hàng ngày của bạn.

Màu sắc hiển thị: Đen/Cánh buồm/Sữa dừa/Đỏ tập thể dục
Phong cách: FQ7939-006
Quốc gia/Khu vực xuất xứ: Việt Nam""", 4109000, 'assets/images/product1.png'),
    Product('Sản phẩm 2', """Lamborghini Huracán (tiếng Tây Ban Nha có nghĩa là “cơn bão”) là một chiếc xe thể thao do Lamborghini chế tạo, thay thế cho Gallardo. Lamborghini Huracan ra mắt triển lãm ô tô tại Triển lãm ô tô Geneva vào tháng 3 năm 2014. Tác phẩm nghệ thuật này được tạp chí xe hơi Top Gear vinh danh là “Siêu xe của năm 2014”.""", 2000000000, 'assets/images/product2.jpg'),
    Product("Nike Air Force 1'07 LX", """Mang theo niềm yêu thích trò chơi của bạn đến bất cứ nơi đâu. Vượt qua sự thoải mái bằng gỗ cứng với sự tinh tế ngoài sân đấu, những cú đá này tạo ra một sự thay đổi mới mẻ trên một chiếc vòng cổ điển bằng da và những dấu Swoosh nhỏ được đặt một cách hoàn hảo. Tất nhiên, chúng tôi vẫn giữ nguyên kết cấu của thập niên 80 và đệm Nike Air mà bạn biết và yêu thích cho cảm giác AF-1 huyền thoại đó. Hãy tiếp tục đi vào một cú trượt dốc.


Màu sắc hiển thị: Cánh buồm/Cánh buồm/Vàng kim loại/Cánh buồm
Phong cách: FV3654-111
Quốc gia/Khu vực xuất xứ: Việt Nam""", 3519000, 'assets/images/product3.png'),
    Product('Red Alfa Romeo C4', """là chiếc coupe hai chỗ ngồi dẫn động cầu sau với công nghệ và vật liệu lấy từ Alfa Romeo 8C Competitionizione, với động cơ xăng tăng áp 1750 cc phun nhiên liệu trực tiếp, hộp số ly hợp khô đôi "Alfa TCT" và bộ chọn điều khiển động Alfa DNA.""", 500000000, 'assets/images/product4.jpg'),
    Product('adidas Crazychaos', """Giày thể thao thoải mái với phong cách retro.
Hãy quay trở lại đầu những năm 2000. Đôi giày adidas này tái hiện tinh thần thoải mái của thiên niên kỷ với các đường cong táo bạo và sự kết hợp chất liệu đa dạng. Đệm Cloudfoam khiến mỗi bước đi như đang dạo bước trên mây. Đế ngoài cao su bền bỉ với độ bám vượt trội hỗ trợ cho những chuyến phiêu lưu bất chợt của bạn.

ĐẶC ĐIỂM NỔI BẬT

Dây buộc
Thân giày lưới phủ da lộn và chất liệu tổng hợp
Lớp lót vải dệt
Đế giữa Cloudfoam&
Đế ngoài tổng hợp
Màu sắc:&Core Black / Cloud White / Core Black
Mã sản phẩm: IG4406""", 2050000, 'assets/images/product5.png'),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen(cart: widget.cart)),
                  ).then((_) {
                    setState(() {});  // Cập nhật lại trang chủ khi quay về
                  });
                },
              ),
              if (widget.cart.totalItems > 0)  // Hiển thị số lượng sản phẩm bên giỏ hàng
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${widget.cart.totalItems}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (ctx, index) => Card(
          child: ListTile(
            leading: Image.asset(products[index].imageUrl),
            title: Center(child: Text(products[index].name)),
            subtitle: Center(child: Text('${products[index].price} đ')),
            onTap: () {
              // Điều hướng tới trang chi tiết sản phẩm khi nhấn vào sản phẩm
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: products[index], cart: widget.cart),
                ),
              );
            },
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                setState(() {
                  widget.cart.addItem(products[index]);  // Thêm sản phẩm vào giỏ hàng
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
