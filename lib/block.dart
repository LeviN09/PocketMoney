import 'package:flutter/material.dart';
import 'counter.dart';

class Block extends StatefulWidget {
  final bool isMain;
  final bool isMinus;
  final String text;
  final String account;
  final int value;
  final DateTime date;

  Block(this.isMain, this.isMinus, this.account, this.text, this.value,
      this.date);

  @override
  _BlockState createState() => _BlockState();
}

class _BlockState extends State<Block> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.isMain
          ? mainItem(widget.value)
          : subItem(widget.isMinus, widget.account, widget.text, widget.date,
              widget.value),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: widget.isMain
            ? Theme.of(context).cardColor
            : widget.isMinus
                ? Colors.redAccent[100]
                : Colors.greenAccent[100],
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).disabledColor,
            blurRadius: 5,
            spreadRadius: 0,
            offset: Offset(0, 10),
          )
        ],
      ),
      height: widget.isMain
          ? MediaQuery.of(context).size.height / 5
          : MediaQuery.of(context).size.height / 8,
      width: widget.isMain
          ? MediaQuery.of(context).size.width / 10 * 9
          : MediaQuery.of(context).size.width / 5 * 4,
    );
  }
}

Widget mainItem(int value) {
  return FittedBox(
    child: Counter(false, "home", value),
    fit: BoxFit.contain,
  );
}

Widget subItem(
    bool isMinus, String account, String text, DateTime date, int value) {
  return Row(
    children: [
      Expanded(
        child: FittedBox(
          child: Column(
            children: [
              Counter(isMinus, account, value),
              Text(
                account.toUpperCase() + ": " + text,
                style: TextStyle(fontSize: 9),
              ),
            ],
          ),
          fit: BoxFit.contain,
        ),
      ),
      Column(
        children: [
          Text(date.year.toString() + "."),
          Text(date.month.toString() + ". " + date.day.toString() + "."),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    ],
    mainAxisAlignment: MainAxisAlignment.center,
  );
}
