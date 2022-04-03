import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:todolist/models/toDoModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState(){
    super.initState();
    // readJson();
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.white30,
        // elevation: 10.0,
        title: const Text("To Do",),
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.sunny,),
          )
        ],
      ),
      body: Padding(
        //using 8px grid
        padding: const EdgeInsets.only(top: 42),
        child: ListView(
          children: [
            Container(
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter in your to do"
                ),
              ),
            ),
            SizedBox(height: 16,),
            Stack(
              children: [
                Row(
                  children: [
                    toDoList()
                  ],
                )
              ],
            ),
            // Stack(
            //   children: [
            //     CheckboxListTile(value: isChecked, onChanged: (bool? val){})
            //   ],
            // )
          ],
        ),
      ),
    );
  }
  //
  Widget toDoList() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.black;
    }
    return FutureBuilder(
      future: ReadJsonData(),
      builder: (context, data) {
        var items =data.data as List<Todo>;
        return Expanded(
          child: SizedBox(
            height: 100.0,
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: CheckboxListTile(
                            title: Text(items[index].name.toString()),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: isChecked,
                            onChanged: (bool? value){
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          ),
                          // Checkbox(
                          //     fillColor: MaterialStateProperty.resolveWith(getColor),
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(30)
                          //     ),
                          //     value: items[index].isChecked,
                          //     onChanged: (bool? value){
                          //       setState(() {
                          //         items[index].isChecked = value!;
                          //       });
                          //     }
                          // ),
                          Icon(IconData(0xefaa, fontFamily: 'MaterialIcons'))
                        ],
                      ),
                    ]
                  );
                }),
          ),
        );
      }
    );
  }
  Future<List<Todo>>ReadJsonData() async{
    final jsondata = await rootBundle.loadString('assets/sample.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => Todo.fromJson(e)).toList();
  }
}
