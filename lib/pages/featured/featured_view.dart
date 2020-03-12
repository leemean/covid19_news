
import 'package:bsev/bsev.dart';
import 'package:covid19_news/pages/featured/featured_bloc.dart';
import 'package:covid19_news/pages/featured/featured_events.dart';
import 'package:covid19_news/pages/featured/featured_streams.dart';
import 'package:covid19_news/repository/model/notice.dart';
import 'package:covid19_news/widgets/error_conection.dart';
import 'package:covid19_news/widgets/pageTransform/intro_page_item.dart';
import 'package:covid19_news/widgets/pageTransform/page_transformer.dart';
import 'package:flutter/material.dart';

class FeaturedView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Bsev<FeaturedBloc,FeaturedStreams>(
      builder: (context,dispatcher,streams){
        return Stack(
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Container(
                  child: _buildFeatureds(streams),
                ),
                _getProgress(streams),
              ],
            ),
            _buildConnectionError(streams, dispatcher),
          ],
        );
      },
    );
  }

  _buildFeatureds(FeaturedStreams streams){
    return StreamListener<List<Notice>>(
      stream: streams.noticies.get,
      builder: (BuildContext context,snapshot){
        List _list = snapshot.data;
        Widget featured = 
          PageTransformer(
            pageViewBuilder: (context,visibilityResolver){
              return new PageView.builder(
                controller: new PageController(viewportFraction: 0.9),
                itemCount: _list.length,
                itemBuilder: (context,index){
                  final item = IntroNews.fromNotice(_list[index]);
                  final pageVisibility = 
                      visibilityResolver.resolvePageVisibility(index);
                  return new IntroNewsItem(item: item, pageVisibility: pageVisibility);
                }
              );
            },
          );
        return AnimatedOpacity(
          opacity: _list.length > 0 ? 1 : 0,
          duration: Duration(microseconds: 300),
          child: featured,
        );
      },
    );
  }

  Widget _buildConnectionError(FeaturedStreams streams,dispatcher){
    return StreamListener<bool>(
      stream: streams.errorConnection.get,
      builder: (BuildContext context,snapshot){
        if(snapshot.data){
          return ErrorConection(
            tryAgain: (){
              dispatcher(LoadFeatured());
            });
        }else{
          return Container();
        }
      },
    );
  }
  
  Widget _getProgress(FeaturedStreams streams){
    return Center(
      child: StreamListener<bool>(
        stream: streams.progress.get,
        builder: (BuildContext context,snapshot){
          if(snapshot.data){
            return new CircularProgressIndicator();
          }else{
            return new Container();
          }
        }),
      );
  }
  
}