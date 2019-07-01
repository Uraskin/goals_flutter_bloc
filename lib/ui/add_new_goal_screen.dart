import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goals/resources/colors.dart';
import 'package:goals/resources/res.dart';
import 'package:intl/intl.dart';

typedef OnCreateCallback = Function(String name, DateTime date);

class AddNewGoalScreen extends StatefulWidget {
  final OnCreateCallback onCreate;

  AddNewGoalScreen({Key key, this.onCreate}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddNewGoalScreenState();
}

class _AddNewGoalScreenState extends State<AddNewGoalScreen> {
  String _name;
  DateTime _date;

  TextEditingController _dateTextController = TextEditingController();

  OnCreateCallback get onCreate => widget.onCreate;

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.grey,
      title: SafeArea(
        child: Text(AppStrings.newGoalTitle),
      ),
      elevation: 0,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                style: TextStyle(color: AppColors.white),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColors.orange, width: 2.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintStyle: TextStyle(color: AppColors.white),
                  hintText: AppStrings.hintGoalName,
                ),
                validator: (val) {
                  return val.trim().isEmpty
                      ? AppStrings.erorEmptyGoalName
                      : null;
                },
                onSaved: (value) => _name = value,
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: () => _selectDate(),
                child: IgnorePointer(
                  child: TextFormField(
                    style: TextStyle(color: AppColors.white),
                    controller: _dateTextController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.orange, width: 2.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      hintText: AppStrings.hintGoalDate,
                      hintStyle: TextStyle(color: AppColors.white),
                    ),
                    validator: (val) {
                      return val.trim().isEmpty
                          ? AppStrings.erorEmptyGoalDate
                          : null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: _buildSaveButton(),
              )
            ],
          )),
    );
  }

  Widget _buildSaveButton() {
    return FlatButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        color: AppColors.orange,
        child: Text(
          AppStrings.buttonSave,
          style: TextStyle(color: AppColors.white),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            onCreate(_name, _date);
            Navigator.pop(context);
          }
        });
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return FittedBox(
            child: Theme(
              child: child,
              data: ThemeData(primaryColor: AppColors.orange),
            ),
          );
        });
    if (picked != null)
      setState(() {
        _dateTextController.text = DateFormat("dd.MM.yyyy").format(picked);
        _date =
            DateTime(picked.year, picked.month, picked.day, 23, 59, 59, 999);
        print(_date);
      });
  }
}
