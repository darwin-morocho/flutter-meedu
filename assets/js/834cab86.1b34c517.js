(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[763],{3905:function(e,t,n){"use strict";n.d(t,{Zo:function(){return c},kt:function(){return g}});var r=n(7294);function a(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function o(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,r)}return n}function i(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?o(Object(n),!0).forEach((function(t){a(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):o(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function s(e,t){if(null==e)return{};var n,r,a=function(e,t){if(null==e)return{};var n,r,a={},o=Object.keys(e);for(r=0;r<o.length;r++)n=o[r],t.indexOf(n)>=0||(a[n]=e[n]);return a}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(r=0;r<o.length;r++)n=o[r],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(a[n]=e[n])}return a}var l=r.createContext({}),u=function(e){var t=r.useContext(l),n=t;return e&&(n="function"==typeof e?e(t):i(i({},t),e)),n},c=function(e){var t=u(e.components);return r.createElement(l.Provider,{value:t},e.children)},m={inlineCode:"code",wrapper:function(e){var t=e.children;return r.createElement(r.Fragment,{},t)}},p=r.forwardRef((function(e,t){var n=e.components,a=e.mdxType,o=e.originalType,l=e.parentName,c=s(e,["components","mdxType","originalType","parentName"]),p=u(n),g=a,d=p["".concat(l,".").concat(g)]||p[g]||m[g]||o;return n?r.createElement(d,i(i({ref:t},c),{},{components:n})):r.createElement(d,i({ref:t},c))}));function g(e,t){var n=arguments,a=t&&t.mdxType;if("string"==typeof e||a){var o=n.length,i=new Array(o);i[0]=p;var s={};for(var l in t)hasOwnProperty.call(t,l)&&(s[l]=t[l]);s.originalType=e,s.mdxType="string"==typeof e?e:a,i[1]=s;for(var u=2;u<o;u++)i[u]=n[u];return r.createElement.apply(null,i)}return r.createElement.apply(null,n)}p.displayName="MDXCreateElement"},5675:function(e,t,n){"use strict";n.r(t),n.d(t,{frontMatter:function(){return i},metadata:function(){return s},toc:function(){return l},default:function(){return c}});var r=n(2122),a=n(9756),o=(n(7294),n(3905)),i={sidebar_position:5},s={unversionedId:"state-managment/working-with-arguments",id:"state-managment/working-with-arguments",isDocsHomePage:!1,title:"Working with arguments",description:"Some times you need to pass a initial values to your SimpleNotifier or StateNotifier in that cases you can sue the setArguments method of your provider.",source:"@site/docs/state-managment/working-with-arguments.md",sourceDirName:"state-managment",slug:"/state-managment/working-with-arguments",permalink:"/docs/state-managment/working-with-arguments",editUrl:"https://github.com/darwin-morocho/flutter-meedu/edit/master/website/docs/state-managment/working-with-arguments.md",version:"current",sidebarPosition:5,frontMatter:{sidebar_position:5},sidebar:"mySidebar",previous:{title:"StateNotifier",permalink:"/docs/state-managment/state-notifier"},next:{title:"Working with tags",permalink:"/docs/state-managment/working-with-tags"}},l=[],u={toc:l};function c(e){var t=e.components,n=(0,a.Z)(e,["components"]);return(0,o.kt)("wrapper",(0,r.Z)({},u,n,{components:t,mdxType:"MDXLayout"}),(0,o.kt)("p",null,"Some times you need to pass a initial values to your ",(0,o.kt)("inlineCode",{parentName:"p"},"SimpleNotifier")," or ",(0,o.kt)("inlineCode",{parentName:"p"},"StateNotifier")," in that cases you can sue the ",(0,o.kt)("inlineCode",{parentName:"p"},"setArguments")," method of your provider."),(0,o.kt)("p",null,"In the next example to create a new instance of ",(0,o.kt)("strong",{parentName:"p"},"LoginController")," we need a initial email value"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"class LoginController extends StateNotifier<LoginState> {\n  LoginController(String initialEmail)\n      : super(\n          LoginState(email: initialEmail, password: ''),\n        );\n}\n")),(0,o.kt)("p",null,"Next you can use the ",(0,o.kt)("inlineCode",{parentName:"p"},"ref")," parameter of your callback generator to get the ",(0,o.kt)("inlineCode",{parentName:"p"},"arguments")," passed in the ",(0,o.kt)("inlineCode",{parentName:"p"},"initState")," method."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{2,19}","{2,19}":!0},"final loginProvider = StateProvider<LoginController, LoginState>(\n  (ref) => LoginController(ref.arguments ?? ''),\n);\n\n\nclass LoginPage extends StatefulWidget {\n  const LoginPage({Key? key}) : super(key: key);\n\n  @override\n  _LoginPageState createState() => _LoginPageState();\n}\n\nclass _LoginPageState extends State<LoginPage> {\n  @override\n  void initState() {\n    super.initState();\n    // you must set your arguments\n    // before call loginProvider.read or before use watch(loginProvider)\n    loginProvider.setArguments(\"initial@email.com\");\n  }\n\n  @override\n  Widget build(BuildContext context) {\n    // YOUR CODE HERE\n  }\n}\n")))}c.isMDXComponent=!0}}]);