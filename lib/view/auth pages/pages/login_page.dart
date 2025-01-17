import 'package:e_learning/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/utils/app_colors.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  // Logo and App Name
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Lottie.asset(
                        'assets/animations/anim1.json',
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                        animate: true,
                        repeat: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Welcome Back',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Login to continue your learning journey',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondaryColor,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  // Login Form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                          context,
                          'Email',
                          Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          context,
                          'Password',
                          Icons.lock_outline,
                          isPassword: true,
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Get.toNamed('/forgot-password'),
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildLoginButton(),
                        const SizedBox(height: 24),
                        _buildDivider(),
                        const SizedBox(height: 24),
                        _buildSocialLoginButtons(context),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account? ',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed: () => Get.toNamed('/register'),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, IconData icon,
      {bool isPassword = false, TextInputType? keyboardType}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          labelStyle: TextStyle(color: AppColors.textSecondaryColor),
          floatingLabelStyle: TextStyle(color: AppColors.primaryColor),
        ),
        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        obscureText: isPassword,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildLoginButton() {
    return CustomButton(
      text: 'Login',
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Get.offAllNamed('/home');
        }
      },
    );
  }

  Widget _buildDivider() {
    return Row(
      children: const [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Or continue with'),
        ),
        Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildSocialLoginButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(context, 'assets/images/facebook.png', 'Google'),
        const SizedBox(width: 16),
        _buildSocialButton(context, 'assets/images/google.png', 'Facebook'),
      ],
    );
  }

  Widget _buildSocialButton(
      BuildContext context, String imagePath, String platform) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Image.asset(
        imagePath,
        width: 32,
        height: 32,
      ),
    );
  }
}
