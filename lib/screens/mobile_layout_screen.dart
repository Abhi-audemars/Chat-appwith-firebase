import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/features/call/screens/call_logs_screen.dart';
import 'package:whatsapp_ui/features/group/screens/create_group_screen.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_ui/features/landing_screen.dart';
import 'package:whatsapp_ui/features/chat/widgets/contacts_list.dart';
import 'package:whatsapp_ui/features/select_contacts/screens/select_contact_screen.dart';
import 'package:whatsapp_ui/features/status/screens/status_contacts.dart';

class MobileLayoutScreen extends ConsumerStatefulWidget {
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<MobileLayoutScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  void logout() {
    ref.read(authControllerProvider).logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(101, 10, 9, 9),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 61, 40, 65),
          centerTitle: false,
          title: Text(
            'myChat',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SelectContactScreen.routeName);
              },
              icon:const Icon(Icons.add),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.deepPurple.withOpacity(0.15),
                ),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.15),
                  borderRadius: const BorderRadius.all(Radius.circular(50))),
              child: PopupMenuButton(
                color: appBarColor,
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text(
                      'New Group',
                    ),
                    onTap: () => Future(
                      () => Navigator.pushNamed(
                          context, CreateGroupScreen.routeName),
                    ),
                  ),
                  PopupMenuItem(
                    child: const Text(
                      'Logout',
                    ),
                    onTap: () {
                      logout();
                      Future(
                        () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LandingScreen()),
                            (route) => false),
                      );
                    },
                  ),
                  PopupMenuItem(
                      child: const Text(
                        'Linked Devices',
                      ),
                      onTap: () {}),
                  PopupMenuItem(
                      child: const Text(
                        'Starred Messages',
                      ),
                      onTap: () {}),
                  PopupMenuItem(
                      child: const Text(
                        'Payments',
                      ),
                      onTap: () {}),
                  PopupMenuItem(
                      child: const Text(
                        'Settings',
                      ),
                      onTap: () {}),
                ],
              ),
            ),
          ],
          bottom: TabBar(
            controller: tabController,
            indicatorColor: Colors.white,
            indicatorWeight: 4,
            labelColor: tabColor,
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: GoogleFonts.poppins(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
            ),
            labelStyle: GoogleFonts.poppins(
                textStyle:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            tabs: const [
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'STATUS',
              ),
              Tab(
                text: 'CALLS',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            ContactsList(),
            StatusContactsScreen(),
            CallLogScreen(),
          ],
        ),
      ),
    );
  }
}
