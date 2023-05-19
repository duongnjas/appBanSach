import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String _gender = '';
  DateTime _selectedDate = DateTime.now();
  User? _currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // Fetch the user's profile data from Firestore
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      // Retrieve the user document from Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(_currentUser!.uid)
          .get();

      if (snapshot.exists) {
        // If the document exists, populate the text fields with the user's data
        Map<String, dynamic> userData = snapshot.data()!;
        setState(() {
          _nameController.text = userData['name'] ?? '';
          _gender = userData['gender'] ?? '';
          _dobController.text =
              DateFormat('dd/MM/yyyy').format(userData['dateOfBirth'].toDate());
          _phoneController.text = userData['phoneNumber'] ?? '';
        });
      }
    } catch (error) {
      // Handle any errors that occur during data retrieval
      print('Error fetching user profile: $error');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dobController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
      });
    }
  }

  Future<void> _saveChanges() async {
    try {
      // Update the user's profile data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .update({
        'name': _nameController.text,
        'gender': _gender,
        'dateOfBirth': Timestamp.fromDate(_selectedDate),
        'phoneNumber': _phoneController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Thay đổi thông tin thành công!'),
        ),
      );
    } catch (error) {
      // Handle any errors that occur during data update
      print('Error updating user profile: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final urlImage =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZo14vNKzZfLHqh0li9g-NSXlxNQ9nP05vUg';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chỉnh sửa hồ sơ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromRGBO(52, 174, 235, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Thông tin cá nhân',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: NetworkImage(urlImage),
                backgroundColor: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Họ tên',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: MediaQuery.of(context).size.height *
                                0.5, // Adjust the height as needed
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: 16.0),
                                  Text(
                                    'Giới tính',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
                                  ListTile(
                                    title: Text('Nam'),
                                    onTap: () {
                                      setState(() {
                                        _gender = 'Nam';
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    title: Text('Nữ'),
                                    onTap: () {
                                      setState(() {
                                        _gender = 'Nữ';
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    title: Text('Khác'),
                                    onTap: () {
                                      setState(() {
                                        _gender = 'Khác';
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Giới tính',
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(text: _gender),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Ngày sinh',
                          border: OutlineInputBorder(),
                        ),
                        controller: _dobController,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Số điện thoại',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: _saveChanges,
                child: Text(
                  'Lưu thay đổi',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(52, 174, 235, 1),
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
