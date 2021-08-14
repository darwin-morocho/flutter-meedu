library url_strategy;

export 'src/url_strategy/url_strategy_non_web.dart'
    if (dart.library.html) 'src/url_strategy/url_strategy_web.dart';
