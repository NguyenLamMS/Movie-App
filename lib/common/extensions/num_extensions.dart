extension NumExtension on num{
  String converToPercentageString(){
    return ((this ?? 0) * 10).toStringAsFixed(0) + '%';
  }
}