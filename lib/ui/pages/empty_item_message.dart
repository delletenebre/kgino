import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../resources/krs_locale.dart';

class EmptyItemMessage extends StatelessWidget {
  const EmptyItemMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    print(GoRouter.of(context).location);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.emoji_people,
            size: 128.0,
            color: theme.colorScheme.outline,
          ),

          const SizedBox(height: 24.0),

          OutlinedButton(
            autofocus: true,
            onPressed: () {
              context.pop();
            },
            child: Text('Попробовать ещё'),
          ),

          const SizedBox(height: 12.0),

          OutlinedButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            child: Text('Назад'),
          ),

          Material(
      type: MaterialType.transparency,
      
      child: InkWell(
        onTap: () {
          print(' widget.onPressed');
        },

        child: Ink(
          padding: const EdgeInsets.all(12.0),
          
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('test'),
            ],
          ),
        ),
      ),
    )
        ],
      ),
    );
  }
}