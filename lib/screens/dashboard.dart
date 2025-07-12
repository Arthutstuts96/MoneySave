import 'package:flutter/material.dart';
import 'package:moneysave/screens/account_screen.dart';
import 'package:moneysave/screens/exit_screen.dart';
import 'package:moneysave/screens/expenses_screen.dart';
import 'package:moneysave/screens/home_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> routes = <Widget>[
    HomeScreen(),
    AccountScreen(),
    ExpensesScreen(),
    ExitScreen(),
  ];

  final List<BottomNavigationBarItem> navBarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home_rounded),
      label: "Home",
      backgroundColor: Colors.green[800],
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.wallet),
      label: "Conta",
      backgroundColor: Colors.purple[600],
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.credit_card),
      label: "Gastos",
      backgroundColor: Colors.red,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.exit_to_app_rounded),
      label: "Sair",
      backgroundColor: Colors.blue,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: routes,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: navBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 24,
        selectedFontSize: 20,
      ),
    );
  }
}
