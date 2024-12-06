import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/domain/repositories/domain_user_repo.dart';
import 'package:hedieaty_app_mvc/features/authentication/sign_in/data/data_sources/firebase_sign_in_auth_data_source.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/config/theme/gradient_background.dart';
import '../../../../../core/presentation/widgets/buttons/custom_golden_button.dart';
import '../../../../../core/presentation/widgets/text_fields/text_form_field.dart';
import '../../../sign_up/domain/Auth_Input_Validator.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseSignInAuthDataSource _authService = FirebaseSignInAuthDataSource(); // Use AuthService instance

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
                        ),
                        // Password Field
                        CustomTextFormField(
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: '******',
                          validator: Validators.validatePassword,
                        ),
                        // Sign-In Button
                        CustomButton(
                          text: 'Sign In',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                // Call the signIn method from AuthService
                                await _authService.signIn(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Signed In Successfully')),
                                );
                                 // Navigate to the homepage after successful sign-in
                                Navigator.pushNamed(context, '/screen_wrapper'); // Replace with the actual route name of your homepage
                                // Navigate to the next page or dashboard
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $e')),
                                );
                              }
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
