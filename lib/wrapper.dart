import 'package:flutter/material.dart';
import 'package:nft_marketplace/pages/homepage.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';
import 'models/user_model.dart';
import 'pages/authpage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? userLoggedInBefore = snapshot.data;
          return userLoggedInBefore == null ? LoginPage() : const HomePage();
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
