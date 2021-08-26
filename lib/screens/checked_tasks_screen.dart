import 'package:flutter/material.dart';
import 'package:plan_tasks/classes/task.dart';
import 'package:plan_tasks/database/helper_database.dart';
import 'package:plan_tasks/utils/colors.dart';
import 'package:plan_tasks/utils/utils.dart';
import 'add_tasks_screen.dart';

class CheckedTasksScreen extends StatefulWidget {
  @override
  _CheckedTasksScreenState createState() => _CheckedTasksScreenState();
}

class _CheckedTasksScreenState extends State<CheckedTasksScreen> {
  HelperDB _db = HelperDB();

  List<Task> _listCheckedTasks = [];

  @override
  void initState() {
    super.initState();

    _updateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar('Tarefas concluídas'),
      body: _listCheckedTasks.length > 0
          ? ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: _listCheckedTasks.length,
              itemBuilder: (context, index) {
                return taskCard(context, _listCheckedTasks, index,
                    _showTaskPage, _showOptions);
              },
            )
          : Container(
              child: Center(
                child: Text(
                  'Nenhuma tarefa concluída.',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: black,
                  ),
                ),
              ),
            ),
    );
  }

  void _updateList() {
    _db.listTasks(true).then(
      (list) {
        setState(
          () {
            if (list != null) {
              _listCheckedTasks = list;
              _listCheckedTasks.sort((a, b) {
                var titleA = a.title;
                var titleB = b.title;

                if (titleA != null && titleB != null) {
                  return titleA.toLowerCase().compareTo(titleB.toLowerCase());
                }

                return 0;
              });
            }
            ;
          },
        );
      },
    );
  }

  void _showTaskPage(Task task, BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTasksScreen(task: task),
      ),
    ).whenComplete(() {
      _updateList();
    });
  }

  void _showOptions(BuildContext context, int index, List<Task> tasks,
      Function _showTaskPage) {
    showModalBottomSheet(
      backgroundColor: primaryColor,
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.edit, color: Colors.white),
                    title: Text(
                      'Editar',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _showTaskPage(tasks[index], context);
                    }),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0),
                  child: Divider(
                    color: Colors.white,
                    thickness: 1.0,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.delete, color: Colors.white),
                  title: Text(
                    'Excluir',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: white,
                    ),
                  ),
                  onTap: () {
                    var currentId = tasks[index].id;
                    if (currentId != null) {
                      _db.removeTask(currentId);
                      tasks.removeAt(index);
                      _updateList();
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
