import 'package:flutter/material.dart';
import 'package:messagerie/components/my_button.dart';
import 'package:messagerie/components/my_text_field.dart';
import 'package:messagerie/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageSate();
}

class _LoginPageSate extends State<LoginPage> {
  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),

                        // Logo
                        Icon(Icons.message, size: 100, color: Colors.grey[800]),
                        const SizedBox(height: 50),

                        // Message de retour
                        const Text("Welcome back bro",
                            style: TextStyle(
                              fontSize: 16,
                            )),

                        const SizedBox(height: 25),

                        // Email Text Field
                        MyTextField(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                        ),

                        const SizedBox(height: 25),

                        // Password Text Field
                        MyTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),

                        const SizedBox(height: 25),

                        // Sign In Button
                        MyButton(onTap: signIn, text: 'Sign In'),

                        const SizedBox(height: 50),

                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Not a member ?'),
                              const SizedBox(width: 4),
                              GestureDetector(
                                  onTap: widget.onTap,
                                  child: const Text('Register now',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                            ])
                      ])))),
    );
  }
}
