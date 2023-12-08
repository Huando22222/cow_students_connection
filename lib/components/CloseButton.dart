import 'package:flutter/material.dart';

class CloseButton extends StatelessWidget {
  final VoidCallback onClose;

  const CloseButton({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        alignment: Alignment.topRight,
        margin: EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.6),
          ),
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 30.0,
          ),
          padding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}
