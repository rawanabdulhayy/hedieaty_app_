import 'package:firebase_auth/firebase_auth.dart';
import '../../data/data_sources/firebase_sign_up_auth_data_source.dart';
import 'package:flutter/material.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/config/theme/gradient_background.dart';
import '../../../../../core/domain/models/User.dart' as domain_user;
import '../../../../../core/domain/repositories/domain_user_repo.dart';
import '../../../../../core/presentation/widgets/buttons/custom_golden_button.dart';
import '../../../../../core/presentation/widgets/text_fields/text_form_field.dart';
import '../../domain/Auth_Input_Validator.dart';

class SignUpPage extends StatefulWidget {
  final DomainUserRepository domainUserRepository;
  const SignUpPage({super.key, required this.domainUserRepository});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseSignUpAuthDataSource _authService = FirebaseSignUpAuthDataSource();

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
                        // Name Field
                        CustomTextFormField(
                          key: const ValueKey("name"),
                          controller: _nameController,
                          labelText: 'Name',
                          hintText: 'Adam Sandler',
                          isPassword: false,
                          //validator: Validators.validateEmail, obscureText: null,
                        ),
                        // Email Field
                        CustomTextFormField(
                          key: const ValueKey("email"),
                          controller: _emailController,
                          labelText: 'Email',
                          hintText: 'example@mail.com',
                          validator: Validators.validateEmail,
                          isPassword: false,
                        ),
                        // Username Field
                        CustomTextFormField(
                          key: const ValueKey("username"),
                          controller: _usernameController,
                          labelText: 'Username',
                          hintText: 'Your Username',
                          validator: Validators.validateUsername,
                        ),
                        // Phone Number Field
                        CustomTextFormField(
                          key: const ValueKey("phone"),
                          controller: _phoneController,
                          labelText: 'Phone Number',
                          hintText: '+1234567890',
                          keyboardType: TextInputType.phone,
                          validator: Validators.validatePhone,
                        ),
                        // Password Field
                        CustomTextFormField(
                          key: const ValueKey("password"),
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: '******',
                          validator: Validators.validatePassword,
                        ),
                        // Confirm Password Field
                        CustomTextFormField(
                          key: const ValueKey("confirmPassword"),
                          controller: _confirmPasswordController,
                          labelText: 'Confirm Password',
                          hintText: '******',
                          validator: (value) =>
                              Validators.validateConfirmPassword(value, _passwordController.text),
                        ),
                        // Sign-Up Button
                        CustomButton(
                          text: 'Sign Up',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              //Create a new User domain model using the named constructor
                              final user = domain_user.User.signup(
                                name: _nameController.text,
                                email: _emailController.text,
                                username: _usernameController.text,
                                phoneNumber: _phoneController.text,
                                birthDate: DateTime.now(),
                                //wishlist: Wishlist(),
                              );

                              try {
                                // Call the signUp method from the AuthService
                                await _authService.signUp(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  username: _usernameController.text,
                                  phoneNumber: _phoneController.text,
                                  birthDate: DateTime.now(),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Authenticating User...')),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $e')),
                                );
                              }
                              if (FirebaseAuth.instance.currentUser != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Creating User Account...')),
                                );
                                await widget.domainUserRepository.upsertUser(user);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('User Authentication Failed')),
                                );                              }

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