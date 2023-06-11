class MessageModel{
  String senderId;
  String receiverId;
  String dateTime;
  String msg;


  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.msg,
  });

  MessageModel.fromJson(Map<String,dynamic> json){
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    msg = json['msg'];
  }

  Map<String,dynamic> toMap(){
    return {
      'senderId':senderId,
      'receiverId':receiverId,
      'dateTime':dateTime,
      'msg':msg,
    };
  }
}