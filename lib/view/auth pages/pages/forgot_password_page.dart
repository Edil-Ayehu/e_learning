import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/utils/app_colors.dart';
import 'package:e_learning/common/widgets/custom_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  
  ForgotPasswordPage({super.key});

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
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_reset_rounded,
                        size: 64,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Reset Password',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter your email to receive reset instructions',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondaryColor,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
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
                        const SizedBox(height: 32),
                        CustomButton(
                          text: 'Send Reset Link',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Handle password reset
                              Get.snackbar(
                                'Success',
                                'Reset link sent to your email',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppColors.primaryColor,
                                colorText: Colors.white,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 24),
                        TextButton.icon(
                          onPressed: () => Get.back(),
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: AppColors.primaryColor,
                          ),
                          label: Text(
                            'Back to Login',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          if (!GetUtils.isEmail(value)) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
    );
  }
}
