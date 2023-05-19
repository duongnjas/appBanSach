import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thebookest/screens/admin/admin_panel.dart';
import 'package:thebookest/screens/sidebar/components/address.dart';
import 'package:thebookest/screens/sidebar/components/userpage.dart';
import 'package:thebookest/screens/sidebar/components/update_profile_user.dart';
import 'package:thebookest/main.dart';

class SideBar extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  String getCurrentUserEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email ?? '';
      return email;
    }
    return '';
  }

  void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      print('Sign Out Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = 'User';
    final email = getCurrentUserEmail();
    final urlImage =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZo14vNKzZfLHqh0li9g-NSXlxNQ9nP05vUg';

    return Drawer(
      child: Material(
        color: Color.fromRGBO(52, 174, 235, 1),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserPage(
                  name: '',
                  urlImage: urlImage,
                ),
              )),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  buildSearchField(),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Chỉnh sửa thông tin tài khoản',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Yêu thích',
                    icon: Icons.favorite_border,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Thiết lập tài khoản',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Thêm địa chỉ',
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, 6),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Trung tâm trợ giúp',
                    icon: Icons.help_center,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Admin Panel',
                    icon: Icons.help_center,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 16),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Đăng xuất',
                    icon: Icons.logout,
                    onClicked: () => selectedItem(context, 5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
              CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                child: Icon(Icons.add_comment_outlined, color: Colors.white),
              )
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => UpdateProfileScreen()));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AdminPanelScreen(),
        ));
        break;
      case 5:
        _signOut(context);
        break;
      case 6:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AddressScreen()));
        break;
    }
  }
}
