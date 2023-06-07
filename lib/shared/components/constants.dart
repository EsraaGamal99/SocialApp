import '../../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

String uId='';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    }
  });
}
