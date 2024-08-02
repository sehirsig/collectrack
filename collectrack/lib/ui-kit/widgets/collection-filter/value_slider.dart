import 'package:flutter/material.dart';

class ValueSliderWidget extends StatefulWidget {
  double value;
  ValueSliderWidget(this.value, {Key? key}) : super(key: key);

  @override
  _ValueSliderWidgetState createState() => _ValueSliderWidgetState();
}

class _ValueSliderWidgetState extends State<ValueSliderWidget> {
  double min = 0;
  double max = 100;

  Widget buildSideLabel(double value) => Text(
        value.round().toString(),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      );

  @override
  Widget build(BuildContext context) => SliderTheme(
        data: const SliderThemeData(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                buildSideLabel(min),
                Expanded(
                  child: Slider(
                    value: widget.value,
                    min: min,
                    max: max,
                    divisions: 100,
                    label: widget.value.round().toString(),
                    onChanged: (value) => setState(() => widget.value = value),
                  ),
                ),
                buildSideLabel(max),
              ],
            ),
          ],
        ),
      );
}
