abstract class AppStates{}

class GetUserInitialState extends AppStates{}

class GetUserLoadingState extends AppStates{}

class GetUserSuccessState extends AppStates{}

class GetUserErrorState extends AppStates{
  final String error;

  GetUserErrorState(this.error);
}

class GetAllUsersLoadingState extends AppStates{}

class GetAllUsersSuccessState extends AppStates{}

class GetAllUsersErrorState extends AppStates{
  final String error;

  GetAllUsersErrorState(this.error);
}

class GetPostsLoadingState extends AppStates{}

class GetPostsSuccessState extends AppStates{}

class GetPostsErrorState extends AppStates{
  final String error;

  GetPostsErrorState(this.error);
}

class LikePostSuccessState extends AppStates{}

class LikePostErrorState extends AppStates{
  final String error;

  LikePostErrorState(this.error);
}

class CommentPostSuccessState extends AppStates{}

class CommentPostErrorState extends AppStates{
  final String error;

  CommentPostErrorState(this.error);
}

class NewPostState extends AppStates{}

class ChangeNavBarState extends AppStates{}

class ImagePicSuccessState extends AppStates{}

class ImagePicErrorState extends AppStates{}

class CoverPicSuccessState extends AppStates{}

class CoverPicErrorState extends AppStates{}

class UploadProfileImageSuccessState extends AppStates{}

class UploadProfileImageErrorState extends AppStates{}

class UploadCoverImageSuccessState extends AppStates{}

class UploadCoverImageErrorState extends AppStates{}

class UpdateUserLoadingState extends AppStates{}

class UpdateUserErrorState extends AppStates{}

class UpdateProfileImageSuccessState extends AppStates{}

class UpdateProfileImageErrorState extends AppStates{}

class UpdateCoverImageSuccessState extends AppStates{}

class UpdateCoverImageErrorState extends AppStates{}

//Create Post
class CreatePostImageLoadingState extends AppStates{}

class CreatePostImageSuccessState extends AppStates{}

class CreatePostImageErrorState extends AppStates{}

class CreatePostLoadingState extends AppStates{}

class CreatePostSuccessState extends AppStates{}

class CreatePostErrorState extends AppStates{}

class RemovePostImageState extends AppStates{}