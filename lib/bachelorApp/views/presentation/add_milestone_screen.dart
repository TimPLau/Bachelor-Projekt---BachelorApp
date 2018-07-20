import 'package:flutter/material.dart';

class AddMilestoneScreen extends StatelessWidget {
  static final GlobalKey<FormFieldState<String>> _nameInputField = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _descriptionInputField = GlobalKey<FormFieldState<String>>();

  final Function(String, String) addMilestone;

  AddMilestoneScreen(this.addMilestone);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.red,
          title: new Text("Meilenstein hinzufügen"),
        ),
        body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            //key: _formKey,
              child: new ListView(
                children: <Widget>[
                  new TextFormField(
                    autofocus: true,
                    key: _nameInputField,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        hintText: 'Name des Meilenteins',
                        labelText: 'Meilensteinname'),
                    validator: (v){
                      return v.trim().isEmpty ? "Bitte bennene deinen neuen Meilenstein" : null;
                    },
                  ),
                  new TextFormField(
                    key: _descriptionInputField,
                    keyboardType: TextInputType.multiline,
                    decoration: new InputDecoration(
                        hintText: 'Beschreibung',
                        labelText: 'Beschreibung (optional)'),
                  ),
                  new FittedBox(
                      fit: BoxFit.contain,
                      child: new ButtonBar(
                        children: <Widget>[
                          new RaisedButton(
                            child: new Text("Abbrechen"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          new RaisedButton(
                            child: new Text("Annehmen"),
                            onPressed: () {
                              submit(context);
                            },
                          ),
                        ],
                      )
                  ),
                ],
              )),
        ));
  }


  void submit(context) {
    if (_nameInputField.currentState.validate()) {
      addMilestone(_nameInputField.currentState.value, _descriptionInputField.currentState.value);
      Navigator.pop(context);
    }
  }
}