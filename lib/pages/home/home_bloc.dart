import 'package:bsev/bsev.dart';
import 'package:covid19_news/pages/home/home_streams.dart';

class HomeBloc extends BlocBase<HomeStreams>{
  HomeBloc(){
    streams = HomeStreams();
  }

  @override
  void eventReceiver(EventsBase event) {
    // TODO: implement eventReceiver
  }

  @override
  void initView() {
    // TODO: implement initView
  }
}