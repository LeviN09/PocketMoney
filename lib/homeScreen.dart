import 'package:flutter/material.dart';
import 'block.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: Column(
          children: [
            Flexible(
              child: Padding(
                child: MainBlock(),
                padding: EdgeInsets.only(top: 10),
              ),
              flex: 1,
            ),
            Flexible(
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment(0, -0.9),
                      colors: <Color>[
                        Colors.transparent,
                        Colors.transparent,
                        Colors.white
                      ],
                      stops: [
                        -1,
                        -0.9,
                        0.5
                      ]).createShader(bounds);
                },
                child: OnlineLister(),
              ),
              flex: 4,
            ),
          ],
          //mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}

class MainBlock extends StatefulWidget {
  final firestore = FirebaseFirestore.instance;

  @override
  _MainBlockState createState() => _MainBlockState();
}

class _MainBlockState extends State<MainBlock> {
  int getSum(AsyncSnapshot<QuerySnapshot> snapshot) {
    var sum = 0;
    for (int i = 0; i < snapshot.data!.docs.length; i++) {
      int plus = snapshot.data!.docs[i]['value'];
      if (snapshot.data!.docs[i]['isMinus'])
        sum -= plus;
      else
        sum += plus;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.firestore.collection('items').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Block(true, false, "home", "", getSum(snapshot), DateTime.now());
      },
    );
  }
}

/*Widget ExpenseList() {
  Widget listBuilder(BuildContext context, int i) {
    return Padding(
      child: Center(
        child: Block(true, false, "anya", "", 10000),
      ),
      padding: EdgeInsets.only(top: 10),
    );
  }

  return ListView.builder(
    itemBuilder: listBuilder,
    itemCount: 50,
    shrinkWrap: true,
    padding: EdgeInsets.all(10),
    clipBehavior: Clip.antiAlias,
  );
}*/

class OnlineLister extends StatefulWidget {
  final firestore = FirebaseFirestore.instance;

  @override
  _OnlineListerState createState() => _OnlineListerState();
}

class _OnlineListerState extends State<OnlineLister> {
  ScrollController sc = ScrollController();

  getItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    sc.animateTo(0, duration: Duration(milliseconds: 10), curve: Curves.easeIn);
    return snapshot.data!.docs
        .map((e) => Padding(
              child: Center(
                child: Block(
                  false,
                  (e.data() as dynamic)['isMinus'],
                  (e.data() as dynamic)['user'],
                  (e.data() as dynamic)['text'],
                  (e.data() as dynamic)['value'],
                  ((e.data() as dynamic)['date']).toDate(),
                ),
              ),
              padding: EdgeInsets.only(top: 10),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: widget.firestore
            .collection('items')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView(
            children: getItems(snapshot),
            controller: sc,
          );
        },
      ),
      width: double.infinity,
    );
  }
}
