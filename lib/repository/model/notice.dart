import 'package:covid19_news/pages/detail/detail.dart';
import 'package:flutter/material.dart';
import 'package:covid19_news/support/util/functions.dart';
import 'package:covid19_news/support/util/date_util.dart';

class Notice extends StatelessWidget{
  var crawlTime;
  var keyWord;
  var title;
  var author;
  var img;
  var date;
  var category;
  var description;
  var article;
  var link;
  var origin;

  AnimationController animationController;

  Notice(this.crawlTime,this.keyWord,this.title,this.author,this.img,
    this.date,this.category,this.description,this.article,this.link,this.origin);

  Notice.fromMap(Map<String, dynamic>  map) :
        
        keyWord = map['key_word'],
        title = map['title'],
        author = map['author'],
        img = map['img'],
        date = map['publish_date'] + ' ' + map['publish_time'],
        category = map['category'],
        description = map['description'],
        article = map['article'],
        link = map['link'],
        origin = map['author'];

  BuildContext _context;

  @override
  Widget build(BuildContext context){
    this._context = context;
    return new GestureDetector(
      onTap: _handleTapUp,
      child: new Material(
        borderRadius: new BorderRadius.circular(6.0),
        elevation: 2.0,
        child: _getListTile(),
      ),
    );
  }

  Widget _getListTile(){
    return new Container(
      height: 105.0,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Hero(tag: title, child: _getImgWidget(Functions.getImgResizeUrl(this.img, 200, 200)),
          ),
          _getColumnText(title,date,description)
        ]
      ),
    );
  }

  Widget _getImgWidget(String url){
    return new Container(
      width: 105.0,
      height: 105.0,
      child: new ClipRRect(
        borderRadius: new BorderRadius.only(topLeft: const Radius.circular(6.0),bottomLeft: const Radius.circular(6.0)),
        child: _getImageNetwork(url),
      )
    );
  }

  Widget _getImageNetwork(String url){
    try{
      if(url.isNotEmpty){
        return new FadeInImage.assetNetwork(
          placeholder: 'assets/place_holder.jpg', 
          image: url,
          fit: BoxFit.cover,
        );
      }else{
        return new Image.asset('assets/place_holder.jpg');
      }
    }catch(e){
      return new Image.asset('assets/place_holder.jpg');
    }
  }

  _handleTapUp(){
    Navigator.of(_context).push(
      new MaterialPageRoute(builder:(BuildContext context){
        return DetailPage(img,title,date,description,category,link,origin);
      })
    );
  }

  Widget _getColumnText(title,date,description){
    return new Expanded(
      child: new Container(
        margin: new EdgeInsets.all(10.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getTitleWidget(title),
            _getDateWidget(date),
            _getDescriptionWidget(description),
          ],
          )
      ),
    );
  }

  Text _getTitleWidget(String title){
    return new Text(
      title,
      maxLines: 1,
      style: new TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _getDateWidget(String date){
    return new Text(new DateUtil().buildDate(date),style: new TextStyle(color: Colors.grey,fontSize:10.0),);
  }

  Widget _getDescriptionWidget(String description){
    return new Container(
      margin: new EdgeInsets.only(top: 5.0),
      child: new Text(description,maxLines: 2,),
    );
  }
}