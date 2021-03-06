

import 'package:bsev/bsev.dart';
import 'package:covid19_news/pages/news/news_bloc.dart';
import 'package:covid19_news/pages/news/news_events.dart';
import 'package:covid19_news/pages/news/news_streams.dart';
import 'package:covid19_news/repository/model/notice.dart';
import 'package:covid19_news/widgets/AnimatedContent.dart';
import 'package:covid19_news/widgets/custom_tab.dart';
import 'package:covid19_news/widgets/error_conection.dart';
import 'package:flutter/material.dart';

class NewsView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Bsev<NewsBloc,NewsStreams>(
      builder: (context,dispatcher,streams){
        return new Container(
          padding: EdgeInsets.only(top: 2.0),
          child: new Stack(
            children: <Widget>[
              _getListViewWidget(streams,dispatcher),
              _buildConnectionError(streams, dispatcher),
              _getProgress(streams),
              _getListCategory(streams, dispatcher),
            ],
          )
        );
      },
    );
  }

  Widget _buildConnectionError(NewsStreams streams,dispatcher){
    return StreamListener<bool>(
      stream: streams.errorConnection.get,
      builder: (BuildContext context,snapshot){
        if(snapshot.data){
          return ErrorConection(
            tryAgain: (){
              dispatcher(LoadNews());
            });
        }else{
          return Container();
        }
      },
    );
  }

  Widget _getListViewWidget(NewsStreams streams,dispatcher){
    return Container(
      child: StreamListener<List<Notice>>(
        stream: streams.noticies.get,
        builder: (_,snapshot){
          List news = snapshot.data;
          ListView listView = new ListView.builder(
            itemCount: news.length,
            padding: new EdgeInsets.only(top: 3.0),
            itemBuilder: (context,index){
              if(index == 0){
                return Container(
                  margin: EdgeInsets.only(top: 50.0),
                  child: news[index],
                );
              }else{
                if(index + 1 >= news.length){
                  dispatcher(LoadMoreNews());
                }
                return news[index];
              }
            }
          );
          return AnimatedContent(
            show: news.length > 0,
            child: RefreshIndicator(child: listView, onRefresh: (){return myRefresh(dispatcher);}),
          );
        },
        ),
    );
  }

  Widget _getProgress(NewsStreams streams){
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

  Widget _getListCategory(NewsStreams streams,dispatcher){
    return StreamListener<List<String>>(
      stream: streams.categoriesName.get,
      builder: (_,snapshot){
        List<String> list = snapshot.data;
        return CustomTab(
          items: list,
          tabSelected: (index){
            dispatcher(ClickCategory()..position = index);
          }
        );
      },
    );
  }

  Future<Null> myRefresh(dispatcher) async{
    dispatcher(LoadNews());
  }
}