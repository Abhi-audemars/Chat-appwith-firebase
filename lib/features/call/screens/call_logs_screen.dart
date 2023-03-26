import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CallLogScreen extends ConsumerStatefulWidget {
  const CallLogScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallLogScreenState();
}

class _CallLogScreenState extends ConsumerState<CallLogScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 15),
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Color.fromARGB(255, 61, 40, 65),
            child: Icon(
              Icons.link,
              color: Colors.white,
            ),
          ),
          title: Text(
            'Create call link',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
          ),
          subtitle: Text('Share a link for your myChat call'),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, left: 18),
          child: Text(
            'Recent',
            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        )
      ],
    );
  }
}
