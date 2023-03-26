// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/widgets/details_screen.dart';
import 'package:whatsapp_ui/common/widgets/loader.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_ui/features/call/controller/call_controller.dart';
import 'package:whatsapp_ui/features/chat/widgets/bottom_chat_field.dart';
import 'package:whatsapp_ui/features/chat/widgets/chat_list.dart';
import 'package:whatsapp_ui/models/user_model.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  final bool isGroupChat;
  final String profilePic;
  const MobileChatScreen({
    Key? key,
    required this.name,
    required this.uid,
    required this.isGroupChat,
    required this.profilePic,
  }) : super(key: key);

  void makeCall(WidgetRef ref, BuildContext context) {
    ref
        .read(callControllerProvider)
        .makeCalls(context, name, uid, profilePic, isGroupChat);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 30, 31),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 61, 40, 65),
        title: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, DetailsScreen.routeName, arguments: {
              'name': name,
              'uid': uid,
              'isGroupChat': isGroupChat,
              'profilePic': profilePic,
            });
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: isGroupChat
                    ? NetworkImage(
                        profilePic,
                      )
                    : NetworkImage(
                        profilePic,
                      ),
              ),
              const SizedBox(width: 8),
              isGroupChat
                  ? Text(name)
                  : StreamBuilder<UserModel>(
                      stream:
                          ref.read(authControllerProvider).userDataById(uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Loader();
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name),
                            Text(
                              snapshot.data!.isOnline ? 'Online' : 'offline',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        );
                      }),
            ],
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.transparent,
                border: Border.all(
                  color: const Color.fromARGB(31, 179, 176, 176),
                ),
              ),
              child: IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.deepPurple.withOpacity(0.15),
                  ),
                ),
                onPressed: () => makeCall(ref, context),
                icon: Icon(
                  Icons.video_call,
                  color: Colors.green[100],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: NetworkImage('https://wallpapercave.com/dwp2x/wp4410731.jpg'),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ChatList(
                receiverUserId: uid,
                isGroupChat: isGroupChat,
              ),
            ),
            BottomChatField(receiverUserId: uid, isGroupChat: isGroupChat),
          ],
        ),
      ),
    );
  }
}
