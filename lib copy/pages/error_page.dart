import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
  });

  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Страница не найдена'),

            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: ElevatedButton(
                focusNode: FocusNode()..requestFocus(),
                onPressed: () {
                  context.go('/');
                },
                child: Text('На главную'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
