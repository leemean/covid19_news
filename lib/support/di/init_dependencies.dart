import 'package:bsev/bsev.dart';
// import 'package:bsev/flavors.dart';
import 'package:covid19_news/pages/featured/featured_bloc.dart';
import 'package:covid19_news/pages/featured/featured_streams.dart';
import 'package:covid19_news/pages/home/home_bloc.dart';
import 'package:covid19_news/pages/home/home_streams.dart';
import 'package:covid19_news/pages/news/news_bloc.dart';
import 'package:covid19_news/pages/news/news_streams.dart';
import 'package:covid19_news/repository/notice_repository.dart';
import 'package:covid19_news/support/connection/api.dart';

initDependencies(){
  injectRepository();
  injectBlocs();
}

injectBlocs(){
  registerBlocFactory<HomeBloc, HomeStreams>(
      (i) => HomeBloc(), () => HomeStreams());
  registerBlocFactory<NewsBloc, NewsStreams>(
      (i) => NewsBloc(i.getDependency()), () => NewsStreams());
  registerBlocFactory<FeaturedBloc, FeaturedStreams>(
      (i) => FeaturedBloc(i.getDependency()), () => FeaturedStreams());
}

injectRepository() {
  registerSingleton((i) {
    Api _api = Api("http://10.0.2.2:5000");
    // switch (Flavors().getFlavor()) {
    //   case Flavor.PROD:
    //     _api = Api("http://104.131.18.84");
    //     break;
    //   case Flavor.HML:
    //     _api = Api("");
    //     break;
    //   case Flavor.DEBUG:
    //     _api = Api("");
    //     break;
    // }
    return _api;
  });

  registerDependency<NoticeRepository>(
      (i) => NoticeRepositoryImpl(i.getDependency()));
}