import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/route_constants.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/presentation/themes/theme_text.dart';
import 'package:movieapp/presentation/blocs/login/login_bloc.dart';
import 'package:movieapp/presentation/widget/button.dart';
import 'package:movieapp/presentation/widget/lable_fiel_widget.dart';
import 'package:movieapp/presentation/widget/logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_32.h),
              child: Logo(
                height: Sizes.dimen_12.h,
              ),
            ),
            LoginForm()
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _userNameController, _passwordController;
  bool enableSignIn = false;
  @override
  void initState() {
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();

    _userNameController.addListener(() {
      setState(() {
        enableSignIn = _userNameController.text.isNotEmpty && _passwordController.text.isNotEmpty;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        enableSignIn = _userNameController.text.isNotEmpty && _passwordController.text.isNotEmpty;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w, vertical: Sizes.dimen_24.h),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: Sizes.dimen_8),
              child: Text(
                'Login to Movie App',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            LableFielWidget(lable: "User Name", hintext: "Enter TMDB username", isPasswordField: false, controller: _userNameController),
            LableFielWidget(lable: "Password", hintext: "Enter TMDB password", isPasswordField: true, controller: _passwordController),
            BlocConsumer<LoginBloc, LoginState>(
              buildWhen: (previous, current) => current is LoginError,
              builder: (context, state){
                if(state is LoginError){
                  return Text(state.message, style: Theme.of(context).textTheme.royalBlueSubtitle1,);
                }
                return SizedBox.shrink();
              },
              listenWhen: (previous, current) => current is LoginSuccess,
              listener: (context, state){
                Navigator.of(context).pushNamedAndRemoveUntil(RouteList.home, (route) => false);
              },
            ),
            Button(text: "Sign In", onPressed: enableSignIn ? (){
              BlocProvider.of<LoginBloc>(context).add(LoginInitiateEvent(_userNameController.text, _passwordController.text));
            } : null,),
          ],
        ),
      ),
    );
  }
}
