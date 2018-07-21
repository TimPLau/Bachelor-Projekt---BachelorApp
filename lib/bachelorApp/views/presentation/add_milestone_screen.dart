import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';

DateTime chosenDate;

class AddMilestoneScreen extends StatelessWidget {
  static final GlobalKey<FormFieldState<String>> _nameInputField =
      GlobalKey<FormFieldState<String>>();

  static final GlobalKey<FormFieldState<String>> _descriptionInputField =
      GlobalKey<FormFieldState<String>>();

  static final GlobalKey<FormFieldState<String>> _dateInputField =
      GlobalKey<FormFieldState<String>>();

  static final TextEditingController _dateFieldController =
      new TextEditingController(text: "");

  final Function(String, DateTime, String) addMilestone;
  final List<Milestone> milestones;
  final initialDate;

  GlobalKey<EditableTextState> state = new GlobalKey<EditableTextState>();

  AddMilestoneScreen(this.addMilestone, this.milestones, this.initialDate);

  @override
  Widget build(BuildContext context) {

    chosenDate = initialDate;
    _dateFieldController.value = TextEditingValue(text: "${chosenDate.day}.${chosenDate.month}.${chosenDate.year}");

    return new Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  submit(context);
                },
                child: new Text(
                  "HINZUFÜGEN",
                  style: TextStyle(color: Colors.white),
                ))
          ],
          backgroundColor: Colors.red,
          title: new Text("Meilenstein hinzufügen"),
        ),
        body: new Container(
          padding: EdgeInsets.all(30.0),
          child: new ListView(
            children: <Widget>[
              new Container(
                child: new TextFormField(
                  autofocus: true,
                  key: _nameInputField,
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                      hintText: 'Name des Meilenteins',
                      labelText: 'Meilensteinname'),
                  validator: (v) {
                    return v.trim().isEmpty
                        ? "Bitte bennene deinen neuen Meilenstein"
                        : null;
                  },
                ),
              ),
              new Container(
                padding: EdgeInsets.only(top: 40.0),
                child: new InkWell(
                  onTap: () {
                    setDate(context);
                  },
                  child: new TextFormField(
                    enabled: false,
                    controller: _dateFieldController,
                    key: _dateInputField,
                    validator: (v) {
                      return v.trim().isEmpty
                          ? "Bitte weise dem Meilenstein ein Datum zu"
                          : null;
                    },
                    decoration: InputDecoration(
                        hintStyle: TextStyle(fontStyle: FontStyle.normal),
                        labelText: "Datum des Meilensteins",
                        labelStyle: TextStyle(color: Colors.black54),
                        hintText: _dateFieldController.text),
                  ),
                ),
              ),
              new Container(
                padding: EdgeInsets.only(top: 40.0),
                child: new TextFormField(
                  key: _descriptionInputField,
                  keyboardType: TextInputType.multiline,
                  decoration: new InputDecoration(
                      hintText: 'Beschreibung',
                      labelText: 'Beschreibung (optional)'),
                ),
              ),
            ],
          ),
        ));
  }

  void setDate(context) async {

    DateTime pickedDate = await showDatePicker(
        context: context,
        selectableDayPredicate: (t) => !(this.milestones.map((m) => m.date.toUtc())).contains(t.toUtc()),
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 1, DateTime.now().month));

    chosenDate = (pickedDate == null) ? chosenDate : pickedDate;

    _dateFieldController.value = TextEditingValue(text: "${chosenDate.day}.${chosenDate.month}.${chosenDate.year}");
  }

  void submit(context) {
    if (_nameInputField.currentState.validate() &&
        _dateInputField.currentState.validate()) {
      addMilestone(_nameInputField.currentState.value, chosenDate,
          _descriptionInputField.currentState.value);

      //_dateFieldController.clear();
      Navigator.pop(context);
    }
  }
}
