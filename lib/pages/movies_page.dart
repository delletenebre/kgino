import 'package:flutter/material.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          height: 220.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Yfpasdasdkaj  asdajsdnlasdm mlasmdkamskdl askmd ',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),

              Row(
                children: [
                  Chip(
                    padding: const EdgeInsets.all(0.0),
                    label: Text('2022'),
                  )
                ],
              ),

              Text('Эвелин получает доступ к воспоминаниям, эмоциям и невероятным способностям других версии? себя. Теперь она может прожить тысячи жизней и быть кем угодно - известной актрисой, мастером боевых искусств, оперной дивой и даже небесным божеством. Но всем мультивселенным угрожает таинственная сущность, с которой Эвелин предстоит сразиться. Как знать, возможно, заодно она разберётся и с самым страшным злом - своими налогами.'),

            ],
          ),
        ),

        Expanded(
          child: const ColoredBox(
            color: Colors.green,
            child: Placeholder(),
          ),
        ),
      ],
    );
  }
}