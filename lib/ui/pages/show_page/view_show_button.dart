import 'package:flutter/material.dart';
import 'package:kgino/controllers/controllers.dart';
import 'package:kgino/ui/shadowed_icon.dart';

class ViewShowButton extends GetView<ViewedController> {
  final String showId;
  
  const ViewShowButton({
    Key? key,
    required this.showId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.items.containsKey(showId)) {
        /// ^ если есть просмотренные эпизоды
        
        final episodes = controller.items.get(showId)!.episodes;
        episodes.sort((a,b) => a.updatedAt.compareTo(b.updatedAt));
        final lastEpisode = episodes.last;
        
        return OutlinedButton.icon(
          onPressed: () {
            Get.toNamed('/tskg/show/$showId/play/${lastEpisode.id}/${lastEpisode.position}');
          },
          icon: const ShadowedIcon(Icons.play_arrow),
          label: const Text('Продолжить просмотр'),
        );

      } else {
        /// ^ если сериал ещё не смотрели
      
        return OutlinedButton.icon(
          onPressed: () {
            Get.toNamed('/tskg/show/$showId/play');
          },
          icon: const ShadowedIcon(Icons.play_arrow),
          label: const Text('Смотреть'),
        );

      }
      
    });
  }
}