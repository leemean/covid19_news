
import 'package:bsev/bsev.dart';
import 'package:covid19_news/pages/news/news_events.dart';
import 'package:covid19_news/pages/news/news_streams.dart';
import 'package:covid19_news/repository/model/notice.dart';
import 'package:covid19_news/repository/notice_repository.dart';
import 'package:covid19_news/support/connection/api.dart';

class NewsBloc extends BlocBase<NewsStreams>{

  final NoticeRepository repository;
  int _page = 0;
  int _currentCategory = 0;
  List<String> _categories = ['今日疫情热搜','防疫知识热搜','热搜谣言粉碎','复工复课热搜'];
  //List<Map<String,int>> _categoriesMap = [{ '今日疫情热搜' : 1},{ '防疫知识热搜' : 2},{ '热搜谣言粉碎' : 3},{ '复工复课热搜' : 4}];
  List<String> _categoriesNames = List();
  List<Notice> _newsInner = List();
  bool _carregando = false;

  NewsBloc(this.repository){
    _categories.forEach((item){_categoriesNames.add(item);});
  }

  @override
  void eventReceiver(EventsBase event) {
    if(event is LoadNews){
      _load(false);
    }

    if(event is LoadMoreNews){
      _load(true);
    }

    if(event is ClickCategory){
      _currentCategory = event.position;
      cleanList();
      _load(false);
    }
  }

  @override
  void initView() {
    streams.categoriesName.set(_categoriesNames);
    _load(false);
  }

  _load(bool isMore){
    if(!_carregando){
      _carregando = true;
      if(isMore){
        _page++;
      }else{
        _page = 0;
      }

      streams.errorConnection.set(false);
      streams.progress.set(true);

      String category = _categories[_currentCategory];

      repository.loadNews(_currentCategory.toString(), _page)
                .then((news)=>_showNews(news,isMore))
                .catchError(_showImplError);
    }
  }

  _showNews(List<Notice> news,bool isMore){
    streams.progress.set(false);

    if(isMore){
      _newsInner.addAll(news);
    }else{
      _newsInner = news;
    }

    streams.noticies.set(_newsInner);

    _carregando = false;
  }

  _showImplError(onError){
    print(onError);
    if(onError is FetchDataException){
      print("code: ${onError.code()}");
    }
    streams.errorConnection.set(true);
    streams.progress.set(false);
    _carregando = false;
  }

  void cleanList(){
    _newsInner = List();
    streams.noticies.set(_newsInner);
  }

}