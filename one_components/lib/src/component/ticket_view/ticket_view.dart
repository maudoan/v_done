/*
 * File: ticket_view.dart
 * File Created: Thursday, 24th March 2022 11:13:42 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Thursday, 24th March 2022 11:20:07 pm
 * Modified By: Hieu Tran
 */

import 'package:flutter/material.dart';

class TicketWidget extends StatefulWidget {
  const TicketWidget({
    Key? key,
    required this.childLeft,
    required this.childRight,
    this.color = Colors.white,
  }) : super(key: key);

  final Widget childLeft;
  final Widget childRight;
  final Color color;

  @override
  _TicketWidgetState createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipPath(
            clipper: TicketClipperLeft(),
            child: AnimatedContainer(
              duration: const Duration(seconds: 3),
              child: widget.childLeft,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          Expanded(
            child: ClipPath(
              clipper: TicketClipperRight(),
              child: AnimatedContainer(
                duration: const Duration(seconds: 3),
                child: widget.childRight,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TicketClipperLeft extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(Rect.fromCircle(center: Offset(size.width, 0.0), radius: 10.0));
    path.addOval(Rect.fromCircle(center: Offset(size.width, size.height), radius: 10.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class TicketClipperRight extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(Rect.fromCircle(center: const Offset(0.0, 0.0), radius: 10.0));
    path.addOval(Rect.fromCircle(center: Offset(0.0, size.height), radius: 10.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
