import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/common_widgets/gradient_background.dart';
import '../../core/app_colors.dart';
import '../../core/common_widgets/custom_golden_button.dart';
import '../../core/common_widgets/text_form_field.dart';
import '../../domain/validators.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                          validator: Validators.validateEmail, obscureText: null,
                        ),
                        // Username Field
                        CustomTextFormField(
                          controller: _usernameController,
                          labelText: 'Username',
                          hintText: 'Your Username',
                          validator: Validators.validateUsername, obscureText: null,
                        ),
                        // Phone Number Field
                        CustomTextFormField(
                          controller: _phoneController,
                          labelText: 'Phone Number',
                          hintText: '+1234567890',
                          keyboardType: TextInputType.phone,
                          validator: Validators.validatePhone, obscureText: null,
                        ),
                        // Password Field
                        CustomTextFormField(
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: '******',
                          obscureText: true,
                          validator: Validators.validatePassword,
                        ),
                        // Confirm Password Field
                        CustomTextFormField(
                          controller: _confirmPasswordController,
                          labelText: 'Confirm Password',
                          hintText: '******',
                          obscureText: true,
                          validator: (value) =>
                              Validators.validateConfirmPassword(value, _passwordController.text),
                        ),
                        // Sign-Up Button
                        CustomButton(
                          text: 'Sign Up',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Handle sign-up logic
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Signing Up...')),
                              );
                            }
                          },
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
