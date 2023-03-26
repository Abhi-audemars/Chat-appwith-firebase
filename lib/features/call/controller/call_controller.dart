// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';

import 'package:whatsapp_ui/features/call/repositories/call_repository.dart';
import 'package:whatsapp_ui/models/call.dart';

final callControllerProvider = Provider((ref) {
  final callRepository = ref.read(callRepositoryProvider);
  return CallController(
    callRepository: callRepository,
    auth: FirebaseAuth.instance,
    ref: ref,
  );
});

class CallController {
  final CallRepository callRepository;
  final FirebaseAuth auth;
  final ProviderRef ref;
  CallController({
    required this.callRepository,
    required this.auth,
    required this.ref,
  });

  Stream<DocumentSnapshot> get callStream => callRepository.callStream;

  void makeCalls(
    BuildContext context,
    String receivername,
    String receiverUid,
    String receiverProfilePic,
    bool isGroupChat,
  ) {
    ref.read(userDataAuthProvider).whenData((value) {
      String callId = const Uuid().v1();
      Call senderCallData = Call(
        callerId: auth.currentUser!.uid,
        callerName: value!.name,
        receiverId: receiverUid,
        callerPic: value.profilePic,
        receiverName: receivername,
        receiverPic: receiverProfilePic,
        callId: callId,
        hasDialled: true,
      );

      Call receiverrCallData = Call(
        callerId: auth.currentUser!.uid,
        callerName: value.name,
        receiverId: receiverUid,
        callerPic: value.profilePic,
        receiverName: receivername,
        receiverPic: receiverProfilePic,
        callId: callId,
        hasDialled: false,
      );
      if (isGroupChat) {
        callRepository.makeGroupCalls(
            context, senderCallData, receiverrCallData);
      } else {
        callRepository.makeCalls(context, senderCallData, receiverrCallData); 
      }
    });
  }

  void endCall(BuildContext context, String callerId, String receiverId) {
    callRepository.endCalls(context, callerId, receiverId);
  }
}
