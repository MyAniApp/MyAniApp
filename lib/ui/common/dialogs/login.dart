import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({super.key, required this.action});

  final String action;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'You need to log in to $action.',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Go back'),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () => context.push('/login'),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void showLoginDialog(BuildContext context, String action) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: LoginDialog(
        action: action,
      ),
    ),
  );
}
