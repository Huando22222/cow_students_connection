import 'package:flutter/material.dart';

class ZoomedImageScreen extends StatefulWidget {
  final String imageUrl;
  final VoidCallback onClose;

  const ZoomedImageScreen({required this.imageUrl, required this.onClose});

  @override
  _ZoomedImageScreenState createState() => _ZoomedImageScreenState();
}

class _ZoomedImageScreenState extends State<ZoomedImageScreen> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onScaleStart: (details) {
          _previousScale = _scale;
        },
        onScaleUpdate: (details) {
          setState(() {
            _scale = _previousScale * details.scale;
          });
        },
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! < -20) {
            widget.onClose();
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Transform.scale(
                  scale: _scale,
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: widget.onClose,
                child: Text('X'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
