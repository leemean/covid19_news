

import 'package:bsev/bsev.dart';
import 'package:covid19_news/repository/model/notice.dart';

class NewsStreams extends StreamsBase{
  BehaviorSubjectCreate<bool> errorConnection = BehaviorSubjectCreate();
  BehaviorSubjectCreate<bool> progress = BehaviorSubjectCreate();
  BehaviorSubjectCreate<List<Notice>> noticies = BehaviorSubjectCreate();
  BehaviorSubjectCreate<List<String>> categoriesName = BehaviorSubjectCreate();

  @override
  void dispose(){
    progress.close();
    errorConnection.close();
    noticies.close();
    categoriesName.close();
  }
}