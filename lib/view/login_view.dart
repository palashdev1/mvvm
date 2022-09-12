import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_buton.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'package:mvvm/view/home_screen.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ValueNotifier<bool> _obsecuredPassword = ValueNotifier<bool>(true);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _obsecuredPassword.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                decoration: const InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.alternate_email)),
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(
                      context, emailFocusNode, passwordFocusNode);
                },
              ),
              ValueListenableBuilder(
                  valueListenable: _obsecuredPassword,
                  builder: (context, value, child) {
                    return TextFormField(
                        controller: _passwordController,
                        obscuringCharacter: "*",
                        obscureText: _obsecuredPassword.value,
                        focusNode: passwordFocusNode,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_open_rounded),
                          suffixIcon: InkWell(
                            onTap: () {
                              _obsecuredPassword.value =
                                  !_obsecuredPassword.value;
                            },
                            child: Icon(_obsecuredPassword.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility),
                          ),
                        ));
                  }),
              SizedBox(
                height: height * .1,
              ),
              RoundButton(
                  title: 'Login',
                  onPress: () {
                    if (_emailController.text.isEmpty) {
                      Utils.flushBarErrorMessage('Please enter email', context);
                    } else if (_passwordController.text.isEmpty) {
                      Utils.flushBarErrorMessage('Please enter password', context);
                    } else if (_passwordController.text.length < 6) {
                      Utils.flushBarErrorMessage('Please enter 6 digit password', context);
                    } else {
                      Map data = {
                        'email' : _emailController.text.toString(),
                        'password' : _emailController.text.toString(),
                      };
                      Utils.toastMessage('Api hit');
                      authViewModel.loginApi(data, context);
                    }
                  })
            ],
          ),
        ));
  }
}
