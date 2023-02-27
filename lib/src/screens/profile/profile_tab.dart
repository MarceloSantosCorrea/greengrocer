import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/validators.dart';
import '../auth/controller/auth.controller.dart';
import '../widgets/custom_text_field.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do usuário'),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          CustomTextField(
            icon: Icons.person,
            label: 'Nome',
            initialValue: authController.user.name,
            readOnly: true,
          ),
          CustomTextField(
            icon: Icons.file_copy,
            label: 'CPF',
            isSecret: true,
            initialValue: authController.user.cpf,
            readOnly: true,
          ),
          CustomTextField(
            icon: Icons.phone,
            label: 'Celular',
            initialValue: authController.user.phone,
            readOnly: true,
          ),
          CustomTextField(
            icon: Icons.email,
            label: 'Email',
            initialValue: authController.user.email,
            readOnly: true,
          ),
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.green,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                updatePassword();
              },
              child: const Text('Atualiar senha'),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Atualização de senha',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CustomTextField(
                        icon: Icons.lock,
                        label: 'Senha atual',
                        isSecret: true,
                        validator: passwordValidator,
                        controller: currentPasswordController,
                      ),
                      CustomTextField(
                        icon: Icons.lock_outline,
                        label: 'Nova Senha',
                        isSecret: true,
                        validator: passwordValidator,
                        controller: newPasswordController,
                      ),
                      CustomTextField(
                        icon: Icons.lock_outline,
                        label: 'Confirmar a nova senha',
                        isSecret: true,
                        validator: (password) {
                          final result = passwordValidator(password);

                          if (result != null) {
                            return result;
                          }
                          if (password != newPasswordController.text) {
                            return 'As senhas não são iguais';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 45,
                        child: Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                            onPressed: authController.isLoading.value
                                ? null
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      authController.changePassword(
                                        currentPassword:
                                            currentPasswordController.text,
                                        newPassword: newPasswordController.text,
                                      );
                                    }
                                  },
                            child: authController.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Text('Atualizar'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
