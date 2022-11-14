import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.withOpacity(0.2),
      child: Column(
        children: [

          FocusScope(
            
            child: SizedBox(
              height: 100,
              child: ListView.separated(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder:(context, index) {
                  return Material(
                    color: Colors.green.withOpacity(0.1),
                    child: InkWell(
                      onTap: () {

                      },
                      child: Container(
                        width: 200,
                        height: 100,
                        //color: Colors.green,
                        child: Text('$index'),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(width: 16.0),
              ),
            ),
          ),

          SizedBox(
            height: 100,
            child: ListView.separated(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder:(context, index) {
                return Material(
                  color: Colors.yellow.withOpacity(0.1),
                  child: InkWell(
                    onTap: () {

                    },
                    child: Container(
                      width: 200,
                      height: 100,
                      //color: Colors.green,
                      child: Text('$index'),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 16.0),
            ),
          ),
        ],
      )
    );
  }
}