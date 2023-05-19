import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  final CollectionReference _addressCollection =
      FirebaseFirestore.instance.collection('addresses');

  Future<void> addAddress(String address, String phoneNumber) async {
    try {
      await _addressCollection.add({
        'userId': _currentUser!.uid,
        'address': address,
        'phoneNumber': phoneNumber,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Thêm địa chỉ thành công!'),
        ),
      );
      _addressController.clear();
      _phoneNumberController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Thêm địa chỉ thất bại!'),
        ),
      );
      print('Error adding address: $e');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đia chỉ của tôi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Địa chỉ',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Số điện thoại',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => addAddress(
                _addressController.text,
                _phoneNumberController.text,
              ),
              child: Text('Thêm địa chỉ'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            SizedBox(height: 32.0),
            Text(
              'Địa chỉ',
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
          ],
        ),
      ),
    );
  }
}
