import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/widgets/utils/utils.dart';
import 'package:whatsapp_ui/features/group/controller/group_controller.dart';
import 'package:whatsapp_ui/features/group/widgets/select_contact_widget.dart';

class CreateGroupScreen extends ConsumerStatefulWidget {
  static const String routeName = '/create-group-screen';
  const CreateGroupScreen({super.key});

  @override
  ConsumerState<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends ConsumerState<CreateGroupScreen> {
  final groupnameCntroler = TextEditingController();
  File? image;
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    groupnameCntroler.dispose();
  }

  void createGroup() {
    if (groupnameCntroler.text.isNotEmpty && image != null) {
      ref.read(groupControllerProvider).createGroup(
          context,
          groupnameCntroler.text.trim(),
          image!,
          ref.read(selectGroupContactsPro));
      ref.read(selectGroupContactsPro.notifier).update((state) => []);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Group'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Stack(
              children: [
                image == null
                    ? const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://lh3.googleusercontent.com/a/ALm5wu0aFv3W43pFWfhi7wl2DM5pUerbVqPDiw7HNCHQRQ=s96-c'),
                        radius: 64,
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(image!),
                        radius: 64,
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo_outlined)),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: groupnameCntroler,
                decoration: const InputDecoration(hintText: 'Enter Group Name'),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 10),
              child: const Text(
                'Select Contacts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SelectContactGroup()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createGroup,
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
