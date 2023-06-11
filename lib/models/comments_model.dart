class CommentsModel{
  String senderId;
  String postId;
  String dateTime;
  String comment;


  CommentsModel({
    this.senderId,
    this.postId,
    this.dateTime,
    this.comment,
  });

  CommentsModel.fromJson(Map<String,dynamic> json){
    senderId = json['senderId'];
    postId = json['postId'];
    dateTime = json['dateTime'];
    comment = json['comment'];
  }

  Map<String,dynamic> toMap(){
    return {
      'senderId':senderId,
      'postId':postId,
      'dateTime':dateTime,
      'comment':comment,
    };
  }
}