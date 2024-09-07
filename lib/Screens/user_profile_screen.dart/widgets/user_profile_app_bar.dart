import 'package:be_glamourous/providers/screen_change_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class UserProfileAppBar extends StatefulWidget {
  const UserProfileAppBar({super.key});

  @override
  State<UserProfileAppBar> createState() => _UserProfileAppBarState();
}

class _UserProfileAppBarState extends State<UserProfileAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  String _username = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _fetchCredentials();
  }

  Future<void> _fetchCredentials() async {
    _username = await _secureStorage.read(key: 'userName') ?? 'User';
    _email = await _secureStorage.read(key: 'email') ?? 'email@example.com';
    setState(() {}); // Refresh the widget with fetched data
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenIndexProvider = Provider.of<ScreenChangeProvider>(context);

    if (screenIndexProvider.screenId == 3) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    _controller.reset();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1), () {
        if (mounted) {
          _controller.forward();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 12, left: 14, bottom: 12),
          decoration: const BoxDecoration(
            color: Color.fromARGB(60, 0, 0, 0),
          ),
          child: const SafeArea(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Be Glamourous',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Jura',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _animation,
          axisAlignment: -1.0,
          child: Container(
            // height: 240.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
              color: Color.fromARGB(60, 0, 0, 0),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                Image.asset(
                  'assets/images/default_profile_icon.png',
                  alignment: Alignment.center,
                ),
                const SizedBox(height: 10),
                Text(
                  _username,
                  style: const TextStyle(
                    fontFamily: 'Jura',
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _email,
                  style: const TextStyle(
                    fontFamily: 'Jura',
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
