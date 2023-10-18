(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[8374],{3905:function(e,t,n){"use strict";n.d(t,{Zo:function(){return p},kt:function(){return m}});var a=n(7294);function r(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function i(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);t&&(a=a.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,a)}return n}function o(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?i(Object(n),!0).forEach((function(t){r(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):i(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function s(e,t){if(null==e)return{};var n,a,r=function(e,t){if(null==e)return{};var n,a,r={},i=Object.keys(e);for(a=0;a<i.length;a++)n=i[a],t.indexOf(n)>=0||(r[n]=e[n]);return r}(e,t);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(a=0;a<i.length;a++)n=i[a],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(r[n]=e[n])}return r}var d=a.createContext({}),l=function(e){var t=a.useContext(d),n=t;return e&&(n="function"==typeof e?e(t):o(o({},t),e)),n},p=function(e){var t=l(e.components);return a.createElement(d.Provider,{value:t},e.children)},u={inlineCode:"code",wrapper:function(e){var t=e.children;return a.createElement(a.Fragment,{},t)}},c=a.forwardRef((function(e,t){var n=e.components,r=e.mdxType,i=e.originalType,d=e.parentName,p=s(e,["components","mdxType","originalType","parentName"]),c=l(n),m=r,f=c["".concat(d,".").concat(m)]||c[m]||u[m]||i;return n?a.createElement(f,o(o({ref:t},p),{},{components:n})):a.createElement(f,o({ref:t},p))}));function m(e,t){var n=arguments,r=t&&t.mdxType;if("string"==typeof e||r){var i=n.length,o=new Array(i);o[0]=c;var s={};for(var d in t)hasOwnProperty.call(t,d)&&(s[d]=t[d]);s.originalType=e,s.mdxType="string"==typeof e?e:r,o[1]=s;for(var l=2;l<i;l++)o[l]=n[l];return a.createElement.apply(null,o)}return a.createElement.apply(null,n)}c.displayName="MDXCreateElement"},9672:function(e,t,n){"use strict";n.r(t),n.d(t,{frontMatter:function(){return o},metadata:function(){return s},toc:function(){return d},default:function(){return p}});var a=n(2122),r=n(9756),i=(n(7294),n(3905)),o={sidebar_position:1},s={unversionedId:"state-management/state-notifier",id:"state-management/state-notifier",isDocsHomePage:!1,title:"StateNotifier",description:"Consider the following straightforward example of a typical counter app.",source:"@site/docs/state-management/state-notifier.md",sourceDirName:"state-management",slug:"/state-management/state-notifier",permalink:"/docs/state-management/state-notifier",editUrl:"https://github.com/darwin-morocho/flutter-meedu/edit/master/website/docs/state-management/state-notifier.md",version:"current",lastUpdatedBy:"darwin-morocho",lastUpdatedAt:1697048754,formattedLastUpdatedAt:"10/11/2023",sidebarPosition:1,frontMatter:{sidebar_position:1},sidebar:"mySidebar",previous:{title:"What is meedu?",permalink:"/docs/intro"},next:{title:"Inmutable States",permalink:"/docs/state-management/inmutable-states"}},d=[{value:"What about testing?",id:"what-about-testing",children:[]}],l={toc:d};function p(e){var t=e.components,n=(0,r.Z)(e,["components"]);return(0,i.kt)("wrapper",(0,a.Z)({},l,n,{components:t,mdxType:"MDXLayout"}),(0,i.kt)("p",null,"Consider the following straightforward example of a typical counter app."),(0,i.kt)("p",null,"First, create a class that extends of ",(0,i.kt)("strong",{parentName:"p"},(0,i.kt)("inlineCode",{parentName:"strong"},"StateNotifier"))," and define the data type to be used for your state. In this example, we will use an ",(0,i.kt)("strong",{parentName:"p"},(0,i.kt)("inlineCode",{parentName:"strong"},"int"))," to represent the state of our counter app."),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:flutter_meedu/notifiers.dart';// import the StateNotifer class\n\nclass CounterNotifier extends StateNotifer<int>{\n  CounterNotifier(super.initialState); // the super class StateNotifer needs a initial state value\n\n  void increment(){\n    state++;\n  }\n}\n")),(0,i.kt)("p",null,"Now you need to create a provider for our ",(0,i.kt)("strong",{parentName:"p"},(0,i.kt)("inlineCode",{parentName:"strong"},"CounterNotifier"))),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:flutter_meedu/providers.dart';// import the StateNotifierProvider class\n\nfinal counterProvider = Provider.state<CounterNotifier, int>(\n  (_) => CounterNotifier(0), // pass the initial state value when we create a CounterNotifier\n);\n")),(0,i.kt)("p",null,"As you may have noticed, we declare our ",(0,i.kt)("strong",{parentName:"p"},(0,i.kt)("inlineCode",{parentName:"strong"},"counterProvider"))," as a global variable. Don't worry; Meedu is fully compatible with testing."),(0,i.kt)("p",null,"With this setup, we can now easily listen to and update our counter within our views using the ",(0,i.kt)("strong",{parentName:"p"},(0,i.kt)("inlineCode",{parentName:"strong"},"Consumer"))," widget."),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{2,11,13,19}","{2,11,13,19}":!0},"import 'package:flutter/material.dart';\nimport 'package:flutter_meedu/consumer.dart'; // import the consumer widget\n\nclass CounterView extends StatelessWidget {\n  const CounterView({Key? key}) : super(key: key);\n\n  @override\n  Widget build(BuildContext context) {\n    return Scaffold(\n      body: Center(\n        child: Consumer(\n          builder: (context, ref, child){\n            final notifier =  ref.watch(counterProvider); // listen the state changes in our CounterNotifier\n            return Text(\"${notifier.state}\");\n          },\n        ),\n      ),\n      floatingActionButton: FloatingActionButton(\n        onPressed: () => counterProvider.read().increment(), // update the CounterNotifier state and rebuild the Consumer widget.\n      ),\n    );\n  }\n}\n")),(0,i.kt)("p",null,"By default, our ",(0,i.kt)("inlineCode",{parentName:"p"},"counterProvider")," does not create an instance of ",(0,i.kt)("inlineCode",{parentName:"p"},"CounterNotifier")," until it is needed. In this scenario, the ",(0,i.kt)("inlineCode",{parentName:"p"},"Consumer")," widget calls the ",(0,i.kt)("inlineCode",{parentName:"p"},"read")," function of our ",(0,i.kt)("inlineCode",{parentName:"p"},"counterProvider")," to check if an instance of ",(0,i.kt)("inlineCode",{parentName:"p"},"CounterNotifier")," has been previously created and associated with our ",(0,i.kt)("inlineCode",{parentName:"p"},"counterProvider"),". If not, it creates a new instance of ",(0,i.kt)("inlineCode",{parentName:"p"},"CounterNotifier")," and associates it with our ",(0,i.kt)("inlineCode",{parentName:"p"},"counterProvider"),"."),(0,i.kt)("div",{className:"admonition admonition-note alert alert--secondary"},(0,i.kt)("div",{parentName:"div",className:"admonition-heading"},(0,i.kt)("h5",{parentName:"div"},(0,i.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,i.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,i.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.3 5.69a.942.942 0 0 1-.28-.7c0-.28.09-.52.28-.7.19-.18.42-.28.7-.28.28 0 .52.09.7.28.18.19.28.42.28.7 0 .28-.09.52-.28.7a1 1 0 0 1-.7.3c-.28 0-.52-.11-.7-.3zM8 7.99c-.02-.25-.11-.48-.31-.69-.2-.19-.42-.3-.69-.31H6c-.27.02-.48.13-.69.31-.2.2-.3.44-.31.69h1v3c.02.27.11.5.31.69.2.2.42.31.69.31h1c.27 0 .48-.11.69-.31.2-.19.3-.42.31-.69H8V7.98v.01zM7 2.3c-3.14 0-5.7 2.54-5.7 5.68 0 3.14 2.56 5.7 5.7 5.7s5.7-2.55 5.7-5.7c0-3.15-2.56-5.69-5.7-5.69v.01zM7 .98c3.86 0 7 3.14 7 7s-3.14 7-7 7-7-3.12-7-7 3.14-7 7-7z"}))),"important")),(0,i.kt)("div",{parentName:"div",className:"admonition-content"},(0,i.kt)("p",{parentName:"div"},"Inside the ",(0,i.kt)("inlineCode",{parentName:"p"},"Consumer")," widget, we use ",(0,i.kt)("inlineCode",{parentName:"p"},"ref.watch(...)")," to create or retrieve our instance of ",(0,i.kt)("inlineCode",{parentName:"p"},"CounterNotifier"),". This action also establishes a subscriber for state changes. As a result, our ",(0,i.kt)("inlineCode",{parentName:"p"},"Consumer")," will be rebuilt every time the state of our ",(0,i.kt)("inlineCode",{parentName:"p"},"CounterNotifier")," instance changes."),(0,i.kt)("p",{parentName:"div"},"When the ",(0,i.kt)("inlineCode",{parentName:"p"},"Consumer")," widget is destroyed, all subscribers created by it are removed from our ",(0,i.kt)("inlineCode",{parentName:"p"},"CounterNotifier")," instance."),(0,i.kt)("p",{parentName:"div"},"Note: By default, when a ",(0,i.kt)("inlineCode",{parentName:"p"},"StateNotifier")," loses all its subscribers, the ",(0,i.kt)("inlineCode",{parentName:"p"},"dispose")," function of ",(0,i.kt)("inlineCode",{parentName:"p"},"StateNotifierProvider")," will be called, and our ",(0,i.kt)("inlineCode",{parentName:"p"},"CounterNotifier")," instance will also be disposed."),(0,i.kt)("p",{parentName:"div"},"You can disable the autoDispose feature using ",(0,i.kt)("inlineCode",{parentName:"p"},"autoDispose: false")," when we create our provider."),(0,i.kt)("pre",{parentName:"div"},(0,i.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{3}","{3}":!0},"final counterProvider = Provider.state<CounterNotifier, int>(\n  (_) => CounterNotifier(0),\n  autoDispose: false, // disable the autoDispose feature\n);\n")),(0,i.kt)("p",{parentName:"div"},"Keep in mind that when you disable the autoDispose feature, you must release all resources and the StateNotifier linked to our providers by calling the dispose function.\nFor example you can use a StatefulWidget"),(0,i.kt)("pre",{parentName:"div"},(0,i.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{12}","{12}":!0},"class MyWidget extends StatefulWidget {\n  const MyWidget({super.key});\n\n  @override\n  State<MyWidget> createState() => _MyWidgetState();\n}\n\nclass _MyWidgetState extends State<MyWidget> {\n\n  @override\n  void dispose() {\n    counterProvider.dispose(); // all resources and the StateNotifier linked to our provider\n    super.dispose();\n  }\n\n\n  @override\n  Widget build(BuildContext context) {\n    return YOUR_CODE;\n  }\n}\n")))),(0,i.kt)("div",{className:"admonition admonition-note alert alert--secondary"},(0,i.kt)("div",{parentName:"div",className:"admonition-heading"},(0,i.kt)("h5",{parentName:"div"},(0,i.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,i.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,i.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.3 5.69a.942.942 0 0 1-.28-.7c0-.28.09-.52.28-.7.19-.18.42-.28.7-.28.28 0 .52.09.7.28.18.19.28.42.28.7 0 .28-.09.52-.28.7a1 1 0 0 1-.7.3c-.28 0-.52-.11-.7-.3zM8 7.99c-.02-.25-.11-.48-.31-.69-.2-.19-.42-.3-.69-.31H6c-.27.02-.48.13-.69.31-.2.2-.3.44-.31.69h1v3c.02.27.11.5.31.69.2.2.42.31.69.31h1c.27 0 .48-.11.69-.31.2-.19.3-.42.31-.69H8V7.98v.01zM7 2.3c-3.14 0-5.7 2.54-5.7 5.68 0 3.14 2.56 5.7 5.7 5.7s5.7-2.55 5.7-5.7c0-3.15-2.56-5.69-5.7-5.69v.01zM7 .98c3.86 0 7 3.14 7 7s-3.14 7-7 7-7-3.12-7-7 3.14-7 7-7z"}))),"note")),(0,i.kt)("div",{parentName:"div",className:"admonition-content"},(0,i.kt)("p",{parentName:"div"},"The ",(0,i.kt)("inlineCode",{parentName:"p"},"Consumer")," widget has an optional parameter called ",(0,i.kt)("inlineCode",{parentName:"p"},"child"),". This can be used to cache a widget and prevent unnecessary rebuilds of this widget inside the Consumer."),(0,i.kt)("pre",{parentName:"div"},(0,i.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{7,11}","{7,11}":!0},'Consumer(\n  builder: (_, ref, myCachedWidget){\n    final notifier =  ref.watch(counterProvider); // listen the state changes in our CounterNotifier\n    return Column(\n      children:[\n         Text("${notifier.state}"),\n         myCachedWidget!, // the widget passed in the child parameter\n      ],\n    );\n  },\n  child: SomeWidget(),\n)\n')))),(0,i.kt)("h2",{id:"what-about-testing"},"What about testing?"),(0,i.kt)("p",null,"This is very simple. Before or after each test you will need the default state of all StateNotifier. So you can use ",(0,i.kt)("inlineCode",{parentName:"p"},"ProvidersContainer.clear()")," to clear and reset all providers."),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{6}","{6}":!0},"import 'package:flutter_meedu/providers.dart';\nimport 'package:flutter/material.dart';\nimport 'package:flutter_test/flutter_test.dart';\n\nvoid main() {\n  setUp(ProvidersContainer.clear);\n\n  testWidgets(\n    'StateController test',\n    (test) async {\n      await test.pumpWidget(\n        const MaterialApp(\n          home: CounterView(),\n        ),\n      );\n      expect(find.text(\"0\"), findsOneWidget);\n      await test.tap(find.byType(FloatingActionButton));\n      await test.pump();\n      expect(find.text(\"1\"), findsOneWidget);\n    },\n  );\n}\n\n")))}p.isMDXComponent=!0}}]);