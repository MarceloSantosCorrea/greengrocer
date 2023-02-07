import 'package:flutter/material.dart';
import 'package:greengrocer/src/auth/components/custom_text_field.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomTextField(
                      icon: Icons.person,
                      label: 'Nome',
                    ),
                    const CustomTextField(
                      icon: Icons.file_copy,
                      label: 'CPF',
                    ),
                    const CustomTextField(
                      icon: Icons.phone,
                      label: 'Celular',
                    ),
                    const CustomTextField(
                      icon: Icons.email,
                      label: 'Email',
                    ),
                    const CustomTextField(
                      icon: Icons.lock,
                      label: 'Senha',
                      isSecret: true,
                    ),
                    const CustomTextField(
                      icon: Icons.lock,
                      label: 'Confirme a senha',
                      isSecret: true,
                    ),
                    SizedBox(
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        child: const Text(
                          'Cadastrar usuário',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
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
    );
  }
}
