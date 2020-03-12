
import 'package:bsev/bsev.dart';
import 'package:covid19_news/repository/model/notice.dart';

class FeaturedStreams extends StreamsBase{
  BehaviorSubjectCreate<bool> progress = BehaviorSubjectCreate();
  BehaviorSubjectCreate<bool> errorConnection = BehaviorSubjectCreate();
  BehaviorSubjectCreate<List<Notice>> noticies = BehaviorSubjectCreate(initValue: List());

  @override
  void dispose(){
    progress.close();
    errorConnection.close();
    noticies.close();
  }

}