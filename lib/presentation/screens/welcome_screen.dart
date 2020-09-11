import 'package:flutter/material.dart';
import 'package:group_chat_room_responsive/presentation/pages/mobile/welcome_page_mobile.dart';
import 'package:group_chat_room_responsive/presentation/pages/tablet/welcome_page_tablet.dart';
import 'package:group_chat_room_responsive/presentation/pages/web/welcome_page_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WelcomeScreen extends StatelessWidget {
  final String uid;

  const WelcomeScreen({Key key, this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context,sizingInformation){
        if (sizingInformation.isDesktop){
          return WelcomePageWeb(uid: uid,);
        }
        if (sizingInformation.isTablet){
          return WelcomePageTablet(uid: uid,);
        }
        return WelcomePageMobile(uid: uid,);
      },
    );
  }
}
