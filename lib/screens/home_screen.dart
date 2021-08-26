import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plan_tasks/screens/add_tasks_screen.dart';
import 'package:plan_tasks/screens/checked_tasks_screen.dart';
import 'package:plan_tasks/screens/tasks_screen.dart';
import 'package:plan_tasks/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indexSelected = 0;

  List<Widget> _optionsScreens = <Widget>[
    AddTasksScreen(),
    TasksScreen(),
    CheckedTasksScreen(),
  ];

  void _onScreenSelected(int index) {
    setState(() {
      _indexSelected = index;
    });
  }

  BottomNavigationBarItem _createBottomNavigationBarItem(
      IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      // ignore: deprecated_member_use
      title: Text(
        label,
        style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _optionsScreens.elementAt(_indexSelected),
      ),
      bottomNavigationBar: _criarBottomNavigationBar(),
      backgroundColor: primaryColor,
    );
  }

  BottomNavigationBar _criarBottomNavigationBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        _createBottomNavigationBarItem(Icons.add, "Adicionar"),
        _createBottomNavigationBarItem(
            Icons.check_box_outline_blank, "Pendentes"),
        _createBottomNavigationBarItem(Icons.check_box_outlined, "Concluídas"),
      ],
      currentIndex: _indexSelected,
      selectedItemColor: secondaryColor,
      unselectedItemColor: white,
      backgroundColor: primaryColor,
      onTap: _onScreenSelected,
    );
  }
}
