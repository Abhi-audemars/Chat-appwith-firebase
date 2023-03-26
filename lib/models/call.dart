import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Call {
  final String callerId;
  final String callerName;
  final String receiverId;
  final String callerPic;
  final String receiverName;
  final String receiverPic;
  final String callId;
  final bool hasDialled;
  Call({
    required this.callerId,
    required this.callerName,
    required this.receiverId,
    required this.callerPic,
    required this.receiverName,
    required this.receiverPic,
    required this.callId,
    required this.hasDialled,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'callerId': callerId,
      'callerName': callerName,
      'receiverId': receiverId,
      'callerPic': callerPic,
      'receiverName': receiverName,
      'receiverPic': receiverPic,
      'callId': callId,
      'hasDialled': hasDialled,
    };
  }

  factory Call.fromMap(Map<String, dynamic> map) {
    return Call(
      callerId: map['callerId'] as String,
      callerName: map['callerName'] as String,
      receiverId: map['receiverId'] as String,
      callerPic: map['callerPic'] as String,
      receiverName: map['receiverName'] as String,
      receiverPic: map['receiverPic'] as String,
      callId: map['callId'] as String,
      hasDialled: map['hasDialled'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Call.fromJson(String source) => Call.fromMap(json.decode(source) as Map<String, dynamic>);
}
