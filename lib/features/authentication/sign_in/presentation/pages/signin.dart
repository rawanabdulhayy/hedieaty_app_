import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/domain/repositories/domain_user_repo.dart';
import 'package:hedieaty_app_mvc/features/authentication/sign_in/data/data_sources/firebase_sign_in_auth_data_source.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/config/theme/gradient_background.dart';
import '../../../../../core/presentation/widgets/buttons/custom_golden_button.dart';
import '../../../../../core/presentation/widgets/text_fields/text_form_field.dart';
import '../../../sign_up/domain/Auth_Input_Validator.dart';
import '../../data/data_sources/firebase_forget_password_auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Firebase_Auth_Data_Service _authService = Firebase_Auth_Data_Service(); // Use AuthService instance
  final ForgetPasswordAuthService _authService2 = ForgetPasswordAuthService(); // Use AuthService instance

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
                                // AwesomeNotifications().createNotification(content: NotificationContent(id: 1, channelKey: "basic_channel", title: "Signed up, baby!", body: "Yay, I have local notifications working now!"));
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
                          onPressed: () async {
                            final email = _emailController.text.trim();
                            if (email.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please enter your email address and press the forget password button after'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            try {
                              await _authService2.sendPasswordResetEmail(email: email);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Password reset email sent successfully!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to send password reset email: $error'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
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
