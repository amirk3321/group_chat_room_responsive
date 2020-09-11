import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_chat_room_responsive/data/model/user_model.dart';
import 'package:group_chat_room_responsive/presentation/bloc/auth/auth_cubit.dart';
import 'package:group_chat_room_responsive/presentation/bloc/login/login_cubit.dart';
import 'package:group_chat_room_responsive/presentation/bloc/user/user_cubit.dart';
import 'package:group_chat_room_responsive/presentation/pages/tablet/single_chat_page_tablet.dart';
import 'package:group_chat_room_responsive/presentation/screens/single_chat_screen.dart';
import 'package:lottie/lottie.dart';

class WelcomePageTablet extends StatefulWidget {
  final String uid;

  const WelcomePageTablet({Key key, this.uid}) : super(key: key);
  @override
  _WelcomePageTabletState createState() => _WelcomePageTabletState();
}

class _WelcomePageTabletState extends State<WelcomePageTablet> {

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit,UserState>(builder: (_,state){
      if (state is UserLoaded){
        return _bodyWidget(state);
      }
      return _loadingWidget();
    });
  }

  Widget _bodyWidget(UserLoaded users){
    final user = users.users.firstWhere((user) => user.uid == widget.uid,orElse: () => UserModel());
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo[400],
                    Colors.blue[300],
                  ],
                )),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Lottie.asset("assets/congratulation.json"),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Lottie.asset("assets/bubble.json"),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                margin: EdgeInsets.only(top: 100),
                child: Text(
                  "Welcome ${user.name}",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
          _joinGlobalChatButton(user.name),
          _logOutWidget(),
        ],
      ),
    );
  }

  Widget _loadingWidget(){
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo[400],
                    Colors.blue[300],
                  ],
                )),
          ),
          Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _joinGlobalChatButton(String name) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Join Us For Fun",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SingleChatScreen(username: name,uid: widget.uid,),
                ),
              );
            },
            child: Container(
              width: 250,
              height: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.3),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.white60, width: 2)),
              child: Text(
                "Join",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _logOutWidget() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: InkWell(
        onTap: (){
          //TODO:Logout
          BlocProvider.of<AuthCubit>(context).loggedOut();
          BlocProvider.of<LoginCubit>(context).submitSignOut();
        },
        child: Container(
          margin: EdgeInsets.only(left: 15,bottom: 15),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.3),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            Icons.exit_to_app,
            size: 30,
          ),
        ),
      ),
    );
  }
}
