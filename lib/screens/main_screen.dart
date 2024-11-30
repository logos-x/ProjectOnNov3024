import 'package:buoi4/screens/account_screen.dart';
import 'package:buoi4/screens/home_screen.dart';
import 'package:buoi4/screens/market_screen.dart';
import 'package:buoi4/screens/video_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<String> _videoAssets = [
    'assets/videos/sample.mp4',
    'assets/videos/sample2.mp4',
    'assets/videos/sample.mp4',
    'assets/videos/sample2.mp4',
  ];

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    // Khởi tạo _screens trong initState()
    _screens = [
      const HomeScreen(),
      VideoScreen(videos: _videoAssets, initialIndex: 0),
      const AccountScreen(),
      MarketScreen(),
    ];
  }



  // Custom function to change the active and inactive colors for the BottomNavigationBar
  Color _getIconColor(int index) {
    return _currentIndex == index ? Colors.blue : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 1) {  // If Video Screen is tapped, set the right video asset
              // Use a sample asset or a dynamic asset depending on your logic
              _screens[1] = VideoScreen(videos: _videoAssets, initialIndex: 0);
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _getIconColor(0)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library, color: _getIconColor(1)),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: _getIconColor(2)),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: _getIconColor(3)),
            label: 'Market',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        elevation: 10,
      ),
    );
  }
}
