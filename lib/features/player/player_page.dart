import 'package:anilibria_app/features/player/player_page_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerPage extends ConsumerWidget {
  final String url;
  const PlayerPage(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(playerPageControllerProvider(url));
    return Scaffold(
      backgroundColor: Colors.black,
      body: Chewie(controller: controller),
    );
  }
}
