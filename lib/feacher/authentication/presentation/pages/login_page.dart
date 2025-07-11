import 'package:blog_app/core/Utils/show_snake_bar.dart';
import 'package:blog_app/core/common/widgets/Loader.dart';
import 'package:blog_app/core/theme/AppPallete.dart';
import 'package:blog_app/feacher/authentication/presentation/bloc/AuthBloc.dart';
import 'package:blog_app/feacher/authentication/presentation/bloc/Auth_Events.dart';
import 'package:blog_app/feacher/authentication/presentation/bloc/Auth_State.dart';
import 'package:blog_app/feacher/authentication/presentation/pages/Sing_up_Page.dart';
import 'package:blog_app/feacher/authentication/presentation/wedgets/authField.dart';
import 'package:blog_app/feacher/authentication/presentation/wedgets/auth_gradeand_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc , AuthState>(
          listener: (context, state) {
            if(state is AuthFailure){
              showSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if(state is AuthLoading){
              return Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sing in ',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 15,),
                  Authfield(hint: 'Email',conroller: emailController,),
                  SizedBox(height: 15,),
                  Authfield(hint: 'Password', conroller: passwordController,isObscureText: true,),
                  SizedBox(height: 15,),
                  AuthGradeandButton(butText: 'Sing up',onPress: () {
                    if(formKey.currentState!.validate()){
                      context.read<AuthBloc>().add(AuthLogin(email: emailController.text, password: passwordController.text));
                    }
                  },),
                  SizedBox(height: 15,),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SingUpPage(),));
                    },
                    child: RichText(
                        text:TextSpan(
                            text:  'Don\' have an account ? ',
                            style:Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: 'Sing up',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppPallete.gradient2,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ]
                        )
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
