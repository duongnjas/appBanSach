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

  String? _selectedAddressId;

  @override
  void dispose() {
    _addressController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

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

  Future<void> updateAddress(
      String addressId, String address, String phoneNumber) async {
    try {
      await _addressCollection.doc(addressId).update({
        'address': address,
        'phoneNumber': phoneNumber,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cập nhật địa chỉ thành công!'),
        ),
      );
      _addressController.clear();
      _phoneNumberController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cập nhật địa chỉ thất bại!'),
        ),
      );
      print('Error updating address: $e');
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

  void _editAddress(String addressId, String address, String phoneNumber) {
    _addressController.text = address;
    _phoneNumberController.text = phoneNumber;
    setState(() {
      _selectedAddressId = addressId;
    });
  }

  void _cancelEdit() {
    _addressController.clear();
    _phoneNumberController.clear();
    setState(() {
      _selectedAddressId = null;
    });
  }

  bool _isEditingAddress(String addressId) {
    return _selectedAddressId == addressId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Địa chỉ của tôi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Địa chỉ',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Số điện thoại',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _selectedAddressId != null
                  ? _updateSelectedAddress
                  : _addAddress,
              child: Text(_selectedAddressId != null
                  ? 'Cập nhật địa chỉ'
                  : 'Thêm địa chỉ'),
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
                            title: _isEditingAddress(addressId)
                                ? TextField(
                                    controller: _addressController,
                                    decoration: InputDecoration(
                                      hintText: 'Địa chỉ',
                                    ),
                                  )
                                : Text(
                                    addressText,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            subtitle: _isEditingAddress(addressId)
                                ? TextField(
                                    controller: _phoneNumberController,
                                    decoration: InputDecoration(
                                      hintText: 'Số điện thoại',
                                    ),
                                  )
                                : Text(phoneNumber),
                            trailing: _isEditingAddress(addressId)
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.check),
                                        onPressed: () =>
                                            _updateAddress(addressId),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.cancel),
                                        onPressed: _cancelEdit,
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () => _editAddress(addressId,
                                            addressText, phoneNumber),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () =>
                                            _showDeleteConfirmationDialog(
                                                addressId),
                                      ),
                                    ],
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

  void _addAddress() {
    addAddress(
      _addressController.text,
      _phoneNumberController.text,
    );
  }

  void _updateAddress(String addressId) {
    updateAddress(
      addressId,
      _addressController.text,
      _phoneNumberController.text,
    );
    _cancelEdit();
  }

  void _updateSelectedAddress() {
    _updateAddress(_selectedAddressId!);
  }

  Future<void> _showDeleteConfirmationDialog(String addressId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xóa địa chỉ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bạn có chắc muốn xóa địa chỉ này?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Xóa'),
              onPressed: () {
                deleteAddress(addressId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
