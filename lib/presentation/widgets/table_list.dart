import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ubermove/domain/models/job.dart';

class TableListView<T> extends StatefulWidget {
  final List<T> data;
  final EdgeInsetsGeometry margin;

  TableListView({@required this.data, this.margin});

  @override
  _TableListViewState createState() => _TableListViewState();
}

class _TableListViewState<T> extends State<TableListView<T>> {
  int indexPressed = -1;

  Widget styledText(String text) {
    return Expanded(
      child: Center(
        child: Text(
          text.toUpperCase(),
          style: TextStyle(color: Color(0xff737373), fontSize: 12),
        ),
      ),
    );
  }

  Widget styledHeaderText(String text) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xffFFFFFF),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.widget.margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffEDF1F7),
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              color: Color(0xff2B3797),
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 17),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                styledHeaderText("Compañia"),
                styledHeaderText("Fecha"),
                styledHeaderText("Costo"),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              itemCount: widget.data.length,
              itemBuilder: (context, index) {
                final job = widget.data[index] as Job;
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    color: index != indexPressed
                        ? Color(0xffEDF1F7)
                        : Color(0xffD7E2F1),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 17),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        styledText(job.company.businessName),
                        styledText(DateFormat('dd-MM-yyyy').format(job.date)),
                        styledText(job.payment.quantity.toString()),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
