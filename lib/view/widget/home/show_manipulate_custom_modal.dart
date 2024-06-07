import 'package:flutter/material.dart';

class ShowManipulateCustomModal extends StatelessWidget {
  const ShowManipulateCustomModal({super.key, required this.onRemove});
  final Function onRemove;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              onRemove();
            },
            dense: true,
            minLeadingWidth: 0,
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title:
                Text("Remove", style: Theme.of(context).textTheme.headline5!),
          )
        ],
      ),
    );
  }
}
