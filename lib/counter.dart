import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final String type;
  final int value;
  final bool isMinus;

  Counter(this.isMinus, this.type, this.value);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  Widget iconInit() {
    switch (widget.type) {
      case "home":
        return Icon(Icons.house);
      case "p1":
        return CircleAvatar(
          backgroundColor: Colors.pink[800],
          child: Text(
            "P1",
            style: TextStyle(color: Colors.white),
          ),
        );
      case "p2":
        return CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            "P2",
            style: TextStyle(color: Colors.white),
          ),
        );
      case "p2":
        return CircleAvatar(
          backgroundColor: Colors.pink,
          child: Text(
            "P3",
            style: TextStyle(color: Colors.white),
          ),
        );
      case "p4":
        return CircleAvatar(
          backgroundColor: Colors.green,
          child: Text(
            "P4",
            style: TextStyle(color: Colors.white),
          ),
        );
      default:
        return Icon(Icons.device_unknown);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            child: iconInit(),
            width: 25,
            height: 25,
          ),
          Padding(
            child: Text(
              widget.isMinus
                  ? "-" + widget.value.toString() + " Ft"
                  : widget.value.toString() + " Ft",
              style: TextStyle(color: Theme.of(context).shadowColor),
            ),
            padding: EdgeInsets.only(left: 5),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      width: 100,
    );
  }
}

/*Widget original() {
  return Container(
    child: Row(
      children: [
        Flexible(
          child: iconInit(),
          flex: 3,
        ),
        Flexible(
          child: Padding(
            child: Text(
              widget.isMinus
                  ? "-" + widget.value.toString() + " Ft"
                  : widget.value.toString() + " Ft",
              style: TextStyle(color: Theme.of(context).shadowColor),
            ),
            padding: EdgeInsets.only(left: 5),
          ),
          flex: 9,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ),
    width: 100,
    color: Colors.red,
  );
}*/
