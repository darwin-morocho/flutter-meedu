(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[8273],{3905:function(e,n,t){"use strict";t.d(n,{Zo:function(){return c},kt:function(){return m}});var r=t(7294);function o(e,n,t){return n in e?Object.defineProperty(e,n,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[n]=t,e}function a(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);n&&(r=r.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,r)}return t}function i(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?a(Object(t),!0).forEach((function(n){o(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):a(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}function l(e,n){if(null==e)return{};var t,r,o=function(e,n){if(null==e)return{};var t,r,o={},a=Object.keys(e);for(r=0;r<a.length;r++)t=a[r],n.indexOf(t)>=0||(o[t]=e[t]);return o}(e,n);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);for(r=0;r<a.length;r++)t=a[r],n.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(o[t]=e[t])}return o}var d=r.createContext({}),s=function(e){var n=r.useContext(d),t=n;return e&&(t="function"==typeof e?e(n):i(i({},n),e)),t},c=function(e){var n=s(e.components);return r.createElement(d.Provider,{value:n},e.children)},u={inlineCode:"code",wrapper:function(e){var n=e.children;return r.createElement(r.Fragment,{},n)}},p=r.forwardRef((function(e,n){var t=e.components,o=e.mdxType,a=e.originalType,d=e.parentName,c=l(e,["components","mdxType","originalType","parentName"]),p=s(t),m=o,h=p["".concat(d,".").concat(m)]||p[m]||u[m]||a;return t?r.createElement(h,i(i({ref:n},c),{},{components:t})):r.createElement(h,i({ref:n},c))}));function m(e,n){var t=arguments,o=n&&n.mdxType;if("string"==typeof e||o){var a=t.length,i=new Array(a);i[0]=p;var l={};for(var d in n)hasOwnProperty.call(n,d)&&(l[d]=n[d]);l.originalType=e,l.mdxType="string"==typeof e?e:o,i[1]=l;for(var s=2;s<a;s++)i[s]=t[s];return r.createElement.apply(null,i)}return r.createElement.apply(null,t)}p.displayName="MDXCreateElement"},4814:function(e,n,t){"use strict";t.r(n),t.d(n,{frontMatter:function(){return i},metadata:function(){return l},toc:function(){return d},default:function(){return c}});var r=t(2122),o=t(9756),a=(t(7294),t(3905)),i={sidebar_position:3},l={unversionedId:"state-managment/simple-notifier",id:"version-3.x.x/state-managment/simple-notifier",isDocsHomePage:!1,title:"SimpleNotifier",description:"Just create a class that extends of SimpleNotifier",source:"@site/versioned_docs/version-3.x.x/state-managment/simple-notifier.md",sourceDirName:"state-managment",slug:"/state-managment/simple-notifier",permalink:"/es/docs/3.x.x/state-managment/simple-notifier",editUrl:"https://github.com/darwin-morocho/flutter-meedu/edit/master/website/i18n/es/docusaurus-plugin-content-docs/current",version:"3.x.x",lastUpdatedBy:"Darwin Morocho",lastUpdatedAt:1624736668,formattedLastUpdatedAt:"26/6/2021",sidebarPosition:3,frontMatter:{sidebar_position:3},sidebar:"version-3.x.x/mySidebar",previous:{title:"How it works?",permalink:"/es/docs/3.x.x/state-managment/intro"},next:{title:"StateNotifier",permalink:"/es/docs/3.x.x/state-managment/state-notifier"}},d=[{value:"<strong>SimpleProvider</strong>",id:"simpleprovider",children:[{value:"Listen the changes in your Controller",id:"listen-the-changes-in-your-controller",children:[]},{value:"watch method with WatchFilter",id:"watch-method-with-watchfilter",children:[]}]},{value:"ConsumerWidget",id:"consumerwidget",children:[]}],s={toc:d};function c(e){var n=e.components,t=(0,o.Z)(e,["components"]);return(0,a.kt)("wrapper",(0,r.Z)({},s,t,{components:n,mdxType:"MDXLayout"}),(0,a.kt)("p",null,"Just create a class that extends of ",(0,a.kt)("inlineCode",{parentName:"p"},"SimpleNotifier")),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:flutter_meedu/meedu.dart';\n\nclass CounterController extends SimpleNotifier{\n    int _counter = 0;\n    int get counter => _counter;\n\n    void increment(){\n        _counter++;\n        notify(); // notify to all listeners\n    }\n \n    // override the next method is OPTIONAL\n    @override\n    void onDispose() {\n      // YOUR CODE HERE\n      super.onDispose();// <-- you must call to the super method\n    }\n}\n")),(0,a.kt)("h2",{id:"simpleprovider"},(0,a.kt)("strong",{parentName:"h2"},"SimpleProvider")),(0,a.kt)("p",null,"Now you need to create a ",(0,a.kt)("inlineCode",{parentName:"p"},"provider")," as a global variable using the ",(0,a.kt)("inlineCode",{parentName:"p"},"SimpleProvider")," class."),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart"},"final counterProvider = SimpleProvider(\n  (ref) => CounterController(),\n);\n")),(0,a.kt)("p",null,"Now you can use the ",(0,a.kt)("inlineCode",{parentName:"p"},"Consumer")," widget to read your ",(0,a.kt)("inlineCode",{parentName:"p"},"CounterController"),"."),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:flutter_meedu/state.dart';\nimport 'package:flutter_meedu/meedu.dart';\n\nfinal counterProvider = SimpleProvider(\n  (ref) => CounterController(),\n);\n\nclass CounterPage extends StatelessWidget {\n  const CounterPage({Key? key}) : super(key: key);\n\n  @override\n  Widget build(BuildContext context) {\n    return Scaffold(\n      body: Center(\n        // The Consumer widget listen the changes in your CounterController\n        // and rebuild the widget when is need it\n        child: Consumer(builder: (_, watch, __) {\n          final controller = watch(counterProvider);\n          return Text(\"${controller.counter}\");\n        }),\n      ),\n      floatingActionButton: FloatingActionButton(\n        onPressed: () {\n          // you can use the read method to access to your CounterController\n          counterProvider.read.increment();\n        },\n      ),\n    );\n  }\n}\n")),(0,a.kt)("p",null,"By default the ",(0,a.kt)("inlineCode",{parentName:"p"},"counterProvider")," variable doesn't create one instance of ",(0,a.kt)("inlineCode",{parentName:"p"},"CounterController")," until it is need it. In this case the ",(0,a.kt)("inlineCode",{parentName:"p"},"Consumer"),"\nwidget call to the ",(0,a.kt)("inlineCode",{parentName:"p"},"read")," method of our ",(0,a.kt)("inlineCode",{parentName:"p"},"counterProvider")," and check if the ",(0,a.kt)("inlineCode",{parentName:"p"},"CounterController")," was created and return the ",(0,a.kt)("inlineCode",{parentName:"p"},"CounterController")," that was created before or create a new ",(0,a.kt)("inlineCode",{parentName:"p"},"CounterController"),"."),(0,a.kt)("p",null,"The ",(0,a.kt)("inlineCode",{parentName:"p"},"onDispose")," method in our ",(0,a.kt)("inlineCode",{parentName:"p"},"CounterController")," will be called when the ",(0,a.kt)("inlineCode",{parentName:"p"},"route")," who created the ",(0,a.kt)("inlineCode",{parentName:"p"},"CounterController")," is popped."),(0,a.kt)("p",null,"If you don't want to call to the ",(0,a.kt)("inlineCode",{parentName:"p"},"onDispose")," method when the ",(0,a.kt)("inlineCode",{parentName:"p"},"route")," who created the ",(0,a.kt)("inlineCode",{parentName:"p"},"CounterController")," is popped you could use."),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{3}","{3}":!0},"final counterProvider = SimpleProvider(\n  (ref) => CounterController(),\n  autoDispose: false,// <-- ADD THIS TO DISABLE THE AUTO DISPOSE\n);\n")),(0,a.kt)("div",{className:"admonition admonition-danger alert alert--danger"},(0,a.kt)("div",{parentName:"div",className:"admonition-heading"},(0,a.kt)("h5",{parentName:"div"},(0,a.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,a.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"12",height:"16",viewBox:"0 0 12 16"},(0,a.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M5.05.31c.81 2.17.41 3.38-.52 4.31C3.55 5.67 1.98 6.45.9 7.98c-1.45 2.05-1.7 6.53 3.53 7.7-2.2-1.16-2.67-4.52-.3-6.61-.61 2.03.53 3.33 1.94 2.86 1.39-.47 2.3.53 2.27 1.67-.02.78-.31 1.44-1.13 1.81 3.42-.59 4.78-3.42 4.78-5.56 0-2.84-2.53-3.22-1.25-5.61-1.52.13-2.03 1.13-1.89 2.75.09 1.08-1.02 1.8-1.86 1.33-.67-.41-.66-1.19-.06-1.78C8.18 5.31 8.68 2.45 5.05.32L5.03.3l.02.01z"}))),"WARNING")),(0,a.kt)("div",{parentName:"div",className:"admonition-content"},(0,a.kt)("p",{parentName:"div"},"When you disable the ",(0,a.kt)("inlineCode",{parentName:"p"},"autoDispose")," of your ",(0,a.kt)("inlineCode",{parentName:"p"},"provider")," you need to handle it manually. For example "))),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{18}","{18}":!0},'final counterProvider = SimpleProvider(\n  (ref) => CounterController(),\n  autoDispose: false,\n);\n\nclass CounterPage extends StatefulWidget {\n  const CounterPage({Key? key}) : super(key: key);\n  @override\n  _CounterPageState createState() => _CounterPageState();\n}\n\nclass _CounterPageState extends State<CounterPage> {\n  @override\n  void dispose() {\n    // handle the dispose event manually\n    // check if the provider has a Controller created before\n    if (counterProvider.mounted) {\n      counterProvider.dispose();\n    }\n    super.dispose();\n  }\n\n  @override\n  Widget build(BuildContext context) {\n    return Scaffold(\n      body: Center(\n        child: Consumer(builder: (_, watch, __) {\n          final controller = watch(counterProvider);\n          return Text("${controller.counter}");\n        }),\n      ),\n      floatingActionButton: FloatingActionButton(\n        onPressed: () {\n          counterProvider.read.increment();\n        },\n      ),\n    );\n  }\n}\n')),(0,a.kt)("h3",{id:"listen-the-changes-in-your-controller"},"Listen the changes in your Controller"),(0,a.kt)("p",null,"You could use the ",(0,a.kt)("inlineCode",{parentName:"p"},"ProviderListener")," Widget to listen the changes in our ",(0,a.kt)("inlineCode",{parentName:"p"},"CounterController")),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{3-7}","{3-7}":!0},' ProviderListener<CounterController>(\n      provider: counterProvider,\n      onChange: (context, controller) {\n        // YOUR CODE HERE\n        // This method is called every time that one Instance\n        // of our CounterController calls to the notify() method\n      },\n      builder: (_, controller) => Scaffold(\n        body: Center(\n          // The Consumer widget listen the changes in your CounterController\n          // and rebuild the widget when is need it\n          child: Consumer(\n            builder: (_, watch, __) {\n              final controller = watch(counterProvider);\n              return Text("${controller.counter}");\n            },\n          ),\n        ),\n        floatingActionButton: FloatingActionButton(\n          onPressed: () {\n            // you can use the read method to access to your CounterController\n            counterProvider.read.increment();\n          },\n        ),\n      ),\n    )\n')),(0,a.kt)("p",null,"Or you can listen the changes in your SimpleProvider as a ",(0,a.kt)("inlineCode",{parentName:"p"},"StreamSubscription")),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{1,5-7,12}","{1,5-7,12}":!0},"  StreamSubscription? _subscription;\n  @override\n  void initState() {\n    super.initState();\n    _subscription = counterProvider.read.stream.listen((_) {\n      // YOUR CODE HERE\n    });\n  }\n\n  @override\n  void dispose() {\n    _subscription?.cancel();\n    super.dispose();\n  }\n")),(0,a.kt)("h3",{id:"watch-method-with-watchfilter"},"watch method with WatchFilter"),(0,a.kt)("p",null,"If you have multiples ",(0,a.kt)("inlineCode",{parentName:"p"},"Consumer")," widgets in your Views and you only want rebuild certain Consumer you can use the ",(0,a.kt)("inlineCode",{parentName:"p"},"WatchFilter")),(0,a.kt)("div",{className:"admonition admonition-note alert alert--secondary"},(0,a.kt)("div",{parentName:"div",className:"admonition-heading"},(0,a.kt)("h5",{parentName:"div"},(0,a.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,a.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,a.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.3 5.69a.942.942 0 0 1-.28-.7c0-.28.09-.52.28-.7.19-.18.42-.28.7-.28.28 0 .52.09.7.28.18.19.28.42.28.7 0 .28-.09.52-.28.7a1 1 0 0 1-.7.3c-.28 0-.52-.11-.7-.3zM8 7.99c-.02-.25-.11-.48-.31-.69-.2-.19-.42-.3-.69-.31H6c-.27.02-.48.13-.69.31-.2.2-.3.44-.31.69h1v3c.02.27.11.5.31.69.2.2.42.31.69.31h1c.27 0 .48-.11.69-.31.2-.19.3-.42.31-.69H8V7.98v.01zM7 2.3c-3.14 0-5.7 2.54-5.7 5.68 0 3.14 2.56 5.7 5.7 5.7s5.7-2.55 5.7-5.7c0-3.15-2.56-5.69-5.7-5.69v.01zM7 .98c3.86 0 7 3.14 7 7s-3.14 7-7 7-7-3.12-7-7 3.14-7 7-7z"}))),"note")),(0,a.kt)("div",{parentName:"div",className:"admonition-content"},(0,a.kt)("p",{parentName:"div"},"When you use the ",(0,a.kt)("inlineCode",{parentName:"p"},"WatchFilter")," class you need to define the ",(0,a.kt)("strong",{parentName:"p"},"generic types")," in the ",(0,a.kt)("inlineCode",{parentName:"p"},"watch")," method.\nThe second generic type in the next code in our ",(0,a.kt)("inlineCode",{parentName:"p"},"WatchFilter")," is a ",(0,a.kt)("inlineCode",{parentName:"p"},"List")," beacuse we are using a list of strings (ids) to listen the changes."))),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{8,21,23}","{8,21,23}":!0},"class CounterController extends SimpleNotifier {\n  int _counter = 0;\n  int get counter => _counter;\n\n  void increment() {\n    _counter++;\n    // notify to all listeners but only rebuild the widgets with the id 'text'\n    notify(['text']);\n  }\n}\n\n.\n.\n.\n\nScaffold(\n  body: Column(\n    children: [\n      Consumer(\n        builder: (_, watch, __) {\n          final controller = watch<CounterController, List>(\n            counterProvider,\n            WatchFilter(ids: ['text']),\n          );\n          return Text(\"${controller.counter}\");\n        },\n      ),\n      Consumer(\n        builder: (_, watch, __) {\n          final controller = watch(counterProvider);\n          return Text(\"${controller.counter}\");\n        },\n      )\n    ],\n  ),\n  floatingActionButton: FloatingActionButton(\n    onPressed: () {\n      // you can use the read method to access to your CounterController\n      counterProvider.read.increment();\n    },\n  ),\n)\n")),(0,a.kt)("p",null,"If you don't want to use ",(0,a.kt)("inlineCode",{parentName:"p"},"ids")," to rebuild your ",(0,a.kt)("inlineCode",{parentName:"p"},"Consumer")," you can use the ",(0,a.kt)("inlineCode",{parentName:"p"},"select")," param in the ",(0,a.kt)("inlineCode",{parentName:"p"},"WatchFilter")," instance.\nThe next code rebuilds the first ",(0,a.kt)("inlineCode",{parentName:"p"},"Consumer")," only when the counter is highest than 5."),(0,a.kt)("div",{className:"admonition admonition-note alert alert--secondary"},(0,a.kt)("div",{parentName:"div",className:"admonition-heading"},(0,a.kt)("h5",{parentName:"div"},(0,a.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,a.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,a.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.3 5.69a.942.942 0 0 1-.28-.7c0-.28.09-.52.28-.7.19-.18.42-.28.7-.28.28 0 .52.09.7.28.18.19.28.42.28.7 0 .28-.09.52-.28.7a1 1 0 0 1-.7.3c-.28 0-.52-.11-.7-.3zM8 7.99c-.02-.25-.11-.48-.31-.69-.2-.19-.42-.3-.69-.31H6c-.27.02-.48.13-.69.31-.2.2-.3.44-.31.69h1v3c.02.27.11.5.31.69.2.2.42.31.69.31h1c.27 0 .48-.11.69-.31.2-.19.3-.42.31-.69H8V7.98v.01zM7 2.3c-3.14 0-5.7 2.54-5.7 5.68 0 3.14 2.56 5.7 5.7 5.7s5.7-2.55 5.7-5.7c0-3.15-2.56-5.69-5.7-5.69v.01zM7 .98c3.86 0 7 3.14 7 7s-3.14 7-7 7-7-3.12-7-7 3.14-7 7-7z"}))),"note")),(0,a.kt)("div",{parentName:"div",className:"admonition-content"},(0,a.kt)("p",{parentName:"div"},"The second ",(0,a.kt)("strong",{parentName:"p"},"generic type")," in the next code in our ",(0,a.kt)("inlineCode",{parentName:"p"},"WatchFilter")," is a ",(0,a.kt)("inlineCode",{parentName:"p"},"bool")," beacuse we are using a ",(0,a.kt)("strong",{parentName:"p"},"boolean condition")," to listen the changes."))),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{19,21}","{19,21}":!0},'class CounterController extends SimpleNotifier {\n  int _counter = 0;\n  int get counter => _counter;\n\n  void increment() {\n    _counter++;\n    notify();\n  }\n}\n\n.\n.\n.\n\nScaffold(\n  body: Center(\n    child: Consumer(\n        builder: (_, watch, __) {\n          final controller = watch<CounterController, bool>(\n            counterProvider,\n            WatchFilter(select: (controller) => controller.counter > 5),\n          );\n          return Text("${controller.counter}");\n        },\n    )\n  ),\n  floatingActionButton: FloatingActionButton(\n    onPressed: () {\n      // you can use the read method to access to your CounterController\n      counterProvider.read.increment();\n    },\n  ),\n)\n')),(0,a.kt)("h2",{id:"consumerwidget"},"ConsumerWidget"),(0,a.kt)("p",null,"Also you can extend from ",(0,a.kt)("inlineCode",{parentName:"p"},"ConsumerWidget")," to create a widget and listen the changes in your notifier"),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{7}","{7}":!0},'class CounterPage extends StatelessWidget {\n  @override\n  Widget build(BuildContext context) {\n    return Scaffold(\n      appBar: AppBar(),\n      body: Center(\n        child: CounterView(),\n      ),\n      floatingActionButton: FloatingActionButton(\n        onPressed: () {\n          counterProvider.read.increment();\n        },\n      ),\n    );\n  }\n}\n\nclass CounterView extends ConsumerWidget {\n  @override\n  Widget build(BuildContext context, ScopedReader watch) {\n    final controller = watch(counterProvider);\n    return Text("${controller.counter}");\n  }\n}\n')),(0,a.kt)("div",{className:"admonition admonition-success alert alert--success"},(0,a.kt)("div",{parentName:"div",className:"admonition-heading"},(0,a.kt)("h5",{parentName:"div"},(0,a.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,a.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"12",height:"16",viewBox:"0 0 12 16"},(0,a.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.5 0C3.48 0 1 2.19 1 5c0 .92.55 2.25 1 3 1.34 2.25 1.78 2.78 2 4v1h5v-1c.22-1.22.66-1.75 2-4 .45-.75 1-2.08 1-3 0-2.81-2.48-5-5.5-5zm3.64 7.48c-.25.44-.47.8-.67 1.11-.86 1.41-1.25 2.06-1.45 3.23-.02.05-.02.11-.02.17H5c0-.06 0-.13-.02-.17-.2-1.17-.59-1.83-1.45-3.23-.2-.31-.42-.67-.67-1.11C2.44 6.78 2 5.65 2 5c0-2.2 2.02-4 4.5-4 1.22 0 2.36.42 3.22 1.19C10.55 2.94 11 3.94 11 5c0 .66-.44 1.78-.86 2.48zM4 14h5c-.23 1.14-1.3 2-2.5 2s-2.27-.86-2.5-2z"}))),"NOTE")),(0,a.kt)("div",{parentName:"div",className:"admonition-content"},(0,a.kt)("p",{parentName:"div"},"The ",(0,a.kt)("inlineCode",{parentName:"p"},"watch")," method in a ",(0,a.kt)("inlineCode",{parentName:"p"},"Consumer")," or a ",(0,a.kt)("inlineCode",{parentName:"p"},"ConsumerWidget")," can be used to listen multiples providers."),(0,a.kt)("pre",{parentName:"div"},(0,a.kt)("code",{parentName:"pre",className:"language-dart"},'class CounterView extends ConsumerWidget {\n  @override\n  Widget build(BuildContext context, ScopedReader watch) {\n    final counterController = watch(counterProvider);\n    final loginController = watch(loginProvider);\n    return Text("${counterController.counter}");\n  }\n}\n')))))}c.isMDXComponent=!0}}]);