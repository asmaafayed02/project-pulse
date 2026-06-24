import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/core/constants/app_assets.dart';
import 'package:project_pulse/core/utils/snackbar_helper.dart';
import 'package:project_pulse/core/utils/validators.dart';
import 'package:project_pulse/features/auth/domain/entities/user_entity.dart';
import 'package:project_pulse/features/auth/presentation/widgets/auth_form_card.dart';
import 'package:project_pulse/features/auth/presentation/widgets/auth_header.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/inputs/app_text_field.dart';
import '../../../../core/widgets/inputs/password_field.dart';
import '../providers/auth_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  ProviderSubscription<AsyncValue<UserEntity?>>? _subscription;
  final _formKey = GlobalKey<FormState>();

  final _firstNameController =
      TextEditingController();

  final _lastNameController =
      TextEditingController();

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();


@override
void initState() {
  super.initState();

  _subscription = ref.listenManual(
    authProvider,
    (previous, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null && mounted) {
            Navigator.pop(context);
          }
        },
        error: (error, stackTrace) {
        showErrorSnackBar(context, error.toString());

        },
      );
    },
  );
}
Future<void> _register() async {
  if (!_formKey.currentState!.validate()) return;

  await ref.read(authProvider.notifier).register(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
}
  @override
  void dispose() {
    _subscription?.close();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
             keyboardDismissBehavior:
      ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.all(AppSizes.s24),
            child: AuthCard(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    AuthHeader(
                      assetPath: AppAssets.iconLight,
                      title: 'Welcome to ProjectPulse',
                      subtitle: 'Join us and manage your projects seamlessly.',
                    ),
            
                    SizedBox(height: AppSizes.s32),
              
                     AppTextField(
                      controller:
                          _firstNameController,
                      validator: Validators.name,
                      hint: 'First Name',
                      prefixIcon:
                          const Icon(Icons.person),
                    ),
                  
                  SizedBox(height: AppSizes.s16),
                  AppTextField(
                      controller:
                          _lastNameController,
                      hint: 'Last Name',
                      validator: Validators.name,
                      prefixIcon:
                          const Icon(Icons.person),
                    ),
               
                  
              
                    SizedBox(height: AppSizes.s16),
              
                    AppTextField(
                      controller: _emailController,
                      hint: 'Email',
                      keyboardType:
                          TextInputType.emailAddress,
                      prefixIcon:
                          const Icon(Icons.email_outlined),
                      validator: Validators.email,
                    ),
              
                    SizedBox(height: AppSizes.s16),
              
                    PasswordField(
                      controller:
                          _passwordController,
                      validator: Validators.password,
                      textInputAction: TextInputAction.done
                    ),
              
                    SizedBox(height: AppSizes.s24),
              
                    PrimaryButton(
                      text: 'Create Account',
                      isLoading:
                          authState.isLoading,
                      onPressed: _register,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}