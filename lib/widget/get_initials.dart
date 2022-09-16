
class GetInitials{

  static getInitials({required String string,required int limitTo}) {
    var buffer = StringBuffer();
    var split = string.split(' ');
    for (var i = 0 ; i < (split.length > 1? limitTo:split.length); i ++) {
      buffer.write(split[i][0]);
    }
    //projectNameInitials.add(buffer.toString());
  }
}