import 'package:flutter/material.dart';

/// Created by Sudeera Sandaruwan
class RoundedButton extends StatelessWidget {
  final bool _filled;
  final String _label;
  final VoidCallback _onPressed;

  const RoundedButton(this._filled, this._label, this._onPressed);

  const RoundedButton.filled(String label, VoidCallback onPressed)
      : _filled = true,
        _label = label,
        _onPressed = onPressed;

  const RoundedButton.outlined(String label, VoidCallback onPressed)
      : _filled = false,
        _label = label,
        _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_filled) {
      return ElevatedButton(
        onPressed: _onPressed,
        style: ElevatedButton.styleFrom(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(
            _label,
            style: theme.textTheme.button!.copyWith(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    } else {
      return OutlinedButton(
        onPressed: _onPressed,
        style: OutlinedButton.styleFrom(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(
            _label,
            style: theme.textTheme.button!.copyWith(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    }
  }
}
