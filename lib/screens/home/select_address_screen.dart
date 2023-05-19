import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thebookest/screens/cart/order_success.dart';
import 'package:thebookest/screens/sidebar/components/address.dart';
import 'package:thebookest/models/Product.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _SelectAddressScreenState createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  final CollectionReference _addressCollection =
      FirebaseFirestore.instance.collection('addresses');

  String? _selectedAddress;
  bool _isAddressSelected = false;
  String? _selectedPaymentMethod;

  Future<void> _selectAddressForShipping(
      String address, String phoneNumber) async {
    setState(() {
      _selectedAddress = address;
      _isAddressSelected = true;
    });
  }

  Future<void> deleteAddress(String addressId) async {
    try {
      await _addressCollection.doc(addressId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Xóa địa chỉ thành công!'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Xóa địa chỉ thất bại!'),
        ),
      );
      print('Error deleting address: $e');
    }
  }

  void _selectPaymentMethod(String paymentMethod) {
    setState(() {
      _selectedPaymentMethod = paymentMethod;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn địa chỉ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Chọn một địa chỉ để giao hàng',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _addressCollection
                    .where('userId', isEqualTo: _currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final addresses = snapshot.data!.docs;
                    if (addresses.isEmpty) {
                      return Center(
                        child: Text(
                          'Chưa có địa chỉ nào',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        final address =
                            addresses[index].data() as Map<String, dynamic>;
                        final addressId = addresses[index].id;
                        final String addressText = address['address'];
                        final String phoneNumber = address['phoneNumber'];

                        return Card(
                          elevation: 3.0,
                          child: ListTile(
                            title: Text(
                              addressText,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(phoneNumber),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => deleteAddress(addressId),
                            ),
                            onTap: () => _selectAddressForShipping(
                              addressText,
                              phoneNumber,
                            ),
                            tileColor: _selectedAddress == addressText
                                ? Colors.blue[100]
                                : null,
                          ),
                        );
                      },
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Thất bại',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            if (_isAddressSelected)
              Column(
                children: [
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tiền sách'),
                      Text('${widget.product.price}đ'),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tiền ship'),
                      Text('20000đ'),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng cộng'),
                      Text(
                          '${widget.product.price + 20000}đ'), // Replace with your value for "Tổng cộng"
                    ],
                  ),
                ],
              ),
            SizedBox(height: 16.0),
            Text(
              'Chọn phương thức thanh toán',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            ListTile(
              title: const Text('Thanh toán khi nhận hàng'),
              leading: Radio<String>(
                value: 'cod',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  _selectPaymentMethod(value!);
                },
              ),
            ),
            ListTile(
              title:
                  const Text('Thanh toán qua thẻ tín dụng (Đang phát triển)'),
              leading: Radio<String>(
                value: 'credit_card',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  _selectPaymentMethod(value!);
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_selectedAddress != null &&
                    _selectedPaymentMethod != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OrderSuccessScreen()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Vui lòng chọn một địa chỉ và phương thức thanh toán'),
                    ),
                  );
                }
              },
              child: Text('Giao hàng'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddressScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8.0),
                  Text('Thêm địa chỉ mới'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
