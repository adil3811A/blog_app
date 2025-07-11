
int calCulateReadingTime(
    String content,
    ){
  final wordCount = content.split(RegExp(r'\s+')).length;
  int time = (wordCount/225).toInt().ceil();
  if(time<1){
    return 1;
  }else{
    return time;
  }
}