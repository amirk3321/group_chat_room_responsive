import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_chat_room_responsive/presentation/bloc/auth/auth_cubit.dart';
import 'package:group_chat_room_responsive/presentation/bloc/login/login_cubit.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RightSideWidget extends StatefulWidget {
  final SizingInformation sizingInformation;

  const RightSideWidget({Key key, this.sizingInformation}) : super(key: key);

  @override
  _RightSideWidgetState createState() => _RightSideWidgetState();
}

class _RightSideWidgetState extends State<RightSideWidget> {
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  bool isLoginPage = true;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return _loadingWidget();
        }
        return _bodyWidget();
      },
      listener: (context, state) {
        if (state is LoginSuccess){
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
      },
    );
  }

  Widget _loadingWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _imageWidget(),
          SizedBox(
            height: 15,
          ),
          _fromWidget(),
          SizedBox(
            height: 15,
          ),
          _buttonWidget(),
          SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _rowTextWidget(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Lottie.asset("assets/loading.json"),
          ),
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _imageWidget(),
          SizedBox(
            height: 15,
          ),
          _fromWidget(),
          SizedBox(
            height: 15,
          ),
          _buttonWidget(),
          SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _rowTextWidget(),
          ),
        ],
      ),
    );
  }

  Widget _imageWidget() {
    return Container(
      height: 60,
      width: 60,
      child: Image.asset("assets/profile.png"),
    );
  }

  Widget _fromWidget() {
    return Column(
      children: [
        isLoginPage == true
            ? Text(
                "",
                style: TextStyle(fontSize: 0),
              )
            : Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "User Name",
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
              ),
        isLoginPage == true
            ? Text(
                "",
                style: TextStyle(fontSize: 0),
              )
            : SizedBox(
                height: 20,
              ),
        Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            border: Border.all(color: Colors.grey, width: 1.0),
          ),
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Email Address",
              prefixIcon: Icon(Icons.alternate_email),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            border: Border.all(color: Colors.grey, width: 1.0),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Password",
              prefixIcon: Icon(Icons.lock_outline),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttonWidget() {
    return InkWell(
      onTap: () {
        if (isLoginPage == true) {
          _submitLogin();
        } else {
          _submitRegistration();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: widget.sizingInformation.screenSize.width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Text(
          isLoginPage == true ? "LOGIN" : "REGISTER",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _rowTextWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLoginPage == true ? "Don't have account?" : "Have an account?",
          style: TextStyle(fontSize: 16, color: Colors.indigo[400]),
        ),
        InkWell(
          onTap: () {
            setState(() {
              if (isLoginPage == true)
                isLoginPage = false;
              else
                isLoginPage = true;
            });
          },
          child: Text(
            isLoginPage == true ? " Sign Up" : " Sign In",
            style: TextStyle(
                fontSize: 16,
                color: Colors.indigo,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _submitLogin() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<LoginCubit>(context).submitLogin(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  void _submitRegistration() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _nameController.text.isNotEmpty) {
      BlocProvider.of<LoginCubit>(context).submitRegistration(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
      );
    }
  }
}
