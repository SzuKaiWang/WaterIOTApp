import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'Service.dart';


class RecordPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page02'),
      ),
      body: _RecordPage(),
    );
  }
}

class _RecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page02'),
    );
  }
}

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  CHTIotAPI _CHTIotAPI = new CHTIotAPI();

  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _dirtController = new TextEditingController();
  TextEditingController _rustController = new TextEditingController();
  TextEditingController _mossController = new TextEditingController();
  TextEditingController _ntuController = new TextEditingController();
  TextEditingController _foamController = new TextEditingController();
  TextEditingController _suspendedMatterController = new TextEditingController();
  TextEditingController _precipitateController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("紀錄表單"),
      ),
      body:
      // Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Form(
          key: _formKey, //設定globalKey，用於後面獲取FormState
          autovalidate: false, //開啟自動校驗
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: true,
                  controller: _dirtController,
                  decoration: InputDecoration(
                      labelText: "汙垢",
                      hintText: "請敘述污垢情況",
                      icon: Icon(Icons.filter_1)),
              ),
              TextFormField(
                autofocus: true,
                controller: _rustController,
                decoration: InputDecoration(
                    labelText: "生鏽",
                    hintText: "請敘述生鏽情況",
                    icon: Icon(Icons.filter_2)),
              ),
              TextFormField(
                autofocus: true,
                controller: _mossController,
                decoration: InputDecoration(
                    labelText: "青苔",
                    hintText: "請敘述青苔情況",
                    icon: Icon(Icons.filter_3)),
              ),
              TextFormField(
                autofocus: true,
                controller: _ntuController,
                decoration: InputDecoration(
                    labelText: "水的顏色(濁度)",
                    hintText: "請敘述水的顏色(濁度)情況",
                    icon: Icon(Icons.filter_4)),
              ),
              TextFormField(
                autofocus: true,
                controller: _foamController,
                decoration: InputDecoration(
                    labelText: "泡沫",
                    hintText: "請敘述泡沫情況",
                    icon: Icon(Icons.filter_5)),
              ),
              TextFormField(
                autofocus: true,
                controller: _suspendedMatterController,
                decoration: InputDecoration(
                    labelText: "出現懸浮物",
                    hintText: "請敘述懸浮物情況",
                    icon: Icon(Icons.filter_6)),
              ),
              TextFormField(
                autofocus: true,
                controller: _precipitateController,
                decoration: InputDecoration(
                    labelText: "出現沉澱物",
                    hintText: "請敘述沉澱物情況",
                    icon: Icon(Icons.filter_7)),
              ),
              // 登入按鈕
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("儲存"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          //在這裡不能通過此方式獲取FormState，context不對
                          //print(Form.of(context));

                          // 通過_formKey.currentState 獲取FormState後，
                          // 呼叫validate()方法校驗使用者名稱密碼是否合法，校驗
                          // 通過後再提交資料。
                          // if ((_formKey.currentState as FormState).validate()) {
                          //   //驗證通過提交資料
                          // }

                          Map<String, String> jsonMap = {
                            'dirt':_dirtController.text,
                            'rust':_rustController.text,
                            'moss': _mossController.text,
                            'ntu':_ntuController.text,
                            'foam':_foamController.text,
                            'suspendedMatter':_suspendedMatterController.text,
                            'precipitate':_precipitateController.text
                          };
                          utf8.encode(json.encode(jsonMap));

                          DateTime now = DateTime.now();
                          String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(now);

                          var encodeJson = utf8.encode(json.encode(jsonMap));
                          var message = utf8.decode(encodeJson).toString();

                          _bodyBuilder(formattedDate, message).then((String result) {
                              if (result == "OK") {
                                alert(context, "上傳成功");
                              }
                           });

                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

    Future<String> _bodyBuilder(String time, String message) async {
      return await _CHTIotAPI.postFeaturedData("document", time, message);
    }

    void alert(BuildContext context, String title) {
      AlertDialog dialog = AlertDialog(
        // backgroundColor: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        content: Row(
          children: <Widget>[
            // Icon(
            //   Icons.warning,
            //   color: Colors.red,
            //   size: 30,
            // ),
            // Padding(padding: EdgeInsets.only(right: 10)),
            Container(
              height: 30,
              width: 100,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
                softWrap: true,
              ),
            ),
            // Text(
            //   title,
            //   style: TextStyle(
            //     color: Colors.red,
            //     fontSize: 16,
            //   ),
            // ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context, true);
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text(
              "離開",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => dialog,
      );
    }
}