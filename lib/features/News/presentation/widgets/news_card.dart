import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/likes_title.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/specific_news.dart';

class NewsCard extends StatelessWidget {
  final NewsEntity news;
  final Color color;
  const NewsCard({Key? key, required this.news, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height;
    double sizeW = MediaQuery.of(context).size.width;
    double cardSizeH = sizeW * 0.55;
    double cardSizeW = sizeW * 0.9;
    BorderRadius borderRadius = BorderRadius.all(Radius.circular(20));

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: cardSizeH + cardSizeH * 0.9),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => SpecificNewsPage(news: news)));
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              height: cardSizeH,
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
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: news.coverImage),
              ),
            ),
            Positioned(
                top: cardSizeH * 0.8,
                left: 0,
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: cardSizeW, height: cardSizeH * 0.9),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: cardSizeW * 0.1,
                          vertical: cardSizeH * 0.1),
                      color: color,
                      width: cardSizeW,
                      height: cardSizeH * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LikesAndModificationWidget(news),
                          Text(
                            news.title,

                            textAlign: TextAlign.center,
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                          SizedBox(height: cardSizeH * 0.075),
                          Text(news.description,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14))
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
