class ChatModel{
  String receiverId;
  String senderId;


  ChatModel({
    this.receiverId,
    this.senderId,

  });

  ChatModel.fromJson(Map<String,dynamic> json){
    receiverId = json['receiverId'];
    senderId = json['senderId'];

  }

  Map<String,dynamic> toMap(){
    return {
      'receiverId':receiverId,
      'senderId':senderId,
    };
  }
}