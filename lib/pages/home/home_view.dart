import 'package:covid19_news/pages/featured/featured_view.dart';
import 'package:covid19_news/pages/home/home_bloc.dart';
import 'package:covid19_news/pages/home/home_streams.dart';
import 'package:covid19_news/pages/news/news_view.dart';
import 'package:flutter/material.dart';
import 'package:bsev/bsev.dart';
import 'package:covid19_news/widgets/bottom_navigation.dart';

class HomeView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Bsev<HomeBloc,HomeStreams>(
      builder: (context,dispatcher,streams) {
        return Scaffold(
          body: Container(
            color: Colors.grey[200],
            child: Column(
              mainAxisSize:MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: new Container(),//TODO SearchWidget()
                ),
                Expanded(child: _getContent(streams))
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigation(
            (index){
              streams.tabPosition.set(index);
            }),
          );
      },
    );
  }

  Widget _getContent(HomeStreams streams){
    return StreamListener<int>(
      stream: streams.tabPosition.get,
      builder: (BuildContext context,snapshot){
        switch(snapshot.data){
          case 0:
            return NewsView();
            break;
          case 1:
            return NewsView();
            break;
          case 2:
            return Container();
            break;
          default:
            return Container();
        }
      },
    );
  }

}