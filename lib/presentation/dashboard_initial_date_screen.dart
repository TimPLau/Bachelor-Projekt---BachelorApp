import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:intl/intl.dart';

class AddEditBeginEndDateScreen extends StatefulWidget {
  final Function(DateTime, DateTime) addEditDate;
  final DateTime initialBeginDate;
  final DateTime initialEndDate;
  final bool isEditing;
  final DateTime beginDate;
  final DateTime endDate;

  AddEditBeginEndDateScreen(this.addEditDate, this.initialBeginDate,
      this.initialEndDate, this.isEditing,
      [this.beginDate, this.endDate]);

  @override
  AddEditBeginEndDateForm createState() => new AddEditBeginEndDateForm();
}

class AddEditBeginEndDateForm extends State<AddEditBeginEndDateScreen> {
  final _beginDateInputController = new TextEditingController();
  final _endDateInputController = new TextEditingController();

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime chosenBeginDate;
  DateTime chosenEndDate;

  @override
  void initState() {
    chosenBeginDate = ((widget.isEditing)
        ? this.widget.beginDate
        : this.widget.initialBeginDate);

    chosenEndDate =
        ((widget.isEditing) ? this.widget.endDate : this.widget.initialEndDate);

    _beginDateInputController.text = this.widget.isEditing
        ? DateFormat.yMd().format(this.widget.beginDate)
        : new DateFormat.yMd().format(chosenBeginDate);

    _endDateInputController.text = this.widget.isEditing
        ? DateFormat.yMd().format(this.widget.endDate)
        : new DateFormat.yMd().format(chosenEndDate);

    super.initState();
  }

  @override
  void dispose() {
    _beginDateInputController.dispose();
    _endDateInputController.dispose();
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
                "BESTÄTIGEN",
                style: TextStyle(color: Colors.white),
              ))
        ],
        backgroundColor: Theme.of(context).bottomAppBarColor,
        title: new Text(this.widget.isEditing
            ? "Zeitraum".toUpperCase()
            : "Zeitraum".toUpperCase()),
      ),
      body: new Container(
          padding: EdgeInsets.all(30.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new InkWell(
                onTap: () {
                  setBeginDate(context, widget.initialBeginDate);
                },
                child: buildDateSetterCard(
                    "Bearbeitungszeitraum (Begin)",
                    _beginDateInputController,
                    "Datum des Begins",
                    "MM/DD/YYYY"),
              ),
              new InkWell(
                onTap: () {
                  setEndDate(context, widget.initialEndDate);
                },
                child: buildDateSetterCard(
                    "Bearbeitungszeitraum (Ende)",
                    _endDateInputController,
                    "Datum des Begins",
                    "MM/DD/YYYY"),
              ),
            ],
          )),
    );
  }

  Card buildDateSetterCard(String title, TextEditingController controller,
      String hintText, String labelText) {
    return new Card(
      elevation: 2.0,
      child: new Container(
          padding: EdgeInsets.all(20.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                child: new Text(title,style: TextStyle(fontSize: 20.0),),
              ),
              new Row(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new Icon(Icons.date_range),
                  ),
                  new Expanded(
                    child: new TextFormField(
                      enabled: false,
                      controller: controller,
                      // key: _nameInputField,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                          hintText: hintText, labelText: labelText),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  void setBeginDate(BuildContext context, DateTime initialDate) async {
    DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 1, DateTime.now().month));

    setState(() {
      chosenBeginDate = (pickedDate == null) ? chosenBeginDate : pickedDate;
      _beginDateInputController.text =
          new DateFormat.yMd().format(chosenBeginDate);
    });
  }

  void setEndDate(BuildContext context, DateTime initialDate) async {
    DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 1, DateTime.now().month));

    setState(() {
      chosenEndDate = (pickedDate == null) ? chosenEndDate : pickedDate;
      _endDateInputController.text = new DateFormat.yMd().format(chosenEndDate);
    });
  }

  void submit(context) {
    widget.addEditDate(chosenBeginDate, chosenEndDate);

    Navigator.of(context).pushNamed("/");
  }
}
