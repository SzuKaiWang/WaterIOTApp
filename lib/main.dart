import 'dart:convert';
import 'dart:ui';
import 'dart:math' as maths;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapptest123/Service.dart';
import 'package:flutterapptest123/Model.dart';
import 'package:flutterapptest123/recordPage.dart';

import 'authentication.dart';
import 'root_page.dart';


void main() => runApp(MyApp());
// void main() => runApp(PainterDemo());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Authentication AndroidVille',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: RootPage(
//         auth: new Auth(),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  CHTIotAPI _CHTIotAPI = new CHTIotAPI();

  final List<int> data=[];
  DeviceData _deviceData = DeviceData();
  String _phValue = '7.0';
  String _orpValue = '50';
  String _doValue = '10';
  String _ecValue = '5000';
  String _ntuValue = '50';
  String _tempValue = '50';
  String _hwValue = '3';
  String _targetValue = '3';

  double _phAngle = 0;
  double _orpAngle = 0;
  double _doAngle = 0;
  double _ecAngle = 0;
  double _ntuAngle = 0;
  double _tempAngle = 0;
  double _hwAngle = 0;
  double _targetAngle = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0;i<100;i++){
      data.add(i);
    }

    _requestData();

    // _bodyBuilder().then((String result){
    //   setState(() {
    //     var data = jsonDecode(result);
    //     var list = data.map((model) => new DeviceData.fromJson(model)).toList();
    //     // print(list);
    //     List<DeviceData> t = list?.cast<DeviceData>();
    //
    //     for (int i=0;i< t.length;i++){
    //       DeviceData _deviceData = list[i];
    //       switch(_deviceData.id) {
    //         case "ph": {
    //           _phValue = _deviceData.value[0];
    //         } break;
    //         case "orp": {
    //           _orpValue = _deviceData.value[0];
    //         } break;
    //         case "do": {
    //           _doValue = _deviceData.value[0];
    //         } break;
    //         case "ec": {
    //           _ecValue = _deviceData.value[0];
    //         } break;
    //         case "ntu": {
    //           _ntuValue = _deviceData.value[0];
    //         } break;
    //         case "temp": {
    //           _tempValue = _deviceData.value[0];
    //         } break;
    //         case "hw": {
    //           _hwValue = _deviceData.value[0];
    //         } break;
    //         case "target": {
    //           _targetValue = _deviceData.value[0];
    //         } break;
    //
    //         default: {
    //           //statements;
    //         }
    //         break;
    //       }
    //     }
    //     // alert(context);
    //   });
    //
    // });

  }

  void alert(BuildContext context, String title) {
    AlertDialog dialog = AlertDialog(
      // backgroundColor: Colors.yellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      content: Row(
        children: <Widget>[
          Icon(
            Icons.warning,
            color: Colors.red,
            size: 30,
          ),
          Padding(padding: EdgeInsets.only(right: 10)),
          Container(
            height: 100,
            width: 200,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.red,
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
          },
          child: Text(
            "CLOSE",
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

    //print("in alert()");
  }

  _buildCircleImg() {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.lime,
          // image: DecorationImage(image: AssetImage('assets/images/logo.png'))
      ),
    );
  }

  _buildHalfCircle() {
    return ClipPath(
        clipper: new CustomHalfCircleClipper(),
        child: new Container(
          height: 60.0,
          width: 60.0,
          decoration: new BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(95.0)
          ),
        )
    );
  }

  _buildHalfCircle2(String name, String leftValue, String rightValue, Color colors) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        
        ClipPath(
          clipper: new CustomHalfCircleClipper(),
            child: Container(
              height: 150.0,
              width: 150.0,
              decoration: new BoxDecoration(
                color: colors,
                borderRadius: BorderRadius.circular(95.0)
              ),
          )
        ),
        Container(
          height: 200,
          width: 200,
          child: new Text(
            name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
            left: 12,
            child: Container(
              child: Text(leftValue,
                  style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
              ),
            )
        ),
        Positioned(
            right: 12,
            child: Container(
              child: Text(rightValue,
                   style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right

              ),
            )
        ),
      ],
    );
  }

  _buildLine() {
    return ClipPath(
        clipper: new CustomHalfCircleClipper(),
        child: new Container(
            height: 80.0,
            width: 3.0,
            decoration: new BoxDecoration(
              color: Colors.black
            ),
        )
    );
  }

  Future<String> _bodyBuilder() async {
    return await _CHTIotAPI.getFeaturedDeviceData();
  }

  _requestData() {
    _bodyBuilder().then((String result){
      setState(() {
        print(result);
        var data = jsonDecode(result);
        var list = data.map((model) => new DeviceData.fromJson(model)).toList();
        // print(list);
        List<DeviceData> t = list?.cast<DeviceData>();

        for (int i=0;i< t.length;i++){
          DeviceData _deviceData = list[i];
          switch(_deviceData.id) {
            case "ph": {
              _phValue = _deviceData.value[0];
              _phAngle = (1 - (double.parse(_deviceData.value[0]) / 13.0)) * 180 * maths.pi / 360;
              if (double.parse(_deviceData.value[0]) < 6.5) {
                _phAngle *= -1; }
            } break;
            case "orp": {
              _orpValue = _deviceData.value[0];
              _orpAngle = ( ((double.parse(_orpValue) + 300) / 700)) * 180 * maths.pi / 360;
              if (double.parse(_deviceData.value[0]) < 50) {
                _orpAngle *= -1; }
            } break;
            case "do": {
              _doValue = _deviceData.value[0];
              _doAngle = (1 - (double.parse(_deviceData.value[0]) / 20)) * 180 * maths.pi / 360;
              if (double.parse(_deviceData.value[0]) < 10) {
                _doAngle *= -1; }
            } break;
            case "ec": {
              _ecValue = _deviceData.value[0];
              _ecAngle = (1 - (double.parse(_deviceData.value[0]) / 10000)) * 180 * maths.pi / 360;
              if (double.parse(_deviceData.value[0]) < 5000) {
                _ecAngle *= -1; }
            } break;
            case "ntu": {
              _ntuValue = _deviceData.value[0];
              _ntuAngle = (1 - (double.parse(_deviceData.value[0]) / 100)) * 180 * maths.pi / 360;
              if (double.parse(_deviceData.value[0]) < 50) {
                _ntuAngle *= -1; }
            } break;
            case "temp": {
              _tempValue = _deviceData.value[0];
              _tempAngle = 0;
              // _tempAngle = (1 - (double.parse(_deviceData.value[0]) / 13.0)) * 180 * maths.pi / 360;
              // if (double.parse(_deviceData.value[0]) < 50) {
              //   _tempAngle *= -1; }
            } break;
            case "hw": {
              _hwValue = _deviceData.value[0];
              _hwAngle = 0;
              // _hwAngle = (1 - (double.parse(_deviceData.value[0]) / 13.0)) * 180 * maths.pi / 360;
              // if (double.parse(_deviceData.value[0]) < 3) {
              //   _hwAngle *= -1; }
            } break;
            case "target": {
              _targetValue = _deviceData.value[0];
              _targetAngle = 0;
              // _targetAngle = (1 - (double.parse(_deviceData.value[0]) / 5)) * 180 * maths.pi / 360;
              // if (double.parse(_deviceData.value[0]) < 3) {
              //   _targetAngle *= -1; }
            } break;
            case "pH": {
              _phValue = _deviceData.value[0];
              _phAngle = (1 - (double.parse(_deviceData.value[0]) / 13.0)) * 180 * maths.pi / 360;
              if (double.parse(_deviceData.value[0]) < 6.5) {
                _phAngle *= -1; }
            } break;
            case "Temp": {
              _tempValue = _deviceData.value[0];
              _tempAngle = 0;
              // _tempAngle = (1 - (double.parse(_deviceData.value[0]) / 13.0)) * 180 * maths.pi / 360;
              // if (double.parse(_deviceData.value[0]) < 50) {
              //   _tempAngle *= -1; }
            } break;

            default: {
              //statements;
            }
            break;
          }
        }

        String titleMessage = '';
        bool isShowAlertFlag = false;

        // if (double.parse(_phValue) < 6.0) {
        //   titleMessage += '請注意酸鹼度PH低於 6.0；';
        //   isShowAlertFlag = true;
        // }
        //
        // if (double.parse(_orpValue) > 0) {
        //   titleMessage += '請注意氧化還原ORP高於 0 mV；';
        //   isShowAlertFlag = true;
        // }

        if (isShowAlertFlag) {
          alert(context, titleMessage);
        }

      });

    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Class Name",
      home: Scaffold(
        appBar: AppBar(
          title: Text("資料頁面"),
          leading: IconButton(
            icon: Icon(Icons.menu),
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage()));}
          ),
            actions: <Widget>[
              IconButton(
              icon: Icon(Icons.update),
              tooltip: 'Search',
              onPressed: () => _requestData(),
            ),
            ]
        ),
        body:
        Center(
          child: GridView.count(
            padding: EdgeInsets.all(10),    // 内边距
            scrollDirection: Axis.vertical, // 滚动方向
            crossAxisSpacing: 10,           // 列间距
            crossAxisCount: 2,              // 每行的个数（Axis.vertic == 横向三个, Axis.horizontal == 竖方向三个）
            mainAxisSpacing: 10,            // 行间距
            children: <Widget>[
              Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      child: _buildHalfCircle2('酸鹼度PH值','1','14', Colors.blueAccent),
                    ),
                    Positioned(
                        bottom: 65,
                        child:Transform.rotate(
                          angle: _phAngle ,
                          child: _buildLine(),
                        ),
                    ),
                    Positioned(
                        bottom: 87,
                        child: Container(
                          child: Text(_phValue,
                              style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right

                          ),
                        )
                    ),
                  ]
              ),
              // Stack(
              //     alignment: Alignment.center,
              //     children: <Widget>[
              //       Container(
              //         child: _buildHalfCircle2('氧化還原程度ORP','-300mV','400mV', Colors.redAccent),
              //       ),
              //       Positioned(
              //         bottom: 65,
              //         child:Transform.rotate(
              //           angle: _orpAngle,
              //           child: _buildLine(),
              //         ),
              //       ),
              //       // Text('$_orpValue'),
              //       Positioned(
              //           bottom: 87,
              //           child: Container(
              //             child: Text(_orpValue,
              //                 style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
              //                 textAlign: TextAlign.right
              //
              //             ),
              //           )
              //       ),
              //     ]
              // ),
              // Stack(
              //     alignment: Alignment.center,
              //     children: <Widget>[
              //       Container(
              //         child: _buildHalfCircle2('溶氧量DO','0 mg/L','20 mg/L', Colors.orangeAccent),
              //       ),
              //       Positioned(
              //         bottom: 65,
              //         child:Transform.rotate(
              //           // angle:  - maths.pi / 2,
              //           angle:  _doAngle,
              //           child: _buildLine(),
              //         ),
              //       ),
              //       // Text('$_doValue'),
              //       Positioned(
              //           bottom: 87,
              //           child: Container(
              //             child: Text(_doValue,
              //                 style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
              //                 textAlign: TextAlign.right
              //
              //             ),
              //           )
              //       ),
              //     ]
              // ),
              // Stack(
              //     alignment: Alignment.center,
              //     children: <Widget>[
              //       Container(
              //         child: _buildHalfCircle2('導電度EC','0 mg/L','10k mg/L', Colors.greenAccent),
              //       ),
              //       Positioned(
              //         bottom: 65,
              //         child:Transform.rotate(
              //           // angle:  - maths.pi / 2,
              //           angle:  _ecAngle,
              //           child: _buildLine(),
              //         ),
              //       ),
              //       // Text('$_ecValue'),
              //       Positioned(
              //           bottom: 87,
              //           child: Container(
              //             child: Text(_ecValue,
              //                 style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
              //                 textAlign: TextAlign.right
              //
              //             ),
              //           )
              //       ),
              //     ]
              // ),
              // Stack(
              //     alignment: Alignment.center,
              //     children: <Widget>[
              //       Container(
              //         child: _buildHalfCircle2('混濁度','0 NTU','100 NTU', Colors.grey),
              //       ),
              //       Positioned(
              //         bottom: 65,
              //         child:Transform.rotate(
              //           // angle:  - maths.pi / 2,
              //           angle:  _ntuAngle,
              //           child: _buildLine(),
              //         ),
              //       ),
              //       // Text('$_ntuValue'),
              //       Positioned(
              //           bottom: 87,
              //           child: Container(
              //             child: Text(_ntuValue,
              //                 style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
              //                 textAlign: TextAlign.right
              //
              //             ),
              //           )
              //       ),
              //     ]
              // ),
              Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      child: _buildHalfCircle2('溫度','低溫','高溫', Colors.cyanAccent),
                    ),
                    Positioned(
                      bottom: 65,
                      child:Transform.rotate(
                        // angle:  - maths.pi / 2,
                        angle:  _tempAngle,
                        child: _buildLine(),
                      ),
                    ),
                    // Text('$_tempValue'),
                    Positioned(
                        bottom: 87,
                        child: Container(
                          child: Text(_tempValue,
                              style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right

                          ),
                        )
                    ),
                  ]
              ),
              // Stack(
              //     alignment: Alignment.center,
              //     children: <Widget>[
              //       Container(
              //         child: _buildHalfCircle2('水深','','', Colors.amberAccent),
              //       ),
              //       Positioned(
              //         bottom: 65,
              //         child:Transform.rotate(
              //           // angle:  - maths.pi / 2,
              //           angle:  _hwAngle,
              //           child: _buildLine(),
              //         ),
              //       ),
              //       Positioned(
              //           bottom: 87,
              //           child: Container(
              //             child: Text(_hwValue,
              //                 style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
              //                 textAlign: TextAlign.right
              //
              //             ),
              //           )
              //       ),
              //     ]
              // ),
              Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      child: _buildHalfCircle2('綜合評估指標','','', Colors.brown),
                    ),
                    Positioned(
                      bottom: 65,
                      child:Transform.rotate(
                        // angle:  - maths.pi / 2,
                        angle:  _targetAngle,
                        child: _buildLine(),
                      ),
                    ),
                    Positioned(
                        bottom: 87,
                        child: Container(
                          child: Text(_targetValue,
                              style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right

                          ),
                        )
                    ),
                  ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = new Path();
    // path.lineTo(0.0, size.height / 2);
    // path.lineTo(size.width, size.height / 2);
    // path.lineTo(size.width, 0);

    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 4  + size.width / 2 , size.height / 2);
    path.arcToPoint(
    Offset(size.width / 4 , size.height / 2),
    clockwise: false,
    radius: Radius.circular(1),
    );

    path.lineTo(0.0, size.height / 2);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CustomLine extends CustomPainter {

  Paint _linePaint = Paint()
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..color = Colors.deepOrange
    ..strokeWidth = 4;

  @override
  void paint(Canvas canvas, Size size) {
    // _linePaint.strokeWidth = 4;
    canvas.rotate(90);
    // canvas.drawLine(Offset(0, 0), new Offset(0, - size.height + 80), _linePaint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class DolDurmaClipper extends CustomClipper<Path> {
  DolDurmaClipper({@required this.right, @required this.holeRadius});

  final double right;
  final double holeRadius;

  @override
  Path getClip(Size size) {
    final path = Path()
      // ..moveTo(0, 0)
      // ..lineTo(size.width - right - holeRadius, 0.0)
      // ..arcToPoint(
      //   Offset(size.width - right, 0),
      //   clockwise: false,
      //   radius: Radius.circular(1),
      // )
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - right, size.height)
      ..arcToPoint(
        Offset(size.width / 2, size.height),
        clockwise: false,
        radius: Radius.circular(1),
      );

    path.lineTo(0.0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(DolDurmaClipper oldClipper) => true;
}

