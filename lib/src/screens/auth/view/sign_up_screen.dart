import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../config/custom_colors.dart';
import '../../../services/validators.dart';
import '../../widgets/custom_text_field.dart';
import '../controller/auth.controller.dart';

class SignUpScreen extends StatelessWidget {
  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final phoneFormatter = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  SignUpScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 40.0,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45.0),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            icon: Icons.person,
                            label: 'Nome',
                            validator: nameValidator,
                            onSaved: (value) {
                              authController.user.name = value;
                            },
                          ),
                          CustomTextField(
                            icon: Icons.file_copy,
                            label: 'CPF',
                            inputFormatters: [cpfFormatter],
                            keyboardType: TextInputType.number,
                            validator: cpfValidator,
                            onSaved: (value) {
                              authController.user.cpf = value;
                            },
                          ),
                          CustomTextField(
                            icon: Icons.phone,
                            label: 'Celular',
                            inputFormatters: [phoneFormatter],
                            keyboardType: TextInputType.phone,
                            validator: phoneValidator,
                            onSaved: (value) {
                              authController.user.phone = value;
                            },
                          ),
                          CustomTextField(
                            icon: Icons.email,
                            label: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: emailValidator,
                            onSaved: (value) {
                              authController.user.email = value;
                            },
                          ),
                          CustomTextField(
                            icon: Icons.lock,
                            label: 'Senha',
                            isSecret: true,
                            validator: passwordValidator,
                            onSaved: (value) {
                              authController.user.password = value;
                            },
                          ),
                          // CustomTextField(
                          //   icon: Icons.lock,
                          //   label: 'Confirme a senha',
                          //   isSecret: true,
                          //   validator: passwordValidator,
                          //   onSaved: (value) {
                          //     authController.user.name = value;
                          //   },
                          // ),
                          SizedBox(
                            height: 50.0,
                            child: Obx(
                              () {
                                return ElevatedButton(
                                  onPressed: authController.isLoading.value
                                      ? null
                                      : () {
                                          FocusScope.of(context).unfocus();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            authController.signUp();
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                  child: authController.isLoading.value
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          'Cadastrar usuário',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10.0,
                left: 10.0,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
