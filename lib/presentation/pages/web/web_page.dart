import 'package:flutter/material.dart';
import 'package:group_chat_room_responsive/presentation/pages/web/widgets/left_side_widget.dart';
import 'package:group_chat_room_responsive/presentation/pages/web/widgets/right_side_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WebPage extends StatelessWidget {
  final SizingInformation sizingInformation;

  const WebPage({Key key, this.sizingInformation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            LeftSideWidget(sizingInformation: sizingInformation,),
            Expanded(child: RightSideWidget(
              sizingInformation: sizingInformation,
            )),
          ],
        ),
      ),
    );
  }
}
