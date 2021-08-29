import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/likes_title.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/specific_news.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

class NewsCard extends StatelessWidget {
  final NewsEntity news;
  final bool isLiked;
  final Color color;
  final int type;
  const NewsCard(
      {Key? key,
      required this.isLiked,
      required this.news,
      required this.color,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height;
    double sizeW = MediaQuery.of(context).size.width;
    double cardSizeH = sizeW * 0.55;
    double cardSizeW = sizeW * 1;
    BorderRadius borderRadius = BorderRadius.all(Radius.circular(0));

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ConstrainedBox(
        constraints:
            BoxConstraints.tightFor(height: cardSizeH + cardSizeH * 0.8),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    SpecificNewsPage(news: news, type: type)));
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                height: cardSizeH * 1.35,
                width: cardSizeW,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: color,
                    ),
                    borderRadius: borderRadius),
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      //placeholder: (context, url) => SizedBox(width: 30,height: 30,child: Center(child: CircularProgressIndicator(color: mainColor,))),
                      imageUrl: news.coverImage),
                ),
              ),
              Positioned(
                  top: cardSizeH * 1.35,
                  left: 0,
                  child: ClipRRect(
                    borderRadius: borderRadius,
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          width: cardSizeW, height: cardSizeH * 0.5),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: cardSizeW * 0.09,
                            vertical: cardSizeH * 0.1),
                        color: mainColor,
                        width: cardSizeW,
                        height: cardSizeH * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LikesAndModificationWidget(
                                news, isLiked, type, context),
                            SizedBox(
                              height: 1,
                            ),
                            SizedBox(height: cardSizeH * 0.075),
                            Text(news.description,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12))
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
