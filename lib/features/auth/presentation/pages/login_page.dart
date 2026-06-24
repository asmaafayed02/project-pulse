import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/core/constants/app_assets.dart';
import 'package:project_pulse/core/utils/snackbar_helper.dart';
import 'package:project_pulse/core/utils/validators.dart';
import 'package:project_pulse/features/auth/domain/entities/user_entity.dart';
import 'package:project_pulse/features/auth/presentation/widgets/auth_form_card.dart';
import 'package:project_pulse/features/auth/presentation/widgets/auth_header.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/inputs/app_text_field.dart';
import '../../../../core/widgets/inputs/password_field.dart';
import '../providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  ProviderSubscription<AsyncValue<UserEntity?>>? _subscription;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _subscription = ref.listenManual(
      authProvider,
      (previous, next) {
        next.whenOrNull(
          data: (user) {
            if (user != null && mounted) {
              context.goTo(RouteNames.home);
            }
          },
          error: (error, stackTrace) {
          showErrorSnackBar(context, error.toString());
          },
        );
      },
    );
  }
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(authProvider.notifier).login(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _subscription?.close();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
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
                    // SizedBox(height: AppSizes.s20),
              AuthHeader(assetPath: AppAssets.iconLight, title: 'Welcome Back 👋', subtitle: 'Manage your projects seamlessly.',),
              
              
                
              
                    SizedBox(height: AppSizes.s32),
              
                    AppTextField(
                      controller: _emailController,
                      hint: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined),
                   validator: Validators.email,
                    ),
              
                    SizedBox(height: AppSizes.s16),
              
                    PasswordField(
                      controller: _passwordController,
                      validator: Validators.password,
                      textInputAction: TextInputAction.done
                      
                        ),
              
                    SizedBox(height: AppSizes.s24),
              
                    PrimaryButton(
                      text: 'Sign In',
                      isLoading: authState.isLoading,
                      onPressed: _login,
                    ),
              
                    SizedBox(height: AppSizes.s24),
              
                    TextButton(
                      onPressed: () {
                        context.pushTo(
                          RouteNames.register,
                        );
                      },
                      child: const Text(
                        "Don't have an account? Sign Up",
                      ),
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