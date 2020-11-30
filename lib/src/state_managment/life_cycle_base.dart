/// interface to define the LifeCycle strcuture
abstract class LifeCycleBase {
  void onInit();
  void afterFirstLayout();
  Future<void> onDispose();
}
