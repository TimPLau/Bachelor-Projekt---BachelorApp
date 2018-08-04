import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:intl/intl.dart';
import 'package:project_bachelorapplication/views/containers/milestone_tool_milestone_details.dart';

class AddEditMilestoneScreen extends StatefulWidget {
  final Function(String, DateTime, String) addEditMilestone;
  final List<Milestone> milestones;
  final initialDate;
  final bool isEditing;
  final Milestone editMilestone;

  AddEditMilestoneScreen(
      this.addEditMilestone, this.milestones, this.initialDate, this.isEditing,
      [this.editMilestone]);

  @override
  AddEditMilestoneForm createState() => new AddEditMilestoneForm();
}

class AddEditMilestoneForm extends State<AddEditMilestoneScreen> {
  final _dateInputController = new TextEditingController();

  static final GlobalKey<FormFieldState<String>> _nameInputField =
      GlobalKey<FormFieldState<String>>();
  static final TextEditingController _nameInputController =
      new TextEditingController();

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static final GlobalKey<FormFieldState<String>> _descriptionInputField =
      GlobalKey<FormFieldState<String>>();
  static final TextEditingController _descriptionInputController =
      new TextEditingController();

  DateTime chosenDate;

  @override
  void initState() {
    chosenDate = ((widget.isEditing)
        ? this.widget.editMilestone.date
        : this.widget.initialDate);
    _nameInputController.text =
        this.widget.isEditing ? this.widget.editMilestone.title : "";
    _dateInputController.text = this.widget.isEditing
        ? DateFormat.yMd().format(this.widget.editMilestone.date)
        : new DateFormat.yMd().format(chosenDate);
    _descriptionInputController.text =
        this.widget.isEditing ? this.widget.editMilestone.description : "";

    super.initState();
  }

  @override
  void dispose() {
    _dateInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  submit(context);
                },
                child: new Text(
                  this.widget.isEditing ? "ÜBERNEHMEN" : "HINZUFÜGEN",
                  style: TextStyle(color: Colors.white),
                ))
          ],
          backgroundColor: Theme.of(context).bottomAppBarColor,
          title: new Text(this.widget.isEditing
              ? "Meilenstein bearbeiten"
              : "Meilenstein hinzufügen"),
        ),
        body: new Container(
            padding: EdgeInsets.all(20.0),
            child: new Form(
              key: _formKey,
              child: new ListView(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(right: 15.0),
                        child: new Icon(Icons.local_play),
                      ),
                      new Expanded(
                        child: new TextFormField(
                          controller: _nameInputController,
                          key: _nameInputField,
                          keyboardType: TextInputType.text,
                          maxLength: 60,
                          decoration: new InputDecoration(
                              hintText: 'Name des Meilenteins',
                              labelText: 'Meilensteinname'),
                          validator: (v) {
                            return v.trim().isEmpty
                                ? "Bitte gib einen Namen ein"
                                : null;
                          },
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    //padding: EdgeInsets.only(top: 20.0),
                    child: new InkWell(
                      onTap: () {
                        setDate(context);
                      },
                      child: new Row(
                        children: <Widget>[
                          new Container(
                            padding: EdgeInsets.only(right: 15.0),
                            child: new Icon(Icons.date_range),
                          ),
                          new Expanded(
                            child: new TextFormField(
                              enabled: false,
                              controller: _dateInputController,
                              // key: _nameInputField,
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                  hintText: 'Datum des Meilenteins',
                                  labelText: 'MM/DD/YYYY'),
                              validator: (v) {
                                return v.trim().isEmpty
                                    ? "Bitte gib einen Namen ein"
                                    : null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Row(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(right: 15.0),
                        child: new Icon(Icons.description),
                      ),
                      new Expanded(
                        child: new TextFormField(
                          controller: _descriptionInputController,
                          key: _descriptionInputField,
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                              hintText: 'Beschreibung',
                              labelText: 'Beschreibung (optional)'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  void setDate(context) async {
    DateTime pickedDate = await showDatePicker(
        context: context,
        selectableDayPredicate: (t) =>
            !(widget.milestones.map((m) => m.date.toUtc())).contains(t.toUtc()),
        initialDate: widget.initialDate,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 1, DateTime.now().month));

    setState(() {
      chosenDate = (pickedDate == null) ? chosenDate : pickedDate;
      _dateInputController.text = new DateFormat.yMd().format(chosenDate);
    });
  }

  void submit(context) {
    if (_formKey.currentState.validate()) {
      widget.addEditMilestone(_nameInputField.currentState.value, chosenDate,
          _descriptionInputField.currentState.value);

      setState(() {
        chosenDate = widget.initialDate;
      });

      Navigator.pop(this.context);
      Navigator.pop(this.context);

    }
  }
}
