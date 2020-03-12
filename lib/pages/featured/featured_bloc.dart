
import 'package:bsev/bsev.dart';
import 'package:covid19_news/pages/featured/featured_events.dart';
import 'package:covid19_news/pages/featured/featured_streams.dart';
import 'package:covid19_news/repository/model/notice.dart';
import 'package:covid19_news/repository/notice_repository.dart';
import 'package:covid19_news/support/connection/api.dart';

class FeaturedBloc extends BlocBase<FeaturedStreams>{

  final NoticeRepository repository;
  FeaturedBloc(this.repository);

  @override
  void eventReceiver(EventsBase event) {
    if(event is LoadFeatured){
      _load();
    }
  }

  @override
  void initView() {
    _load();
  }

  _load(){
    streams.progress.set(true);
    streams.errorConnection.set(false);
    repository.loadNewsRecent().then((news) => _showNews(news)).catchError(_showImplError);
  }

  _showNews(List<Notice> news){
    streams.progress.set(false);
    streams.noticies.set(news);
  }

  _showImplError(onError){
    print(onError);
    if(onError is FetchDataException){
      print("code: ${onError.code()}");
    }
    streams.errorConnection.set(true);
    streams.progress.set(false);
  }
  
}