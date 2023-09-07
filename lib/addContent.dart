import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddContent extends StatefulWidget {
  final TextEditingController tc01 = new TextEditingController();
  final TextEditingController tc02 = new TextEditingController();
  final firestore = FirebaseFirestore.instance;


  @override
  _AddContentState createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  int index = -1;
  bool isMinus = true;

  setIndex(value) {
    setState(() {
      index = value;
    });
  }

  setIsMinus() {
    setState(() {
      if(isMinus)
        isMinus = false;
      else
        isMinus = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Hozzáadás"),
      ),
      body: Center(
        child: Column(
          children: [
            PopUp(context, index, setIndex, widget.tc01, widget.tc02, setIsMinus, isMinus,
                widget.firestore)
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}

Widget PopUp(context, int index, vc, tc01, tc02, setIsMinus, isMinus, firestore) {
  return Flexible(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).disabledColor,
            blurRadius: 5,
            spreadRadius: 0,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: Center(
        child: Column(
          children: [
            Text("Ki vagy?"),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    value: 0,
                    groupValue: index,
                    onChanged: vc,
                    title: Text("P1"),
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    value: 1,
                    groupValue: index,
                    onChanged: vc,
                    title: Text("P2"),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    value: 2,
                    groupValue: index,
                    onChanged: vc,
                    title: Text("P3"),
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    value: 3,
                    groupValue: index,
                    onChanged: vc,
                    title: Text("P4"),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Container(
              child: TextField(
                decoration:
                    InputDecoration(hintText: "Mit szeretnél feljegyezni?"),
                controller: tc01,
              ),
              width: MediaQuery.of(context).size.width / 3 * 2,
            ),
            Container(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Milyen összegben?"),
                controller: tc02,
              ),
              width: MediaQuery.of(context).size.width / 3 * 2,
            ),
            Padding(
              child: Text("Kiadás vagy bevétel?"),
              padding: EdgeInsets.only(top: 20, bottom: 10),
            ),
            MinusToggler(setIsMinus, isMinus),
            ElevatedButton(
                onPressed: () {
                  switch (index) {
                    case 0:
                      Send().init("p1", tc01.text, int.parse(tc02.text),
                          isMinus, firestore);
                      break;
                    case 1:
                      Send().init("p2", tc01.text, int.parse(tc02.text),
                          isMinus, firestore);
                      break;
                    case 2:
                      Send().init("p3", tc01.text, int.parse(tc02.text),
                          isMinus, firestore);
                      break;
                    case 3:
                      Send().init("p4", tc01.text, int.parse(tc02.text),
                          isMinus, firestore);
                      break;
                  }
                  Navigator.pop(context);
                },
                child: Text("Feljegyzés"))
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      width: MediaQuery.of(context).size.width / 5 * 4,
      height: MediaQuery.of(context).size.height / 3 * 2,
    ),
  );
}

class Send {
  init(String account, String text, int value, bool isMinus, firestore) {
    firestore.collection('items').add({
      "user": account,
      "text": text,
      "value": value,
      "date": DateTime.now(),
      "isMinus": isMinus,
    });
  }
}

Widget MinusToggler(setIsMinus, bool isMinus) {
  return Column(
    children: [
      Row(
        children: [
          ElevatedButton(
            onPressed: isMinus
                ? setIsMinus
                : null,
            child: Icon(Icons.add_circle),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green)),
          ),
          ElevatedButton(
            onPressed: !isMinus
                ? setIsMinus
                : null,
            child: Icon(
              Icons.remove_circle,
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      Text(
        isMinus ? "(Kiadás)" : "(Bevétel)",
        style: TextStyle(fontSize: 13),
      ),
    ],
  );
}