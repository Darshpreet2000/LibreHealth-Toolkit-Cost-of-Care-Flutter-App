import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/user_location.dart';

class SettingsHome extends StatefulWidget {
  @override
  _SettingsHomeState createState() => _SettingsHomeState();
}
class _SettingsHomeState extends State<SettingsHome> {
  int _value = 15;
String sort='Ascending';
bool isSelected=false;
  static const Color appBackgroundColor = Color(0xFFf5f5f5);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        title: Text('Settings',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.indigo,

      ),
      body: SingleChildScrollView(
    child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Search by Radius',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Distance',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Text('$_value Km',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            SliderExample(_refresh),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Order By',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                  color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),

                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Ordering by $sort',style: TextStyle(fontSize: 16,),),
                      ),
                      Switch(value: isSelected, onChanged: (bool value) {
                        isSelected= value;
                        if(isSelected){
                          sort='Descending';
                        }
                        else{
                          sort='Ascending';
                        }
                        setState(() {
                          isSelected=value;
                        });
                      },
                        activeTrackColor: Colors.pinkAccent[100],
                        activeColor: Colors.pink,

                      )
                    ],
                  ),

              ),
            ),
              UserLocation(appBackgroundColor),


          ],
        ),
      )
    );
  }
  void _refresh(int index) {
    setState(() {
      _value = index;
    });
  }
}

class SliderExample extends StatefulWidget {

  final Function refresh;
  @override
  _SliderExampleState createState() {
    return _SliderExampleState();
  }

  SliderExample(this.refresh);
}

class _SliderExampleState extends State<SliderExample> {

  int _value = 15;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
              child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Radius',style: TextStyle(fontSize: 16),),
                        ),
                        new Expanded(
                            child: Slider(
                                value: _value.toDouble(),
                                min: 1.0,
                                max: 50.0,
                                divisions: 50,
                                activeColor: Colors.pinkAccent,
                                inactiveColor: Colors.grey[200],
                                label: '$_value',
                                onChanged: (double newValue) {
                                  setState(() {
                                    _value = newValue.round();
                                    widget.refresh(_value);
                                  });
                                },

                            )
                        ),
                      ]
                  )
              ),

      ),
    );
  }
}