import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_screen.dart';
import '../widgets/auth_button.dart';

class AuthPage extends StatelessWidget {
  final String role;

  const AuthPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    Color roleColor = role == 'Doctor' ? Colors.blue.shade700 : Colors.green.shade700;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              roleColor.withOpacity(0.8),
              roleColor.withOpacity(0.4),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$role Portal',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 20),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        AuthButton(
                          text: 'Login',
                          color: roleColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(role: role),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        AuthButton(
                          text: 'Sign Up',
                          color: roleColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(role: role),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}