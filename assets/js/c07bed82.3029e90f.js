(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[1367],{3905:function(e,t,n){"use strict";n.d(t,{Zo:function(){return d},kt:function(){return c}});var r=n(7294);function a(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function o(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,r)}return n}function i(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?o(Object(n),!0).forEach((function(t){a(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):o(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function s(e,t){if(null==e)return{};var n,r,a=function(e,t){if(null==e)return{};var n,r,a={},o=Object.keys(e);for(r=0;r<o.length;r++)n=o[r],t.indexOf(n)>=0||(a[n]=e[n]);return a}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(r=0;r<o.length;r++)n=o[r],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(a[n]=e[n])}return a}var u=r.createContext({}),l=function(e){var t=r.useContext(u),n=t;return e&&(n="function"==typeof e?e(t):i(i({},t),e)),n},d=function(e){var t=l(e.components);return r.createElement(u.Provider,{value:t},e.children)},m={inlineCode:"code",wrapper:function(e){var t=e.children;return r.createElement(r.Fragment,{},t)}},p=r.forwardRef((function(e,t){var n=e.components,a=e.mdxType,o=e.originalType,u=e.parentName,d=s(e,["components","mdxType","originalType","parentName"]),p=l(n),c=a,g=p["".concat(u,".").concat(c)]||p[c]||m[c]||o;return n?r.createElement(g,i(i({ref:t},d),{},{components:n})):r.createElement(g,i({ref:t},d))}));function c(e,t){var n=arguments,a=t&&t.mdxType;if("string"==typeof e||a){var o=n.length,i=new Array(o);i[0]=p;var s={};for(var u in t)hasOwnProperty.call(t,u)&&(s[u]=t[u]);s.originalType=e,s.mdxType="string"==typeof e?e:a,i[1]=s;for(var l=2;l<o;l++)i[l]=n[l];return r.createElement.apply(null,i)}return r.createElement.apply(null,n)}p.displayName="MDXCreateElement"},8341:function(e,t,n){"use strict";n.r(t),n.d(t,{frontMatter:function(){return i},metadata:function(){return s},toc:function(){return u},default:function(){return d}});var r=n(2122),a=n(9756),o=(n(7294),n(3905)),i={sidebar_position:5},s={unversionedId:"state-management/working-with-arguments",id:"state-management/working-with-arguments",isDocsHomePage:!1,title:"Working with arguments",description:"Some times you need to pass an initial values to your SimpleNotifier or StateNotifier in that cases you can sue the setArguments method of your provider.",source:"@site/docs/state-management/working-with-arguments.md",sourceDirName:"state-management",slug:"/state-management/working-with-arguments",permalink:"/docs/5.x.x/state-management/working-with-arguments",editUrl:"https://github.com/darwin-morocho/flutter-meedu/edit/master/website/docs/state-management/working-with-arguments.md",version:"current",sidebarPosition:5,frontMatter:{sidebar_position:5},sidebar:"mySidebar",previous:{title:"StateNotifier",permalink:"/docs/5.x.x/state-management/state-notifier"},next:{title:"Working with tags",permalink:"/docs/5.x.x/state-management/working-with-tags"}},u=[],l={toc:u};function d(e){var t=e.components,n=(0,a.Z)(e,["components"]);return(0,o.kt)("wrapper",(0,r.Z)({},l,n,{components:t,mdxType:"MDXLayout"}),(0,o.kt)("p",null,"Some times you need to pass an initial values to your ",(0,o.kt)("inlineCode",{parentName:"p"},"SimpleNotifier")," or ",(0,o.kt)("inlineCode",{parentName:"p"},"StateNotifier")," in that cases you can sue the ",(0,o.kt)("inlineCode",{parentName:"p"},"setArguments")," method of your provider."),(0,o.kt)("p",null,"In the next example to create a new instance of ",(0,o.kt)("strong",{parentName:"p"},"LoginController")," we need a initial email value"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"class LoginController extends StateNotifier<LoginState> {\n  LoginController(String initialEmail)\n      : super(\n          LoginState(email: initialEmail, password: ''),\n        );\n}\n")),(0,o.kt)("p",null,"Next you can use the ",(0,o.kt)("inlineCode",{parentName:"p"},"ref")," parameter of your callback generator to get the ",(0,o.kt)("inlineCode",{parentName:"p"},"arguments")," passed in the ",(0,o.kt)("inlineCode",{parentName:"p"},"initState")," method."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{2,19}","{2,19}":!0},"final loginProvider = StateProvider<LoginController, LoginState>(\n  (ref) => LoginController(ref.arguments ?? ''),\n);\n\n\nclass LoginPage extends StatefulWidget {\n  const LoginPage({Key? key}) : super(key: key);\n\n  @override\n  _LoginPageState createState() => _LoginPageState();\n}\n\nclass _LoginPageState extends State<LoginPage> {\n  @override\n  void initState() {\n    super.initState();\n    // you must set your arguments\n    // before call loginProvider.read or before use watch(loginProvider)\n    loginProvider.setArguments(\"initial@email.com\");\n  }\n\n  @override\n  Widget build(BuildContext context) {\n    // YOUR CODE HERE\n  }\n}\n")),(0,o.kt)("div",{className:"admonition admonition-danger alert alert--danger"},(0,o.kt)("div",{parentName:"div",className:"admonition-heading"},(0,o.kt)("h5",{parentName:"div"},(0,o.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,o.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"12",height:"16",viewBox:"0 0 12 16"},(0,o.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M5.05.31c.81 2.17.41 3.38-.52 4.31C3.55 5.67 1.98 6.45.9 7.98c-1.45 2.05-1.7 6.53 3.53 7.7-2.2-1.16-2.67-4.52-.3-6.61-.61 2.03.53 3.33 1.94 2.86 1.39-.47 2.3.53 2.27 1.67-.02.78-.31 1.44-1.13 1.81 3.42-.59 4.78-3.42 4.78-5.56 0-2.84-2.53-3.22-1.25-5.61-1.52.13-2.03 1.13-1.89 2.75.09 1.08-1.02 1.8-1.86 1.33-.67-.41-.66-1.19-.06-1.78C8.18 5.31 8.68 2.45 5.05.32L5.03.3l.02.01z"}))),"WARNING")),(0,o.kt)("div",{parentName:"div",className:"admonition-content"},(0,o.kt)("p",{parentName:"div"},"If you are using ",(0,o.kt)("inlineCode",{parentName:"p"},"ModalRoute.of(context)")," in your ",(0,o.kt)("inlineCode",{parentName:"p"},"build")," method or in the ",(0,o.kt)("inlineCode",{parentName:"p"},"routes")," parameter of one ",(0,o.kt)("inlineCode",{parentName:"p"},"MaterialApp"),"  to get ",(0,o.kt)("inlineCode",{parentName:"p"},"arguments")," that was passed by\n",(0,o.kt)("inlineCode",{parentName:"p"},"Navigator.push"),", ",(0,o.kt)("inlineCode",{parentName:"p"},"Navigator.pushName"),", etc and next you use  ",(0,o.kt)("inlineCode",{parentName:"p"},"Navigator.pushNamedAndRemoveUntil")," or ",(0,o.kt)("inlineCode",{parentName:"p"},"Navigator.pushNameAndRemoveUntil")," to navigate to a new Route removing multiples routes from the Stack the ",(0,o.kt)("inlineCode",{parentName:"p"},"ModalRoute.of(context)")," will rebuild the route before remove it and it could be a problem with a ",(0,o.kt)("inlineCode",{parentName:"p"},"provider")," because that could be recreated a disposed provider."),(0,o.kt)("p",{parentName:"div"},"In that cases you could use the ",(0,o.kt)("inlineCode",{parentName:"p"},"PageWithArguments")," widget to avoid the recreation of a disposed provider."))),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:flutter/material.dart';\nimport 'package:flutter_meedu/page.dart';\n\nclass ProductDetail extends StatelessWidget {\n  const ProductDetail({Key? key}) : super(key: key);\n\n  @override\n  Widget build(BuildContext context) {\n    return PageWithArguments(\n      onReady: (RouteSettings settings) {\n        final arguments = settings.arguments;\n        productProvider.setArguments(arguments);\n      },\n     builder: (context) => Scaffold(...) ,\n    );\n  }\n}\n")),(0,o.kt)("p",null,"Or you can create yourn own widget using ",(0,o.kt)("inlineCode",{parentName:"p"},"PageWithArgumentsWidget")," class."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"\nimport 'package:flutter/material.dart';\nimport 'package:flutter_meedu/meedu.dart';\nimport 'package:flutter_meedu/page.dart';\n\nfinal loginProvider = SimpleProvider(\n  (ref) => LoginController(ref.arguments),\n);\n\nclass LoginPage extends PageWithArgumentsWidget {\n  const LoginPage({Key? key}) : super(key: key);\n\n  @override\n  void onInit(RouteSettings settings) {\n    /// you can use settings to get data passed as an argument\n    /// using Navigator.pushName(context,'route-name', arguments: data);\n    loginProvider.setArguments(settings.arguments);\n  }\n\n  @override\n  Widget build(BuildContext context) {\n    return Scaffold(\n      .\n      .\n      .\n    );\n  }\n}\n")),(0,o.kt)("div",{className:"admonition admonition-success alert alert--success"},(0,o.kt)("div",{parentName:"div",className:"admonition-heading"},(0,o.kt)("h5",{parentName:"div"},(0,o.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,o.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"12",height:"16",viewBox:"0 0 12 16"},(0,o.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.5 0C3.48 0 1 2.19 1 5c0 .92.55 2.25 1 3 1.34 2.25 1.78 2.78 2 4v1h5v-1c.22-1.22.66-1.75 2-4 .45-.75 1-2.08 1-3 0-2.81-2.48-5-5.5-5zm3.64 7.48c-.25.44-.47.8-.67 1.11-.86 1.41-1.25 2.06-1.45 3.23-.02.05-.02.11-.02.17H5c0-.06 0-.13-.02-.17-.2-1.17-.59-1.83-1.45-3.23-.2-.31-.42-.67-.67-1.11C2.44 6.78 2 5.65 2 5c0-2.2 2.02-4 4.5-4 1.22 0 2.36.42 3.22 1.19C10.55 2.94 11 3.94 11 5c0 .66-.44 1.78-.86 2.48zM4 14h5c-.23 1.14-1.3 2-2.5 2s-2.27-.86-2.5-2z"}))),"success")),(0,o.kt)("div",{parentName:"div",className:"admonition-content"},(0,o.kt)("p",{parentName:"div"},"Since ",(0,o.kt)("inlineCode",{parentName:"p"},"flutter_meedu:^5.1.0")," if you are using the meedu's router module\nto navigate in your app you can get your arguments without BuildContext\nand you can directly use them in your providers. With this you don't need\na ",(0,o.kt)("inlineCode",{parentName:"p"},"PageWithArgumentsWidget")," to pass route arguments to your providers."),(0,o.kt)("pre",{parentName:"div"},(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"/// also you can pass directly the route arguments to your controllers\nfinal loginProvider = SimpleProvider(\n  (_) => LoginController(router.arguments as String),\n);\n\nor\n\n/// if you need to write unit or widget testing\n/// you can use the [overrideProvider] method\nsetUp((){\n  loginProvider.overrideProvider(\n    (_) => LoginController(mockedInitialValue),\n  );\n});\n")))))}d.isMDXComponent=!0}}]);