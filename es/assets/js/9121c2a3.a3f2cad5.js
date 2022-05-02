(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[9456],{3905:function(e,t,n){"use strict";n.d(t,{Zo:function(){return d},kt:function(){return m}});var a=n(7294);function i(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function r(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);t&&(a=a.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,a)}return n}function o(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?r(Object(n),!0).forEach((function(t){i(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):r(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function s(e,t){if(null==e)return{};var n,a,i=function(e,t){if(null==e)return{};var n,a,i={},r=Object.keys(e);for(a=0;a<r.length;a++)n=r[a],t.indexOf(n)>=0||(i[n]=e[n]);return i}(e,t);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);for(a=0;a<r.length;a++)n=r[a],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(i[n]=e[n])}return i}var c=a.createContext({}),l=function(e){var t=a.useContext(c),n=t;return e&&(n="function"==typeof e?e(t):o(o({},t),e)),n},d=function(e){var t=l(e.components);return a.createElement(c.Provider,{value:t},e.children)},p={inlineCode:"code",wrapper:function(e){var t=e.children;return a.createElement(a.Fragment,{},t)}},u=a.forwardRef((function(e,t){var n=e.components,i=e.mdxType,r=e.originalType,c=e.parentName,d=s(e,["components","mdxType","originalType","parentName"]),u=l(n),m=i,h=u["".concat(c,".").concat(m)]||u[m]||p[m]||r;return n?a.createElement(h,o(o({ref:t},d),{},{components:n})):a.createElement(h,o({ref:t},d))}));function m(e,t){var n=arguments,i=t&&t.mdxType;if("string"==typeof e||i){var r=n.length,o=new Array(r);o[0]=u;var s={};for(var c in t)hasOwnProperty.call(t,c)&&(s[c]=t[c]);s.originalType=e,s.mdxType="string"==typeof e?e:i,o[1]=s;for(var l=2;l<r;l++)o[l]=n[l];return a.createElement.apply(null,o)}return a.createElement.apply(null,n)}u.displayName="MDXCreateElement"},6978:function(e,t,n){"use strict";n.r(t),n.d(t,{frontMatter:function(){return o},metadata:function(){return s},toc:function(){return c},default:function(){return d}});var a=n(2122),i=n(9756),r=(n(7294),n(3905)),o={},s={unversionedId:"persistent-state",id:"version-6.x.x/persistent-state",isDocsHomePage:!1,title:"Persistent state",description:"Since flutter_meedu:^6.2.3 the StateNotifier class allows you to keep the state of your Notifiers even if the app was killed (very useful when you want to add OFFLINE support to your apps).",source:"@site/versioned_docs/version-6.x.x/persistent-state.md",sourceDirName:".",slug:"/persistent-state",permalink:"/es/docs/6.x.x/persistent-state",editUrl:"https://github.com/darwin-morocho/flutter-meedu/edit/master/website/i18n/es/docusaurus-plugin-content-docs/current",version:"6.x.x",lastUpdatedBy:"Darwin",lastUpdatedAt:1651503966,formattedLastUpdatedAt:"2/5/2022",frontMatter:{},sidebar:"version-6.x.x/mySidebar",previous:{title:"Dependency Injection",permalink:"/es/docs/6.x.x/dependency-injection"},next:{title:"Reactive programming",permalink:"/es/docs/6.x.x/reactive-programming"}},c=[{value:"Example using Hive as database",id:"example-using-hive-as-database",children:[]}],l={toc:c};function d(e){var t=e.components,n=(0,i.Z)(e,["components"]);return(0,r.kt)("wrapper",(0,a.Z)({},l,n,{components:t,mdxType:"MDXLayout"}),(0,r.kt)("p",null,"Since ",(0,r.kt)("inlineCode",{parentName:"p"},"flutter_meedu:^6.2.3")," the ",(0,r.kt)("inlineCode",{parentName:"p"},"StateNotifier")," class allows you to keep the state of your Notifiers even if the app was killed (very useful when you want to add OFFLINE support to your apps)."),(0,r.kt)("p",null,"For this just use the ",(0,r.kt)("inlineCode",{parentName:"p"},"PersistentStateMixin")," mixin and the ",(0,r.kt)("inlineCode",{parentName:"p"},"PersistentStateStorage")," class then you must override the all properties and methods necessary to persist the state of your StateNotifier."),(0,r.kt)("p",null,"Considere the next example you want to build a city picker page and every time that you show that page you have to make an API request to get a list of cities. So, why don't you cache the cities and the next time that you show the city picker you will be using a cached list of cities instead of making a new API request?"),(0,r.kt)("h2",{id:"example-using-hive-as-database"},"Example using Hive as database"),(0,r.kt)("p",null,"The next class will be used for you state "),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-dart"},"\nclass CityPickerState extends Equatable {\n  final bool loading;\n  final List<City> cities;\n\n  const CityPickerState({\n    required this.loading,\n    required this.cities,\n  });\n\n  static CityPickerState get initialState => CityPickerState(\n        loading: true,\n        cities: [],\n      );\n\n  CityPickerState copyWith({\n    bool? loading,\n    List<City>? cities,\n  }) {\n    return CityPickerState(\n      loading: loading ?? this.loading,\n      cities: cities ?? this.cities,\n    );\n  }\n\n  factory CityPickerState.fromJson(Map<String, dynamic> json) {\n    return CityPickerState(\n      loading: json['loading'],\n      cities: (json['cities'] as List)\n          .map(\n            (e) => City.fromJson(e),\n          )\n          .toList(),\n    );\n  }\n\n  /// conver this instance to one JSON map\n  Map<String, dynamic> toJson() => {\n        'loading': loading,\n        'cities': cities\n            .map(\n              (e) => e.toJson(),\n            )\n            .toList(),\n      };\n\n  @override\n  List<Object?> get props => [\n        loading,\n        cities,\n      ];\n}\n\nclass City extends Equatable {\n  final int id;\n  final String name;\n\n  const City({\n    required this.id,\n    required this.name,\n  });\n\n  /// convert this instance to one JSON map\n  Map<String, dynamic> toJson() => {\n        'id': id,\n        'name': name,\n      };\n\n  /// return one instance of City from a JSON map\n  factory City.fromJson(Map<String, dynamic> json) {\n    return City(\n      id: json['id'],\n      name: json['name'],\n    );\n  }\n\n  @override\n  List<Object?> get props => [\n        id,\n        name,\n      ];\n}\n")),(0,r.kt)("p",null,"Next you have to create your storage"),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-dart"},"import 'dart:convert';\n\nimport 'package:flutter_meedu/meedu.dart';\nimport 'package:hive/hive.dart';\n\nclass MyPersistentStorage implements PersistentStateStorage {\n  final Box _box = Get.find();\n\n  /// delete one specific state\n  @override\n  Future<void> delete(String key) {\n    return _box.delete(key);\n  }\n\n  /// delete all states in your storage\n  @override\n  Future<void> deleteAll() {\n    return _box.clear();\n  }\n\n  /// check an state with the provided key exists in the\n  /// storage and return it as a JSON map\n  @override\n  Map<String,dynamic>? get(String key) {\n    final dataAsString = _box.get(key);\n    if (dataAsString != null) {\n      return jsonDecode(dataAsString);\n    }\n    return null;\n  }\n\n  @override\n  Future<void> save(String key, Map<String,dynamic> json) {\n    return _box.put(\n      key,\n      jsonEncode(json),\n    );\n  }\n}\n")),(0,r.kt)("div",{className:"admonition admonition-note alert alert--secondary"},(0,r.kt)("div",{parentName:"div",className:"admonition-heading"},(0,r.kt)("h5",{parentName:"div"},(0,r.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,r.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,r.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.3 5.69a.942.942 0 0 1-.28-.7c0-.28.09-.52.28-.7.19-.18.42-.28.7-.28.28 0 .52.09.7.28.18.19.28.42.28.7 0 .28-.09.52-.28.7a1 1 0 0 1-.7.3c-.28 0-.52-.11-.7-.3zM8 7.99c-.02-.25-.11-.48-.31-.69-.2-.19-.42-.3-.69-.31H6c-.27.02-.48.13-.69.31-.2.2-.3.44-.31.69h1v3c.02.27.11.5.31.69.2.2.42.31.69.31h1c.27 0 .48-.11.69-.31.2-.19.3-.42.31-.69H8V7.98v.01zM7 2.3c-3.14 0-5.7 2.54-5.7 5.68 0 3.14 2.56 5.7 5.7 5.7s5.7-2.55 5.7-5.7c0-3.15-2.56-5.69-5.7-5.69v.01zM7 .98c3.86 0 7 3.14 7 7s-3.14 7-7 7-7-3.12-7-7 3.14-7 7-7z"}))),"note")),(0,r.kt)("div",{parentName:"div",className:"admonition-content"},(0,r.kt)("p",{parentName:"div"},"Note that in the above code we use ",(0,r.kt)("inlineCode",{parentName:"p"},"jsonEncode")," to store the json state as a string to avoid to define custom ",(0,r.kt)("inlineCode",{parentName:"p"},"TypeAdapters")," for Hive. Also we use ",(0,r.kt)("inlineCode",{parentName:"p"},"jsonDecode")," to convert the json string to a Map."),(0,r.kt)("p",{parentName:"div"},"You are free to use any other Database."))),(0,r.kt)("p",null,"Now in your ",(0,r.kt)("inlineCode",{parentName:"p"},"main")," inject a ",(0,r.kt)("inlineCode",{parentName:"p"},"Hive box")," as a dependency."),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-dart"},"void main() async {\n  await injectDependencies();\n  runApp(const MyApp());\n}\n\n.\n.\n.\n\n\nFuture<void> injectDependencies() async {\n  await Hive.initFlutter();\n\n  // box that will be  used to store your states\n  final box = await Hive.openBox('states');\n  Get.put<Box>(box);\n}\n")),(0,r.kt)("p",null,"Now we must create the ",(0,r.kt)("inlineCode",{parentName:"p"},"StateNotifier")," and use the ",(0,r.kt)("inlineCode",{parentName:"p"},"PersistentStateMixin")," mixin."),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-dart"},"class CityPickerController extends StateNotifier<CityPickerState> with PersistentStateMixin {\n\n  CityPickerController() : super(CityPickerState.initialState);\n\n\n  Future<void> loadCities() async {\n    /// if you don't have a cached state\n    if (state.cities.isEmpty) {\n      final cities = await getCitiesFromYourAPI();\n      state = state.copyWith(\n        loading: false,\n        cities: cities,\n      );\n    }\n  }\n\n  @override\n  CityPickerState? fromJson(Map<String,dynamic> json) {\n    return CityPickerState.fromJson(json);\n  }\n\n  @override\n  String get storageKey => 'my_unique_id';\n\n  @override\n  PersistentStateStorage get storage => MyPersistentStorage(); // <--YOUR STORAGE\n\n  @override\n  Map<String,dynamic>? toJson(CityPickerState state) {\n    if (state.cities.isNotEmpty) {\n      return state.toJson();\n    }\n    return null;\n  }\n}\n")),(0,r.kt)("p",null,"In the above code the ",(0,r.kt)("inlineCode",{parentName:"p"},"PersistentStateMixin")," mixin forces you to override:"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"storageKey")," : an unique string used to idenfier your state in the storage."),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"storage"),": one instance of a class that implements ",(0,r.kt)("inlineCode",{parentName:"li"},"MyPersistentStorage")," and all logic to save and read your state."),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"toJson"),": a method to parse your current state as a json and save it in the storage. This method will be called every time that the state of your Notifier changes. If ",(0,r.kt)("inlineCode",{parentName:"li"},"toJson")," returns null when the current state saved in your storage won't be modified."),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("inlineCode",{parentName:"li"},"fromJson"),": This method is called only once when the ",(0,r.kt)("inlineCode",{parentName:"li"},"PersistentStateMixin")," is detecting that your are trying to get your current state for the first time then is the moment to check if a previous state was saved in the storage, next the ",(0,r.kt)("inlineCode",{parentName:"li"},"fromJson")," method will be used to parse the json saved in your storage into one instance of your ",(0,r.kt)("inlineCode",{parentName:"li"},"State"),".")),(0,r.kt)("div",{className:"admonition admonition-note alert alert--secondary"},(0,r.kt)("div",{parentName:"div",className:"admonition-heading"},(0,r.kt)("h5",{parentName:"div"},(0,r.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,r.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,r.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.3 5.69a.942.942 0 0 1-.28-.7c0-.28.09-.52.28-.7.19-.18.42-.28.7-.28.28 0 .52.09.7.28.18.19.28.42.28.7 0 .28-.09.52-.28.7a1 1 0 0 1-.7.3c-.28 0-.52-.11-.7-.3zM8 7.99c-.02-.25-.11-.48-.31-.69-.2-.19-.42-.3-.69-.31H6c-.27.02-.48.13-.69.31-.2.2-.3.44-.31.69h1v3c.02.27.11.5.31.69.2.2.42.31.69.31h1c.27 0 .48-.11.69-.31.2-.19.3-.42.31-.69H8V7.98v.01zM7 2.3c-3.14 0-5.7 2.54-5.7 5.68 0 3.14 2.56 5.7 5.7 5.7s5.7-2.55 5.7-5.7c0-3.15-2.56-5.69-5.7-5.69v.01zM7 .98c3.86 0 7 3.14 7 7s-3.14 7-7 7-7-3.12-7-7 3.14-7 7-7z"}))),"note")),(0,r.kt)("div",{parentName:"div",className:"admonition-content"},(0,r.kt)("p",{parentName:"div"},"You can override the ",(0,r.kt)("inlineCode",{parentName:"p"},"onPersistentStateError")," method to listen when a state couldn't be saved or it couldn't be parsed."))),(0,r.kt)("div",{className:"admonition admonition-success alert alert--success"},(0,r.kt)("div",{parentName:"div",className:"admonition-heading"},(0,r.kt)("h5",{parentName:"div"},(0,r.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,r.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"12",height:"16",viewBox:"0 0 12 16"},(0,r.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.5 0C3.48 0 1 2.19 1 5c0 .92.55 2.25 1 3 1.34 2.25 1.78 2.78 2 4v1h5v-1c.22-1.22.66-1.75 2-4 .45-.75 1-2.08 1-3 0-2.81-2.48-5-5.5-5zm3.64 7.48c-.25.44-.47.8-.67 1.11-.86 1.41-1.25 2.06-1.45 3.23-.02.05-.02.11-.02.17H5c0-.06 0-.13-.02-.17-.2-1.17-.59-1.83-1.45-3.23-.2-.31-.42-.67-.67-1.11C2.44 6.78 2 5.65 2 5c0-2.2 2.02-4 4.5-4 1.22 0 2.36.42 3.22 1.19C10.55 2.94 11 3.94 11 5c0 .66-.44 1.78-.86 2.48zM4 14h5c-.23 1.14-1.3 2-2.5 2s-2.27-.86-2.5-2z"}))),"success")),(0,r.kt)("div",{parentName:"div",className:"admonition-content"},(0,r.kt)("p",{parentName:"div"},"You can check  a complete example using freezed unions\n",(0,r.kt)("a",{parentName:"p",href:"https://github.com/darwin-morocho/flutter-meedu/tree/master/examples/persistent_state"},"here")))))}d.isMDXComponent=!0}}]);