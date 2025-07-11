import 'package:blog_app/core/Utils/show_snake_bar.dart';
import 'package:blog_app/core/common/widgets/Loader.dart';
import 'package:blog_app/core/theme/AppPallete.dart';
import 'package:blog_app/feacher/authentication/presentation/bloc/AuthBloc.dart';
import 'package:blog_app/feacher/authentication/presentation/bloc/Auth_Events.dart';
import 'package:blog_app/feacher/authentication/presentation/bloc/Auth_State.dart';
import 'package:blog_app/feacher/authentication/presentation/pages/login_page.dart';
import 'package:blog_app/feacher/authentication/presentation/wedgets/authField.dart';
import 'package:blog_app/feacher/authentication/presentation/wedgets/auth_gradeand_button.dart';
import 'package:blog_app/feacher/blog/Presentation/bloc/BlogBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc , AuthState>(
          builder: (context, state) {
            if(state is AuthLoading){
              return const Loader();
            }
            return  Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sing up ',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 15,),
                  Authfield(hint: 'Name', conroller: nameController,),
                  SizedBox(height: 15,),
                  Authfield(hint: 'Email',conroller: emailController,),
                  SizedBox(height: 15,),
                  Authfield(hint: 'Password', conroller: passwordController,isObscureText: true,),
                  SizedBox(height: 15,),
                  AuthGradeandButton(butText: 'Sing in',onPress: () {
                    if(formKey.currentState!.validate() ){
                      context.read<AuthBloc>().add(AuthSingUp(nameController.text, emailController.text, passwordController.text));
                    }
                  },),
                  SizedBox(height: 15,),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage(),));
                    },
                    child: RichText(
                        text:TextSpan(
                            text:  'Already have an account ? ',
                            style:Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: 'Sing in',
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
          listener: (context, state) {
            if(state is AuthFailure){
              showSnackbar(context, state.message);
            }
          },
        ),
      ),
    );
  }
}
