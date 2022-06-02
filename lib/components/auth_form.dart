import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/components/validator.dart';
import 'package:shop2/exceptions/auth_exception.dart';
import 'package:shop2/models/auth.dart';

enum AuthMode { signUp, login }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.login;
  // ignore: prefer_final_fields
  Map<String, String> _authData = {
    "email": "",
    "password": "",
  };

  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.linear,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.linear,
      ),
    );
    // _heightAnimation?.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  bool _isLogin() => _authMode == AuthMode.login;
  // bool _isSignUp() => _authMode == AuthMode.signUp;

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    setState(() => _isLoading = true);

    _formKey.currentState?.save();

    Auth auth = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        //Enviar login
        await auth.login(
          _authData["email"]!,
          _authData["password"]!,
        );
      } else {
        //Enviar registro
        await auth.signUp(
          _authData["email"]!,
          _authData["password"]!,
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog("ocorreu um erro inesperado");
    }

    setState(() => _isLoading = false);
  }

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.signUp;
        _controller?.forward();
      } else {
        _authMode = AuthMode.login;
        _controller?.reverse();
      }
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text("Ocorreu um erro"),
              content: Text(msg),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Fechar")),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
        padding: const EdgeInsets.all(10),
        height: _isLogin() ? 310 : 400,
        // height: _heightAnimation?.value.height ?? (_isLogin() ? 300 : 370),
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "E-mail"),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                onSaved: (email) => _authData["email"] = email ?? "",
                validator: (_email) {
                  final email = _email ?? "";
                  if (!emailValid(email)) {
                    return "Informar endereço de e-mail válido.";
                  }
                  // if (email.trim().isEmpty || !email.contains("@")) {
                  //   return "Informar endereço de e-mail válido.";
                  // }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Senha"),
                keyboardType: TextInputType.visiblePassword,
                autocorrect: false,
                obscureText: true,
                onSaved: (password) => _authData["password"] = password ?? "",
                controller: _passwordController,
                validator: (_password) {
                  final password = _password ?? "";
                  if (password.isEmpty || password.length < 8) {
                    return "Senha deve conter no mínimo 8 caracteres.";
                  }
                  return null;
                },
              ),
              AnimatedContainer(
                constraints: BoxConstraints(
                  minHeight: _isLogin() ? 0 : 60,
                  maxHeight: _isLogin() ? 0 : 120,
                ),
                duration: Duration(milliseconds: 300),
                curve: Curves.linear,
                child: FadeTransition(
                  opacity: _opacityAnimation!,
                  child: SlideTransition(
                    position: _slideAnimation!,
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Confirmar Senha"),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: _isLogin()
                          ? null
                          : (_password) {
                              final password = _password ?? "";
                              if (password != _passwordController.text) {
                                return 'Senhas informadas não conferem.';
                              }
                              return null;
                            },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(
                    _isLogin() ? "ENTRAR" : "REGISTRAR",
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 8,
                      )),
                ),
              const Spacer(),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(_isLogin() ? "CADASTRAR E-MAIL" : "EFETUAR LOGIN"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
