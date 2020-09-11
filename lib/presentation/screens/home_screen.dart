import 'package:flutter/material.dart';
import 'package:group_chat_room_responsive/presentation/pages/mobile/mobile_page.dart';
import 'package:group_chat_room_responsive/presentation/pages/tablet/tablet_page.dart';
import 'package:group_chat_room_responsive/presentation/pages/web/web_page.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context,sizingInformation){
        if (sizingInformation.isDesktop){
          return WebPage(sizingInformation: sizingInformation,);
        }
        if (sizingInformation.isTablet){
          return TabletPage();
        }
        return MobilePage();
      },
    );
  }
}
