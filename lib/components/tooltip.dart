import 'package:flutter/material.dart';

Tooltip buildTooltip(String message) {
  return Tooltip(
    message: message,
    preferBelow: false,
    triggerMode: TooltipTriggerMode.tap,
    child: const Icon(Icons.info_outlined, color: Colors.purpleAccent,),
  );
}