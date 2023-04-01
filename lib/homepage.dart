import 'package:flutter/material.dart';
import 'package:thebookest/widget/sidebar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Doanh thu'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SalesPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text('Danh sách sản phẩm'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Danh sách nhân viên'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmployeePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doanh thu'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          Container(
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hôm nay',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '500,000đ',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Tháng này',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '10,000,000đ',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final String category;
  final String author;
  final double price;

  Product(this.name, this.category, this.author, this.price);
}

class ProductPage extends StatelessWidget {
  final List<Product> products = [
    Product('Dế Mèn Phiêu Lưu Ký', 'Truyện thiếu nhi', 'Tô Hoài', 20000),
    Product('Chú Bé Đánh Giày', 'Truyện thiếu nhi', 'Hans Christian Andersen',
        25000),
    Product('Anna Karenina', 'Tiểu thuyết', 'Leo Tolstoy', 35000),
    Product(
        'Con Chim Xanh Biếc Bay Về', 'Truyện ngắn', 'Nguyễn Nhật Ánh', 30000),
    Product('Nhật Ký Trong Tù', 'Tùy bút', 'Hồ Chí Minh', 40000),
    Product('Đời Của Pi', 'Tiểu thuyết', 'Yann Martel', 30000),
    Product('Lão Hạc', 'Tiểu thuyết', 'Nam Cao', 22000),
    Product('Tắt Đèn', 'Truyện ngắn', 'Ngô Tất Tố', 18000),
    Product('Truyện Kiều', 'Thơ', 'Nguyễn Du', 30000),
    Product('Đi Tìm Lẽ Sống', 'Tự truyện', 'Jon Krakauer', 28000),
    Product('Thời Gian Qua Mau', 'Tạp chí', 'NXB Hội Nhà Văn', 15000),
    Product('Đắc Nhân Tâm', 'Phát triển bản thân', 'Dale Carnegie', 25000),
    Product(
        'Sức Mạnh Của Ngôn Từ', 'Phát triển bản thân', 'Tony Robbins', 30000),
    Product('Tôi Tài Giỏi, Bạn Cũng Thế', 'Phát triển bản thân', 'Adam Khoo',
        35000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách sản phẩm'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle:
                Text('${products[index].category} - ${products[index].author}'),
            trailing: Text('${products[index].price}đ'),
          );
        },
      ),
    );
  }
}

class Employee {
  final String name;
  final String birthDate;
  final String gender;
  final String email;
  final String address;
  final String phone;
  final String position;

  Employee(this.name, this.birthDate, this.gender, this.email, this.address,
      this.phone, this.position);
}

class EmployeePage extends StatelessWidget {
  final List<Employee> employees = [
    Employee('Nguyễn Văn A', '01/01/1990', 'Nam', 'nguyenvana@gmail.com',
        '123 Nguyễn Chí Thanh, Quận 5, TP. HCM', '0123456789', 'Quản lý'),
    Employee('Trần Thị B', '02/02/1991', 'Nữ', 'tranthib@gmail.com',
        '456 Lê Lợi, Quận 1, TP. HCM', '0123456789', 'Kế toán'),
    Employee('Lê Văn C', '03/03/1992', 'Nam', 'levanc@gmail.com',
        '789 Hà Huy Tập, Thủ Đức, TP. HCM', '0123456789', 'Nhân viên bán hàng'),
    Employee(
        'Phạm Thị D',
        '04/04/1993',
        'Nữ',
        'phamthid@gmail.com',
        '1012 Nguyễn Văn Linh, Quận 7, TP. HCM',
        '0123456789',
        'Nhân viên bán hàng'),
    Employee('Trần Văn E', '05/05/1994', 'Nam', 'tranvane@gmail.com',
        '11 Trần Hưng Đạo, Quận 1, TP. HCM', '0123456789', 'Kỹ thuật viên'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách nhân viên'),
      ),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(employees[index].name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ngày sinh: ${employees[index].birthDate}'),
                Text('Giới tính: ${employees[index].gender}'),
                Text('Email: ${employees[index].email}'),
                Text('Địa chỉ: ${employees[index].address}'),
                Text('Số điện thoại: ${employees[index].phone}'),
                Text('Chức vụ: ${employees[index].position}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
