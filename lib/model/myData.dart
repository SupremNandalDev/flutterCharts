import 'package:flutter/material.dart';

class MyData{
  DateTime dateTime;
  double value;
  MyData({this.dateTime, this.value});

  TextEditingController controller = TextEditingController(text: '0.0');

  Widget getView({VoidCallback onClick}) {
    return Card(
      margin: EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: FlatButton(
              onPressed: (){
                onClick();
              },
              child: Text(
                '${dateTime.day}/${dateTime.month}/${dateTime.year}'
              ),
            ),
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              controller: controller,
              onChanged: (value){
                this.value = double.parse(value);
              },
              decoration: InputDecoration(
                labelText: 'Set Value'
              ),
            ),
          )
        ],
      ),
    );
  }
}