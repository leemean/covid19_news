class DateUtil{
  var mouths = ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月',];
  String buildDate(String date){
    try{
      var datetime = DateTime.parse(date);
      return date; //TODO 日期格式转换
    }catch(e){
      return "";
    }
  }
}