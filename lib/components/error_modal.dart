import 'package:flutter/material.dart';
import 'package:movieflix/components/button.dart';

class ErrorModal {
  ErrorModal({required BuildContext context, void Function()? retry}) {
    _setErrorModal(context: context, retry: retry);
  }

  void _setErrorModal({required BuildContext context, void Function()? retry}) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      showDragHandle: true,
      constraints: BoxConstraints(
        maxHeight: 300,
        minWidth: MediaQuery.of(context).size.width,
      ),
      builder: (context) {
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(
                    Icons.error,
                    size: 70,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Seems like you're not connected to the internet.",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Button(variant: "primary", text: "Retry", onPressed: retry!),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        );
      },
    );
  }
}
