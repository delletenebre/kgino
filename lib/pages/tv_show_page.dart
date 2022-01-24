import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/tskg.dart';
import 'package:kgino/api/tskg/tskg_api.dart';
import 'package:kgino/ui/pages/app_page.dart';
import 'package:palette_generator/palette_generator.dart';

class TvShowPage extends StatefulWidget {
  final String id;
  final String heroTag;

  const TvShowPage({
    Key? key,
    this.id = '',
    this.heroTag = '',
  }) : super(key: key);

  @override
  State<TvShowPage> createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> {

  List<Color> _imageColors = [Colors.black, Colors.black, Colors.black];
  late String posterUrl;


  @override
  void initState() {
    super.initState();

    /// формируем ссылку на постер сериала
    posterUrl = Tskg.getPosterUrl(widget.id);

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      
      /// вычисляем основные цвета изображения
      final pallete = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(posterUrl),
        maximumColorCount: 4,
      );

      if (pallete.colors.isNotEmpty) {
        _imageColors = pallete.colors.toList();

        while (_imageColors.length < 3) {
          _imageColors.add(_imageColors[0]);
        }
      }

      setState(() {
        
      });

      /// запрашиваем данные о сериале
      final request = TskgApi.getShow(widget.id);
    });

    
    
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final width = 480.0;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -(width * 0.18),
            right: -(width * 0.05),
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.center,
                  stops: const [0.05, 1],
                  colors: [_imageColors[0], Colors.transparent],
                ).createShader(
                  Rect.fromLTRB(0, 0, rect.width, rect.height)
                );
              },
              blendMode: BlendMode.dstOut,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    stops: const [0.05, 1],
                    colors: [_imageColors[0], Colors.transparent],
                  ).createShader(
                    Rect.fromLTRB(0, 0, rect.width, rect.height)
                  );
                },
                blendMode: BlendMode.dstOut,
                child: Hero(
                  tag: widget.heroTag,
                  child: CachedNetworkImage(
                    width: width,
                    fit: BoxFit.cover,
                    imageUrl: posterUrl,
                    progressIndicatorBuilder: (context, url, downloadProgress) {
                      return CircularProgressIndicator(
                        value: downloadProgress.progress
                      );
                    },
                    errorWidget: (context, url, error) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              ),
            ),

          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0, 0.5, 0.75, 1],
                  colors: [
                    _imageColors[0].withOpacity(0.5),
                    _imageColors[1].withOpacity(0.5),
                    _imageColors[2].withOpacity(0.5),
                    theme.scaffoldBackgroundColor,
                  ],
                )
              ),
              child: Center(
                child: Text(
                  'Hello Gradient!',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}