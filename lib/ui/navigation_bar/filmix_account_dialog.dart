import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/filmix_auth_provider.dart';
import '../../resources/krs_locale.dart';

class FilmixAccountDialog extends HookConsumerWidget {
  const FilmixAccountDialog({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final theme = Theme.of(context);
    final locale = KrsLocale.of(context);

    final controllerState = ref.watch(filmixAuthProvider);
    final controller = ref.read(filmixAuthProvider.notifier);
    final focusNode = useFocusNode();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNode.requestFocus();
    });

    if (controllerState.valueOrNull != null) {
      final user = controllerState.value!;
      return ListView(
        shrinkWrap: true,
        children: [
          const Text(
            'Ваше устройство активировано на аккаунте',
            textAlign: TextAlign.center,
          ),
          Text(
            user.userData.displayName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12.0),
          Text(
            'PRO неактивен',
            style: TextStyle(
              color: user.userData.isPro ? null : theme.colorScheme.error,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12.0),
          FilledButton(
            focusNode: focusNode,
            onPressed: () {
              /// пробуем получить профиль пользователя
              controller.getProfile();
            },
            child: const Text('Деактивировать'),
          ),
          const SizedBox(height: 4.0),
          FilledButton.tonal(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(locale.cancel),
          ),
        ],
      );
    }

    return ListView(
      shrinkWrap: true,
      children: [
        const Text(
          'Перейдите в браузере на страницу',
          textAlign: TextAlign.center,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 4.0,
          ),
          child: Text(
            'filmix.ac/console',
            style: TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Text(
          'и введите код:',
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
          ),
          child: Text(
            ref.read(filmixAuthProvider.notifier).userCode.toUpperCase(),
            style: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Text(
          'после добавления устройства на сайте, нажмите кнопку "Активировать"',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12.0),
        FilledButton.tonal(
          focusNode: focusNode,
          onPressed: () {
            /// пробуем получить профиль пользователя
            controller.getProfile();
          },
          child: const Text('Активировать'),
        ),
        const SizedBox(height: 12.0),
        FilledButton.tonal(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(locale.cancel),
        ),
      ],
    );
  }
}
