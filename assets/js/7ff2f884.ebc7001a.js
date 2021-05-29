(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[429],{3905:function(e,n,t){"use strict";t.d(n,{Zo:function(){return s},kt:function(){return m}});var r=t(7294);function a(e,n,t){return n in e?Object.defineProperty(e,n,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[n]=t,e}function o(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);n&&(r=r.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,r)}return t}function i(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?o(Object(t),!0).forEach((function(n){a(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):o(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}function l(e,n){if(null==e)return{};var t,r,a=function(e,n){if(null==e)return{};var t,r,a={},o=Object.keys(e);for(r=0;r<o.length;r++)t=o[r],n.indexOf(t)>=0||(a[t]=e[t]);return a}(e,n);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(r=0;r<o.length;r++)t=o[r],n.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(a[t]=e[t])}return a}var c=r.createContext({}),u=function(e){var n=r.useContext(c),t=n;return e&&(t="function"==typeof e?e(n):i(i({},n),e)),t},s=function(e){var n=u(e.components);return r.createElement(c.Provider,{value:n},e.children)},d={inlineCode:"code",wrapper:function(e){var n=e.children;return r.createElement(r.Fragment,{},n)}},p=r.forwardRef((function(e,n){var t=e.components,a=e.mdxType,o=e.originalType,c=e.parentName,s=l(e,["components","mdxType","originalType","parentName"]),p=u(t),m=a,v=p["".concat(c,".").concat(m)]||p[m]||d[m]||o;return t?r.createElement(v,i(i({ref:n},s),{},{components:t})):r.createElement(v,i({ref:n},s))}));function m(e,n){var t=arguments,a=n&&n.mdxType;if("string"==typeof e||a){var o=t.length,i=new Array(o);i[0]=p;var l={};for(var c in n)hasOwnProperty.call(n,c)&&(l[c]=n[c]);l.originalType=e,l.mdxType="string"==typeof e?e:a,i[1]=l;for(var u=2;u<o;u++)i[u]=t[u];return r.createElement.apply(null,i)}return r.createElement.apply(null,t)}p.displayName="MDXCreateElement"},3134:function(e,n,t){"use strict";t.r(n),t.d(n,{frontMatter:function(){return i},metadata:function(){return l},toc:function(){return c},default:function(){return s}});var r=t(2122),a=t(9756),o=(t(7294),t(3905)),i={sidebar_position:10},l={unversionedId:"reactive-programming",id:"reactive-programming",isDocsHomePage:!1,title:"Reactive programming",description:"The next example create on instance of Rx to save int values, every time that _counter.value++ is called",source:"@site/docs/reactive-programming.md",sourceDirName:".",slug:"/reactive-programming",permalink:"/docs/reactive-programming",editUrl:"https://github.com/darwin-morocho/flutter-meedu/edit/master/website/docs/reactive-programming.md",version:"current",sidebarPosition:10,frontMatter:{sidebar_position:10},sidebar:"tutorialSidebar",previous:{title:"Dependency Injection",permalink:"/docs/dependency-injection"},next:{title:"Screen Utils",permalink:"/docs/screen-utils"}},c=[{value:"Working with List and Map.",id:"working-with-list-and-map",children:[]},{value:"Rx Workers",id:"rx-workers",children:[]}],u={toc:c};function s(e){var n=e.components,t=(0,a.Z)(e,["components"]);return(0,o.kt)("wrapper",(0,r.Z)({},u,t,{components:n,mdxType:"MDXLayout"}),(0,o.kt)("p",null,"The next example create on instance of ",(0,o.kt)("inlineCode",{parentName:"p"},"Rx")," to save int values, every time that ",(0,o.kt)("inlineCode",{parentName:"p"},"_counter.value++")," is called\nthe ",(0,o.kt)("inlineCode",{parentName:"p"},"RxBuilder")," rebuilds the Text widget."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:flutter/material.dart';\nimport 'package:flutter_meedu/meedu.dart';\nimport 'package:flutter_meedu/rx.dart';\n\nclass RxPage extends StatefulWidget {\n  @override\n  _RxPageState createState() => _RxPageState();\n}\n\nclass _RxPageState extends State<RxPage> {\n  final _counter = Rx<int>(0); // create an observable\n\n  @override\n  void dispose() {\n    _counter.close(); // You must call to close when you don't need the observable any more\n    super.dispose();\n  }\n\n  @override\n  Widget build(BuildContext context) {\n    return Scaffold(\n      body: Center(\n        child: RxBuilder(\n          (_) => Text(\"${_counter.value}\"),\n        ),\n      ),\n      floatingActionButton: FloatingActionButton(\n        onPressed: () {\n          _counter.value++;\n        },\n      ),\n    );\n  }\n}\n")),(0,o.kt)("div",{className:"admonition admonition-note alert alert--secondary"},(0,o.kt)("div",{parentName:"div",className:"admonition-heading"},(0,o.kt)("h5",{parentName:"div"},(0,o.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,o.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,o.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.3 5.69a.942.942 0 0 1-.28-.7c0-.28.09-.52.28-.7.19-.18.42-.28.7-.28.28 0 .52.09.7.28.18.19.28.42.28.7 0 .28-.09.52-.28.7a1 1 0 0 1-.7.3c-.28 0-.52-.11-.7-.3zM8 7.99c-.02-.25-.11-.48-.31-.69-.2-.19-.42-.3-.69-.31H6c-.27.02-.48.13-.69.31-.2.2-.3.44-.31.69h1v3c.02.27.11.5.31.69.2.2.42.31.69.31h1c.27 0 .48-.11.69-.31.2-.19.3-.42.31-.69H8V7.98v.01zM7 2.3c-3.14 0-5.7 2.54-5.7 5.68 0 3.14 2.56 5.7 5.7 5.7s5.7-2.55 5.7-5.7c0-3.15-2.56-5.69-5.7-5.69v.01zM7 .98c3.86 0 7 3.14 7 7s-3.14 7-7 7-7-3.12-7-7 3.14-7 7-7z"}))),"note")),(0,o.kt)("div",{parentName:"div",className:"admonition-content"},(0,o.kt)("p",{parentName:"div"},"You can create observables for String,int,double ot booleans using the ",(0,o.kt)("inlineCode",{parentName:"p"},".obs")," extension"),(0,o.kt)("ul",{parentName:"div"},(0,o.kt)("li",{parentName:"ul"},(0,o.kt)("inlineCode",{parentName:"li"},"final _counter = 0.obs; // equals to final Rx<int> _counter = Rx(0);")),(0,o.kt)("li",{parentName:"ul"},(0,o.kt)("inlineCode",{parentName:"li"},"final _enabled = false.obs; // equals to final Rx<bool> _enabled = Rx(false);")),(0,o.kt)("li",{parentName:"ul"},(0,o.kt)("inlineCode",{parentName:"li"},'final _query = "".obs; // equals to final Rx<String> _query = Rx("");')),(0,o.kt)("li",{parentName:"ul"},(0,o.kt)("inlineCode",{parentName:"li"},"final _price = 9.99.obs; // equals to final Rx<double> _price = Rx(9.99);"))))),(0,o.kt)("h2",{id:"working-with-list-and-map"},"Working with List and Map."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"Rx<List<int>> numbers = Rx([]);\n\nvoid add(int number){\n    final copy = [...numbers.value]; // equals to List<int>.from(numbers.value);\n    copy.add(number);\n    numbers.value = copy;\n}\n\nvoid remove(int index){\n    final copy = [...numbers.value];\n    copy.removeAt(index);\n    numbers.value = copy;\n}\n\nvoid update(int index, int number){\n    final copy = [...numbers.value];\n    copy[index] = number;\n    numbers.value = copy;\n}\n")),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"Rx<Map<String, dynamic>> data = Rx({});\n\nvoid add(String key, dynamic value) {\n  final copy = {...data.value};// equals to Map<String, dynamic>.from(data.value);\n  copy[key] = value;\n  data.value = copy;\n}\nvoid remove(String key) {\n  final copy = {...data.value};\n  copy.remove(key);\n  data.value = copy;\n}\n")),(0,o.kt)("h2",{id:"rx-workers"},"Rx Workers"),(0,o.kt)("p",null,"You can use the Rx class to use some utils methods like debounce, once, ever and interval."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},'class SearchController extends SimpleNotifier {\n  final Rx<String> _text = "".obs;\n  RxWorker? _debounceWorker, _everWorker, _onceWorker, _intervalWorker;\n\n  void onTextChange(String text) {\n    _text.value = text;\n  }\n\n  SearchController(){\n      _init();\n  }\n\n  void _init() {\n\n    // called every time after a certain duration\n    _debounceWorker = _text.debounce(Duration(milliseconds: 500), (value) {\n      print("debounce  $value");\n    });\n\n    // called every time\n    _everWorker = _text.ever(\n      (value) {\n        print("ever  $value");\n      },\n      condition: (value) => value.contains("@"),\n    );\n\n    // called only once time\n    _onceWorker = _text.once(\n      (value) {\n        print("once  $value");\n      },\n      condition: (value) => value.contains("-"),\n    );\n\n    // called each a certain duration\n    _intervalWorker = _text.interval(Duration(seconds: 2), (value) {\n      print("interval  $value");\n    });\n  }\n\n  @override\n  void onDispose() {\n    _text.close();\n    _debounceWorker?.dispose();\n    _everWorker?.dispose();\n    _onceWorker?.dispose();\n    _intervalWorker?.dispose();\n    super.onDispose();\n  }\n}\n')))}s.isMDXComponent=!0}}]);