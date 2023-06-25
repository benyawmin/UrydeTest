import 'package:flutter/material.dart';

class ShowValidationDialog extends StatelessWidget {
  final BuildContext dialogContext;
  final bool wasApiRequestSuccessful;
  const ShowValidationDialog(
      {super.key,
      required this.dialogContext,
      required this.wasApiRequestSuccessful});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: AlertDialog(
        title: Text(
          'Report status',
          style: Theme.of(context).textTheme.titleSmall!.apply(color: Colors.green),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            wasApiRequestSuccessful
                ? Text(
                    'Driver reported successfully',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: Colors.green),
                  )
                : Text(
                    'Something went wrong',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: Colors.green),
                  ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Close the dialog
            },
            child: Text(
              'Close',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
