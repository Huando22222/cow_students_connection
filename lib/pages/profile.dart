import 'package:cow_students_connection/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin người dùng'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('DisplayName: ${user?.displayName ?? 'N/A'}'),
            Text('Email: ${user?.email ?? 'N/A'}'),
            Text('id: ${user?.id ?? 'N/A'}'),
            Text('photoUrl: ${user?.photoUrl ?? 'N/A'}'),
            Text('serverAuthCode: ${user?.serverAuthCode ?? 'N/A'}'),
            Text('idToken: ${user?.idToken ?? 'N/A'}'),
            // Các thông tin khác
          ],
        ),
      ),
    );
  }
}
