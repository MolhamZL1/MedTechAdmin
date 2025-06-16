import 'package:flutter/material.dart';

void showWebErrorToast(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final entry = OverlayEntry(
    builder:
        (context) => Positioned(
          top: 20,
          left: MediaQuery.of(context).size.width * 0.5 - 150,
          width: 300,
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(12),
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
  );

  overlay.insert(entry);
  Future.delayed(const Duration(seconds: 3), () => entry.remove());
}
