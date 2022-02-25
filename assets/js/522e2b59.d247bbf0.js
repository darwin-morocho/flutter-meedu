(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[1502],{3905:function(e,t,n){"use strict";n.d(t,{Zo:function(){return p},kt:function(){return m}});var a=n(7294);function r(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function o(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);t&&(a=a.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,a)}return n}function i(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?o(Object(n),!0).forEach((function(t){r(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):o(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function u(e,t){if(null==e)return{};var n,a,r=function(e,t){if(null==e)return{};var n,a,r={},o=Object.keys(e);for(a=0;a<o.length;a++)n=o[a],t.indexOf(n)>=0||(r[n]=e[n]);return r}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(a=0;a<o.length;a++)n=o[a],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(r[n]=e[n])}return r}var s=a.createContext({}),d=function(e){var t=a.useContext(s),n=t;return e&&(n="function"==typeof e?e(t):i(i({},t),e)),n},p=function(e){var t=d(e.components);return a.createElement(s.Provider,{value:t},e.children)},l={inlineCode:"code",wrapper:function(e){var t=e.children;return a.createElement(a.Fragment,{},t)}},c=a.forwardRef((function(e,t){var n=e.components,r=e.mdxType,o=e.originalType,s=e.parentName,p=u(e,["components","mdxType","originalType","parentName"]),c=d(n),m=r,g=c["".concat(s,".").concat(m)]||c[m]||l[m]||o;return n?a.createElement(g,i(i({ref:t},p),{},{components:n})):a.createElement(g,i({ref:t},p))}));function m(e,t){var n=arguments,r=t&&t.mdxType;if("string"==typeof e||r){var o=n.length,i=new Array(o);i[0]=c;var u={};for(var s in t)hasOwnProperty.call(t,s)&&(u[s]=t[s]);u.originalType=e,u.mdxType="string"==typeof e?e:r,i[1]=u;for(var d=2;d<o;d++)i[d]=n[d];return a.createElement.apply(null,i)}return a.createElement.apply(null,n)}c.displayName="MDXCreateElement"},1895:function(e,t,n){"use strict";n.r(t),n.d(t,{frontMatter:function(){return i},metadata:function(){return u},toc:function(){return s},default:function(){return p}});var a=n(2122),r=n(9756),o=(n(7294),n(3905)),i={},u={unversionedId:"navigation",id:"navigation",isDocsHomePage:!1,title:"Navigation",description:"flutter_meedu uses navigator 1.0 in its router module and there is not planned add navigator 2.0 as a new router module because there is not an easy way to create a router package with navigator 2.0 that fits all posible navigation flows that a developer might want to create.",source:"@site/docs/navigation.md",sourceDirName:".",slug:"/navigation",permalink:"/docs/navigation",editUrl:"https://github.com/darwin-morocho/flutter-meedu/edit/master/website/docs/navigation.md",version:"current",lastUpdatedBy:"Darwin",lastUpdatedAt:1632596009,formattedLastUpdatedAt:"9/25/2021",frontMatter:{},sidebar:"mySidebar",previous:{title:"Reactive programming",permalink:"/docs/reactive-programming"},next:{title:"Screen Utils",permalink:"/docs/screen-utils"}},s=[{value:"onGenerateRoute",id:"ongenerateroute",children:[]},{value:"Named routes with custom transitions",id:"named-routes-with-custom-transitions",children:[]},{value:"Testing",id:"testing",children:[]}],d={toc:s};function p(e){var t=e.components,n=(0,r.Z)(e,["components"]);return(0,o.kt)("wrapper",(0,a.Z)({},d,n,{components:t,mdxType:"MDXLayout"}),(0,o.kt)("div",{className:"admonition admonition-note alert alert--secondary"},(0,o.kt)("div",{parentName:"div",className:"admonition-heading"},(0,o.kt)("h5",{parentName:"div"},(0,o.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,o.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,o.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.3 5.69a.942.942 0 0 1-.28-.7c0-.28.09-.52.28-.7.19-.18.42-.28.7-.28.28 0 .52.09.7.28.18.19.28.42.28.7 0 .28-.09.52-.28.7a1 1 0 0 1-.7.3c-.28 0-.52-.11-.7-.3zM8 7.99c-.02-.25-.11-.48-.31-.69-.2-.19-.42-.3-.69-.31H6c-.27.02-.48.13-.69.31-.2.2-.3.44-.31.69h1v3c.02.27.11.5.31.69.2.2.42.31.69.31h1c.27 0 .48-.11.69-.31.2-.19.3-.42.31-.69H8V7.98v.01zM7 2.3c-3.14 0-5.7 2.54-5.7 5.68 0 3.14 2.56 5.7 5.7 5.7s5.7-2.55 5.7-5.7c0-3.15-2.56-5.69-5.7-5.69v.01zM7 .98c3.86 0 7 3.14 7 7s-3.14 7-7 7-7-3.12-7-7 3.14-7 7-7z"}))),"note")),(0,o.kt)("div",{parentName:"div",className:"admonition-content"},(0,o.kt)("p",{parentName:"div"},(0,o.kt)("strong",{parentName:"p"},"flutter_meedu")," uses ",(0,o.kt)("strong",{parentName:"p"},"navigator 1.0")," in its router module and there is not planned add ",(0,o.kt)("strong",{parentName:"p"},"navigator 2.0")," as a new router module because there is not an easy way to create a router package with navigator 2.0 that fits all posible navigation flows that a developer might want to create."),(0,o.kt)("p",{parentName:"div"},"In that case you can use any other package on ",(0,o.kt)("a",{parentName:"p",href:"https://pub.dev"},"pub.dev")," to manage your navigation with navigation 2.0 and use flutter_meedu to manage your state without any problem just be sure to add the flutter_meedu observer in your ",(0,o.kt)("inlineCode",{parentName:"p"},"navigatorObservers"),"."))),(0,o.kt)("p",null,"To navigate between page without a BuildContext you can use the meedu's router module."),(0,o.kt)("p",null,"In your MaterialApp"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:flutter_meedu/router.dart' as router;\n\nclass MyApp extends StatelessWidget {\n  @override\n  Widget build(BuildContext context) {\n    return MaterialApp(\n      navigatorKey: router.navigatorKey, // add the navigator key\n      navigatorObservers: [\n        router.observer,// <-- ADD THIS\n      ],\n      home: HomePage(),\n      routes: {YOUR_ROUTES},\n    );\n  }\n}\n")),(0,o.kt)("p",null,"Now you can navigate without BuildContext"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:flutter_meedu/router.dart' as router;\n.\n.\n.\nrouter.pushNamed('detail-page', arguments: \"your-arguments\");\n")),(0,o.kt)("p",null,"If you want get your arguments"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:flutter/material.dart';\nimport 'package:flutter_meedu/router.dart' as router;\n\nclass DetailPage extends StatelessWidget {\n  const DetailPage({Key? key}) : super(key: key);\n\n  @override\n  Widget build(BuildContext context) {\n    final arguments = router.arguments as String;\n    return YOUR_WIDGET;\n  }\n}\n")),(0,o.kt)("h2",{id:"ongenerateroute"},"onGenerateRoute"),(0,o.kt)("p",null,"If you want to use the ",(0,o.kt)("inlineCode",{parentName:"p"},"onGenerateRoute")," parameter of your MaterialApp or CupertinoApp you must define the ",(0,o.kt)("inlineCode",{parentName:"p"},"key")," parameter."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{7}","{7}":!0},"import 'package:flutter_meedu/router.dart' as router;\n\nclass MyApp extends StatelessWidget {\n  @override\n  Widget build(BuildContext context) {\n    return MaterialApp(\n      key: router.appKey,// add the route key\n      navigatorKey: router.navigatorKey, // add the navigator key\n      navigatorObservers: [\n        router.observer,// <-- ADD THIS\n      ],\n      onGenerateRoute: (settings) {\n        final name = settings.name;\n        switch (name) {\n          case '/':\n            return MaterialPageRoute(\n              builder: (_) => HomePage(),\n            );\n\n          case '/counter':\n            return MaterialPageRoute(\n              builder: (_) => CounterPage(),\n            );\n          default:\n            return MaterialPageRoute(\n              builder: (_) => Scaffold(\n                appBar: AppBar(),\n                body: Center(\n                  child: Text(\"Page not found\"),\n                ),\n              ),\n            );\n        }\n      },\n    );\n  }\n}\n")),(0,o.kt)("h2",{id:"named-routes-with-custom-transitions"},"Named routes with custom transitions"),(0,o.kt)("p",null,"If you want to override the default transition when use named routes\nyou need to define the ",(0,o.kt)("inlineCode",{parentName:"p"},"key")," parameter of your MaterialApp or CupertinoApp"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{5,13}","{5,13}":!0},"import 'package:flutter_meedu/router.dart' as router;\n\nvoid main() {\n  // overrride the default page transition for named and non named routes\n  router.setDefaultTransition(router.Transition.downToUp);\n  runApp(MyApp());\n}\n\nclass MyApp extends StatelessWidget {\n  @override\n  Widget build(BuildContext context) {\n    return MaterialApp(\n      key: router.appKey,// add the route key\n      navigatorKey: router.navigatorKey, // add the navigator key\n      navigatorObservers: [\n        router.observer,// <-- ADD THIS\n      ],\n      home: HomePage(),\n      routes: {YOUR_ROUTES},\n    );\n  }\n}\n")),(0,o.kt)("div",{className:"admonition admonition-info alert alert--info"},(0,o.kt)("div",{parentName:"div",className:"admonition-heading"},(0,o.kt)("h5",{parentName:"div"},(0,o.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,o.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,o.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M7 2.3c3.14 0 5.7 2.56 5.7 5.7s-2.56 5.7-5.7 5.7A5.71 5.71 0 0 1 1.3 8c0-3.14 2.56-5.7 5.7-5.7zM7 1C3.14 1 0 4.14 0 8s3.14 7 7 7 7-3.14 7-7-3.14-7-7-7zm1 3H6v5h2V4zm0 6H6v2h2v-2z"}))),"info")),(0,o.kt)("div",{parentName:"div",className:"admonition-content"},(0,o.kt)("p",{parentName:"div"},"Posible transitions"),(0,o.kt)("pre",{parentName:"div"},(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"enum Transition {\n  fadeIn,\n  rightToLeft,\n  upToDown,\n  downToUp,\n  zoom,\n  none,\n  cupertino,\n  material,\n}\n")))),(0,o.kt)("h2",{id:"testing"},"Testing"),(0,o.kt)("p",null,"For widget testing you will need to dispose the NavigatorState created by ",(0,o.kt)("inlineCode",{parentName:"p"},"router.navigatorKey")," before or after each test"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:flutter_meedu/router.dart' as router;\n\n.\n.\n.\n\nsetUp((){\n  router.dispose();\n});\n\n// or\n\ntearDown((){\n  router.dispose();\n});\n")))}p.isMDXComponent=!0}}]);