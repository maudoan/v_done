import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';
import 'package:v_done/src/shared/app_route.dart';
import 'package:v_live1/v_live.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final _controller = CupertinoTabController();
  int _currentIndex = 0;
  static final List<Widget> _widgetOptions = [
    const CreateLiveScreen(),
    const WatchLiveScreen(),
  ];

  static final List<GlobalKey<NavigatorState>> _tabNavKey = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('V DONE'),
      ),
      body: CupertinoTabScaffold(
        resizeToAvoidBottomInset: false,
        tabBar: CupertinoTabBar(
          backgroundColor: const Color(0xFFF2F2F9).withOpacity(0.8),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(OneIcons.ic_home_border),
              activeIcon: const SvgGradient(OneIcons.ic_home),
              label: 'Tạo Live',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(OneIcons.ic_notifications_border),
              activeIcon: const SvgGradient(OneIcons.ic_notifications),
              label: 'Xem Live',
            ),
          ],
          onTap: (index) {
            if (index == _currentIndex) {
              _tabNavKey.elementAt(index).currentState?.popUntil((r) => r.isFirst);
            }
            _currentIndex = index;
          },
        ),
        controller: _controller,
        tabBuilder: (context, index) {
          return CupertinoTabView(
            navigatorKey: _tabNavKey.elementAt(index),
            builder: (BuildContext context) => _widgetOptions.elementAt(index),
            onGenerateRoute: AppRouteExt.generateRoute,
          );
        },
      ),
    );
  }
}
