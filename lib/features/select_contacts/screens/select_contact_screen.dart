import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_ui/common/widgets/error_screen.dart';
import 'package:whatsapp_ui/common/widgets/loader.dart';
import 'package:whatsapp_ui/features/select_contacts/repository/elect_contact_controller.dart';

class SelectContactScreen extends ConsumerWidget {
  static const String routeName = '/selectContact';
  const SelectContactScreen({Key? key}) : super(key: key);

  void selectContact(
      WidgetRef ref, Contact selectedContact, BuildContext context) {
    ref
        .read(selectContactControllerProvider)
        .selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contacts'),
        backgroundColor: const Color.fromARGB(255, 61, 40, 65),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.deepPurple.withOpacity(0.15),
              ),
            ),
          ),
        ],
      ),
      body: ref.watch(getContactsProvider).when(
          data: (contactList) => ListView.builder(
                itemCount: contactList.length,
                itemBuilder: (context, index) {
                  final contact = contactList[index];
                  return InkWell(
                    onTap: () => selectContact(ref, contact, context),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(
                          contact.displayName,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                        ),
                        leading: contact.photo == null
                            ? null
                            : CircleAvatar(
                                backgroundImage: MemoryImage(contact.photo!),
                                radius: 30,
                              ),
                      ),
                    ),
                  );
                },
              ),
          error: (err, st) {
            return ErrorScreen(error: err.toString());
          },
          loading: () => const Loader()),
    );
  }
}
