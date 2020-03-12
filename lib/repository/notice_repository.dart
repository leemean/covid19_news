
import 'package:covid19_news/support/connection/api.dart';
import 'package:covid19_news/repository/model/notice.dart';

abstract class NoticeRepository{
  Future<List<Notice>> loadNews(String category,int page);
  Future<List<Notice>> loadNewsRecent();
  Future<List<Notice>> loadSearch(String query);
}

class NoticeRepositoryImpl extends NoticeRepository
{
  final Api _api;

  NoticeRepositoryImpl(this._api);

  @override
  Future<List<Notice>> loadNews(String category, int page) async {
    final Map result = await _api.get("/news/$category");
    return result['data'].map<Notice>((notice) => new Notice.fromMap(notice)).toList();
  }

  @override
  Future<List<Notice>> loadNewsRecent() async {
    final Map result = await _api.get("/notice/news/recent");
    return result['data'].map<Notice>((notice) => new Notice.fromMap(notice)).toList();
  }

  @override
  Future<List<Notice>> loadSearch(String query) async {
    final Map result = await _api.get("/notice/news/$query");
    if(result['op']){
      return result['data'].map<Notice>((notice) => new Notice.fromMap(notice)).toList();
    }else{
      return List();
    }
  }
}