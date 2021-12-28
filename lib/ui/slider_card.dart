import 'package:flutter/material.dart';

class SliderCard extends StatefulWidget {
  const SliderCard({ Key? key }) : super(key: key);

  @override
  State<SliderCard> createState() => _SliderCardState();
}

class _SliderCardState extends State<SliderCard> {
  bool _hasFocus = false;


  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onFocusChange: (hasFocus) {
          debugPrint('hasFocus: $hasFocus');
          setState(() {
            _hasFocus = hasFocus;
          });
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 10,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: _hasFocus ? 200 : 180,
            height: _hasFocus ? 100 : 80,
            
            child: Center(
              child: Text(
                'Test 1',
              ),
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}