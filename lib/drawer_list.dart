import 'package:carros/login/login_page.dart';
import 'package:carros/login/user.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<User> future = User.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<User>(
              future: future,
              builder: ( context, snapshot) {
                User user = snapshot.data;
                return user != null
                    ? _header(user)
                    : Container(
                        color: Colors.yellow,
                      );
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Coisa 1"),
              subtitle: Text("mais de coisa..."),
              trailing: Icon(Icons.forward),
            ),
            ListTile(
              leading: Icon(Icons.beach_access),
              title: Text("Coisa 2"),
              subtitle: Text("mais de coisa..."),
              trailing: Icon(Icons.forward),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              trailing: Icon(Icons.forward),
              onTap: () => _onClickLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  UserAccountsDrawerHeader _header(User user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.nome),
      accountEmail: Text(user.email),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user.urlFoto),
      ),
    );
  }

  _onClickLogout(BuildContext context) {

    User.clear();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
