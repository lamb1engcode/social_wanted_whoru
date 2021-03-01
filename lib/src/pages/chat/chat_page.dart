import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:whoru/src/common/styles.dart';
import 'package:whoru/src/data/chat.dart';
import 'package:whoru/src/pages/chat/widgets/active_friend_card.dart';
import 'package:whoru/src/pages/chat/widgets/message_card.dart';

import '../../common/styles.dart';

class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: mC,
        height: _size.height,
        width: _size.width,
        padding: EdgeInsets.only(left: 16.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _size.height / 19.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: _size.width / 16.8,
                    color: colorTitle,
                    fontFamily: 'Lato-Bold',
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: mC,
                    boxShadow: [
                      BoxShadow(
                        color: mCD,
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      ),
                      BoxShadow(
                        color: mCL,
                        offset: Offset(-2, -2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    Feather.search,
                    color: colorDarkGrey,
                    size: _size.width / 20.5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.0),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.only(top: .0),
                  itemCount: chats.length + 2,
                  itemBuilder: (context, index) {
                    return index == 0
                        ? Column(
                            children: [
                              _buildActiveFriend(context),
                              SizedBox(height: 16.0),
                            ],
                          )
                        : index == 1
                            ? Column(
                                children: [
                                  _buildTitle(context, 'Pinned'),
                                  ListView.builder(
                                    padding: EdgeInsets.only(top: 8.0),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () => Get.toNamed('/room'),
                                        child: MessageCard(
                                          pendingMessage:
                                              chats[3].pendingMessage,
                                          urlToImage: chats[3].image,
                                          fullName: chats[3].fullName,
                                          lastMessage: chats[3].lastMessage,
                                          time: chats[3].time,
                                          notification: chats[3].notification,
                                          blurHash: chats[3].blurHash,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 12.5),
                                  _buildTitle(context, 'Recent Conversation'),
                                  SizedBox(height: 8.0),
                                ],
                              )
                            : Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => Get.toNamed('/room'),
                                    child: MessageCard(
                                      pendingMessage:
                                          chats[index - 2].pendingMessage,
                                      urlToImage: chats[index - 2].image,
                                      fullName: chats[index - 2].fullName,
                                      lastMessage: chats[index - 2].lastMessage,
                                      time: chats[index - 2].time,
                                      notification:
                                          chats[index - 2].notification,
                                      blurHash: chats[index - 2].blurHash,
                                    ),
                                  )
                                ],
                              );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(context, title) {
    final _size = MediaQuery.of(context).size;
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: colorDarkGrey,
            fontSize: _size.width / 26.5,
            fontWeight: FontWeight.w600,
            fontFamily: 'Lato',
          ),
        ),
        SizedBox(width: 12.0),
        title == 'Pinned'
            ? Padding(
                padding: EdgeInsets.only(bottom: 2.0),
                child: Icon(
                  LineAwesomeIcons.thumb_tack,
                  color: fCD,
                  size: _size.width / 22.5,
                ),
              )
            : Container(),
      ],
    );
  }

  Widget _buildActiveFriend(context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: _size.width * .22,
      width: _size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: chats.length - 1,
        itemBuilder: (context, index) {
          return ActiveFriendCard(
            urlToImage: chats[index + 1].image,
            fullName: chats[index + 1].fullName,
            blurHash: chats[index + 1].blurHash,
          );
        },
      ),
    );
  }
}
