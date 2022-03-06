# Persistent state

Since `flutter_meedu:^6.1.0` the `StateNotifier` class allows you to keep the state of your Notifiers even if the app was killed (very useful when you want to add OFFLINE support to your apps).

For this just use the `PersistentStateMixin` mixin and override the all properties and methods necessary to persist the state of your StateNotifier.



Considere the next example you want to build a city picker page and every time that you show that page you have to make an API request to get a list of cities. So, why don't you cache the cities and the next time that you show the city picker you will be using a cached list of cities instead of making a new API request?