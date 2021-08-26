import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plan_tasks/classes/task.dart';
import 'package:plan_tasks/widgets/alert_box.dart';
import 'colors.dart';

Widget taskCard(BuildContext context, List<Task> tasks, int index,
    Function _showTaskPage, Function _showOptions) {
  return GestureDetector(
    child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                child: tasks[index].status == 1
                    ? Icon(
                        Icons.check_box_outlined,
                        color: secondaryColor,
                      )
                    : Icon(
                        Icons.check_box_outline_blank,
                        color: primaryColor,
                      ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    tasks[index].title!,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      color: black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        color: Colors.white,
        shadowColor: Colors.blueGrey[900],
        elevation: 15),
    onTap: () {
      _showOptions(context, index, tasks, _showTaskPage);
    },
  );
}

Future<bool> requestAlertDialog(bool paginaEditada, BuildContext context,
    String title, String message) async {
  if (paginaEditada) {
    alertBox(context, title, message);
    return Future.value(false);
  } else {
    return Future.value(true);
  }
}

AppBar createAppBar(String labelText) {
  return AppBar(
    title: Text(
      labelText,
      style: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: white,
      ),
    ),
    centerTitle: true,
    iconTheme: IconThemeData(
      color: white,
    ),
  );
}
