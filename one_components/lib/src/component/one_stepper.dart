/*
 * File: one_stepper.dart
 * File Created: Friday, 19th March 2021 4:57:03 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Friday, 19th March 2021 5:04:11 pm
 * Modified By: Hieu Tran
 */

import 'package:flutter/material.dart';

enum OneStepState {
  /// A step that displays its index in its circle.
  indexed,

  /// A step that displays a pencil icon in its circle.
  editing,

  /// A step that displays a tick icon in its circle.
  complete,

  /// A step that is disabled and does not to react to taps.
  disabled,

  /// A step that is currently having an error. e.g. the user has submitted wrong
  /// input.
  error,
}

const TextStyle _kStepStyle = TextStyle(
  fontSize: 12.0,
  color: Colors.white,
  fontWeight: FontWeight.w700,
);
const Color _kErrorLight = Colors.red;
const Color _kCircleActiveLight = Colors.white;
const double _kStepSize = 28.0;
const double _kTriangleHeight = _kStepSize * 0.866025;

@immutable
class OneStep {
  /// Creates a step for a [OneStepper].
  ///
  /// The [state] arguments must not be null.
  const OneStep({
    this.state = OneStepState.indexed,
    this.isActive = false,
  });

  /// The state of the step which determines the styling of its components
  /// and whether steps are interactive.
  final OneStepState state;

  /// Whether or not the step is active. The flag only influences styling.
  final bool isActive;
}

class OneStepper extends StatefulWidget {
  /// Creates a stepper from a list of steps.
  ///
  /// This widget is not meant to be rebuilt with a different list of steps
  /// unless a key is provided in order to distinguish the old stepper from the
  /// new one.
  ///
  /// The [steps], [type], and [currentStep] arguments must not be null.
  const OneStepper({
    Key? key,
    required this.steps,
    this.currentStep = 0,
    this.onStepTapped,
  })  : assert(0 <= currentStep && currentStep < steps.length),
        super(key: key);

  /// The steps of the stepper whose titles, subtitles, icons always get shown.
  ///
  /// The length of [steps] must not change.
  final List<OneStep> steps;

  /// The index into [steps] of the current step whose content is displayed.
  final int currentStep;

  /// The callback called when a step is tapped, with its index passed as
  /// an argument.
  final ValueChanged<int>? onStepTapped;

  @override
  _OneStepperState createState() => _OneStepperState();
}

class _OneStepperState extends State<OneStepper> with TickerProviderStateMixin {
  // List<GlobalKey> _keys;
  final Map<int, OneStepState> _oldStates = <int, OneStepState>{};

  @override
  void initState() {
    super.initState();
    // _keys = List<GlobalKey>.generate(
    //   widget.steps.length,
    //   (int i) => GlobalKey(),
    // );

    for (int i = 0; i < widget.steps.length; i += 1) _oldStates[i] = widget.steps[i].state;
  }

  @override
  void didUpdateWidget(OneStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.steps.length == oldWidget.steps.length);

    for (int i = 0; i < oldWidget.steps.length; i += 1) _oldStates[i] = oldWidget.steps[i].state;
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  Widget _buildCircleChild(int index, bool oldState) {
    final OneStepState state = oldState ? _oldStates[index]! : widget.steps[index].state;
    final bool isActive = widget.steps[index].isActive;
    switch (state) {
      case OneStepState.indexed:
      case OneStepState.disabled:
        return Text(
          '${index + 1}',
          style: isActive ? _kStepStyle : _kStepStyle.copyWith(color: const Color(0xFF7E8085)),
        );
      case OneStepState.editing:
        return const Icon(
          Icons.edit,
          color: _kCircleActiveLight,
          size: 18.0,
        );
      case OneStepState.complete:
        return const Icon(
          Icons.check,
          color: _kCircleActiveLight,
          size: 18.0,
        );
      case OneStepState.error:
        return const Text('!', style: _kStepStyle);
    }
  }

  Color _circleColor(int index) {
    final step = widget.steps[index];
    if (step.state == OneStepState.complete) {
      return const Color(0xFF3DBA4E);
    }
    return step.isActive ? const Color(0xFF374FC7) : const Color(0xFFE8EAED);
  }

  Color _lineColor(int index) {
    final step = widget.steps[index];
    if (step.state == OneStepState.complete) {
      return const Color(0xFF3DBA4E);
    }
    return const Color(0xFFD5D7DB);
  }

  Widget _buildCircle(int index, bool oldState) {
    final step = widget.steps[index];
    return Container(
      width: _kStepSize,
      height: _kStepSize,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
            color: _circleColor(index),
            shape: BoxShape.circle,
            border: Border.all(
              width: step.isActive ? 0 : 1,
              color: const Color(0xFFD5D7DB),
            )),
        child: Center(
          child: _buildCircleChild(index, oldState && step.state == OneStepState.error),
        ),
      ),
    );
  }

  Widget _buildTriangle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: _kStepSize,
      height: _kStepSize,
      child: Center(
        child: SizedBox(
          width: _kStepSize,
          height: _kTriangleHeight, // Height of 24dp-long-sided equilateral triangle.
          child: CustomPaint(
            painter: _TrianglePainter(
              color: _kErrorLight,
            ),
            child: Align(
              alignment: const Alignment(0.0, 0.8), // 0.8 looks better than the geometrical 0.33.
              child: _buildCircleChild(index, oldState && widget.steps[index].state != OneStepState.error),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(int index) {
    if (widget.steps[index].state != _oldStates[index]) {
      return AnimatedCrossFade(
        firstChild: _buildCircle(index, true),
        secondChild: _buildTriangle(index, true),
        firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.fastOutSlowIn,
        crossFadeState: widget.steps[index].state == OneStepState.error ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: kThemeAnimationDuration,
      );
    } else {
      if (widget.steps[index].state != OneStepState.error)
        return _buildCircle(index, false);
      else
        return _buildTriangle(index, false);
    }
  }

  Widget _buildHorizontal() {
    final List<Widget> children = <Widget>[
      for (int i = 0; i < widget.steps.length; i += 1) ...<Widget>[
        InkResponse(
          onTap: widget.steps[i].state != OneStepState.disabled
              ? () {
                  if (widget.onStepTapped != null) widget.onStepTapped!(i);
                }
              : null,
          canRequestFocus: widget.steps[i].state != OneStepState.disabled,
          child: Row(
            children: <Widget>[
              Container(
                child: Center(
                  child: _buildIcon(i),
                ),
              ),
            ],
          ),
        ),
        if (!_isLast(i))
          Expanded(
            child: Container(
              height: 1.0,
              color: _lineColor(i),
            ),
          ),
      ],
    ];

    return Column(
      children: <Widget>[
        Material(
          color: const Color(0xFFFAFBFF),
          elevation: 2.0,
          child: Container(
            margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Row(
              children: children,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(() {
      if (context.findAncestorWidgetOfExactType<Stepper>() != null)
        throw FlutterError('Steppers must not be nested.\n'
            'The material specification advises that one should avoid embedding '
            'steppers within steppers. '
            'https://material.io/archive/guidelines/components/steppers.html#steppers-usage');
      return true;
    }());
    return _buildHorizontal();
  }
}

// Paints a triangle whose base is the bottom of the bounding rectangle and its
// top vertex the middle of its top.
class _TrianglePainter extends CustomPainter {
  _TrianglePainter({
    required this.color,
  });

  final Color color;

  @override
  bool hitTest(Offset point) => true; // Hitting the rectangle is fine enough.

  @override
  bool shouldRepaint(_TrianglePainter oldPainter) {
    return oldPainter.color != color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double base = size.width;
    final double halfBase = size.width / 2.0;
    final double height = size.height;
    final List<Offset> points = <Offset>[
      Offset(0.0, height),
      Offset(base, height),
      Offset(halfBase, 0.0),
    ];

    canvas.drawPath(
      Path()..addPolygon(points, true),
      Paint()..color = color,
    );
  }
}
