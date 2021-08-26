import 'package:flutter/material.dart';
import 'package:plan_tasks/classes/task.dart';
import 'package:plan_tasks/database/helper_database.dart';
import 'package:plan_tasks/utils/colors.dart';
import 'package:plan_tasks/utils/validators.dart';
import 'package:plan_tasks/utils/utils.dart';
import 'package:plan_tasks/widgets/standard_button.dart';

// ignore: must_be_immutable
class AddTasksScreen extends StatefulWidget {
  Task? task;
  AddTasksScreen({this.task});

  @override
  _AddTasksScreenState createState() => _AddTasksScreenState();
}

class _AddTasksScreenState extends State<AddTasksScreen> {
  final _controllerTitle = TextEditingController();
  final _controllerDescription = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var _db = HelperDB();

  bool _taskChecked = false;
  bool _screenEdited = false;

  late Task _taskEdited;

  @override
  void initState() {
    super.initState();

    var aux = widget.task;
    var title;
    var description;
    var status;

    if (aux != null) {
      _taskEdited = Task.fromMap(aux.toMapWithId());
      _taskEdited.id = aux.id;

      title = _taskEdited.title;
      description = _taskEdited.description;
      status = _taskEdited.status;

      if (title != null) _controllerTitle.text = title;
      if (description != null) _controllerDescription.text = description;
      if (status != null) {
        _taskChecked = status == 0 ? false : true;
      }
    } else {
      _taskEdited = Task();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => requestAlertDialog(_screenEdited, context,
          'Descartar alterações?', 'As alterações serão perdidas.'),
      child: Scaffold(
        appBar: createAppBar('Adicionar tarefa'),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: _createBody(context),
        ),
      ),
    );
  }

  SingleChildScrollView _createBody(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Image.asset('assets/imgs/image1.png'),
              ),
            ),
            _createTextFormField(
              'Título',
              _controllerTitle,
              titleValidator,
              Icon(Icons.title),
              1,
            ),
            SizedBox(height: 16.0),
            _createTextFormField(
              'Descrição',
              _controllerDescription,
              descriptionValidator,
              Icon(Icons.description),
              2,
            ),
            _createSwitchListTile(),
            SizedBox(height: 26.0),
            Center(
              child: StandardButton(
                label: 'Salvar',
                onPressed: () {
                  _clickButton(context);
                },
                color: primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  TextFormField _createTextFormField(
    String labelTextInputDecoration,
    TextEditingController controller,
    Function validator,
    Icon icon,
    int maxLines,
  ) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        labelText: labelTextInputDecoration,
        labelStyle: fontStyle(),
        errorStyle: fontStyle(),
        suffixIcon: icon,
      ),
      keyboardType: TextInputType.text,
      style: fontStyle(),
      validator: (value) => validator(value),
      onChanged: (text) {
        _screenEdited = true;

        switch (labelTextInputDecoration) {
          case "Título":
            setState(() {
              _taskEdited.title = text;
            });
            break;
          case "Descrição":
            setState(() {
              _taskEdited.description = text;
            });
            break;
        }
      },
    );
  }

  TextStyle fontStyle() {
    return TextStyle(
      fontFamily: 'Nunito',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    );
  }

  SwitchListTile _createSwitchListTile() {
    return SwitchListTile(
      title: Text(
        'Concluída',
        style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: gray,
        ),
      ),
      contentPadding: EdgeInsets.only(left: 5.0),
      activeColor: secondaryColor,
      inactiveThumbColor: primaryColor,
      value: _taskChecked,
      onChanged: (bool value) {
        setState(
          () {
            _screenEdited = true;
            _taskChecked = value;
          },
        );
      },
    );
  }

  void _cleanFields() {
    setState(
      () {
        _controllerTitle.clear();
        _controllerDescription.clear();

        _taskChecked = false;
        _screenEdited = false;

        _taskEdited.title = null;
        _taskEdited.description = null;
        _taskEdited.status = null;
      },
    );
  }

  _clickButton(BuildContext context) async {
    bool formOK = _formKey.currentState!.validate();

    if (!formOK) {
      return;
    }

    _taskEdited.status = _taskChecked ? 1 : 0;

    if (widget.task == null) {
      await _db.saveTask(_taskEdited);
      FocusScope.of(context).offset;
      _cleanFields();
    } else {
      await _db.editTask(_taskEdited);
      Navigator.pop(context);
    }
  }
}
