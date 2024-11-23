import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/common_widgets/gradient_background.dart';
import '../../core/app_colors.dart';
import '../../core/common_widgets/custom_golden_button.dart';
import '../../core/common_widgets/text_form_field.dart';
import '../../domain/validators.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Card(
                color: AppColors.navyBlue.withOpacity(0.5),
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Email Field
                        CustomTextFormField(
                          controller: _emailController,
                          labelText: 'Email',
                          hintText: 'example@mail.com',
                          validator: Validators.validateEmail,
                          obscureText: false,
                        ),
                        // Password Field
                        CustomTextFormField(
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: '******',
                          obscureText: true,
                          validator: Validators.validatePassword,
                        ),
                        // Sign-In Button
                        CustomButton(
                          text: 'Sign In',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Handle sign-in logic
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Signing In...')),
                              );
                            }
                          },
                        ),
                        // Optional: Add Forgot Password or Register Links
                        const SizedBox(height: 8.0),
                        TextButton(
                          onPressed: () {
                            // Navigate to Forgot Password screen or other action
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
