(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[1367],{3905:function(e,t,n){"use strict";n.d(t,{Zo:function(){return l},kt:function(){return p}});var r=n(7294);function a(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function i(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,r)}return n}function o(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?i(Object(n),!0).forEach((function(t){a(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):i(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function s(e,t){if(null==e)return{};var n,r,a=function(e,t){if(null==e)return{};var n,r,a={},i=Object.keys(e);for(r=0;r<i.length;r++)n=i[r],t.indexOf(n)>=0||(a[n]=e[n]);return a}(e,t);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(r=0;r<i.length;r++)n=i[r],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(a[n]=e[n])}return a}var c=r.createContext({}),u=function(e){var t=r.useContext(c),n=t;return e&&(n="function"==typeof e?e(t):o(o({},t),e)),n},l=function(e){var t=u(e.components);return r.createElement(c.Provider,{value:t},e.children)},m={inlineCode:"code",wrapper:function(e){var t=e.children;return r.createElement(r.Fragment,{},t)}},d=r.forwardRef((function(e,t){var n=e.components,a=e.mdxType,i=e.originalType,c=e.parentName,l=s(e,["components","mdxType","originalType","parentName"]),d=u(n),p=a,g=d["".concat(c,".").concat(p)]||d[p]||m[p]||i;return n?r.createElement(g,o(o({ref:t},l),{},{components:n})):r.createElement(g,o({ref:t},l))}));function p(e,t){var n=arguments,a=t&&t.mdxType;if("string"==typeof e||a){var i=n.length,o=new Array(i);o[0]=d;var s={};for(var c in t)hasOwnProperty.call(t,c)&&(s[c]=t[c]);s.originalType=e,s.mdxType="string"==typeof e?e:a,o[1]=s;for(var u=2;u<i;u++)o[u]=n[u];return r.createElement.apply(null,o)}return r.createElement.apply(null,n)}d.displayName="MDXCreateElement"},96:function(e,t,n){"use strict";n.r(t),n.d(t,{frontMatter:function(){return o},metadata:function(){return s},toc:function(){return c},default:function(){return l}});var r=n(2122),a=n(9756),i=(n(7294),n(3905)),o={sidebar_position:5},s={unversionedId:"state-management/working-with-arguments",id:"state-management/working-with-arguments",isDocsHomePage:!1,title:"Working with arguments",description:"Sometimes you need to pass initial values to your StateNotifier. In such cases, you can use the StateNotifierArgumentsProvider class and call the setArguments function to set argument values that will be retrieved in the creator callback of your provider.",source:"@site/docs/state-management/working-with-arguments.md",sourceDirName:"state-management",slug:"/state-management/working-with-arguments",permalink:"/docs/state-management/working-with-arguments",editUrl:"https://github.com/darwin-morocho/flutter-meedu/edit/master/website/docs/state-management/working-with-arguments.md",version:"current",lastUpdatedBy:"darwin-morocho",lastUpdatedAt:1697048754,formattedLastUpdatedAt:"10/11/2023",sidebarPosition:5,frontMatter:{sidebar_position:5},sidebar:"mySidebar",previous:{title:"BLoC pattern",permalink:"/docs/state-management/bloc-pattern"},next:{title:"Working with tags",permalink:"/docs/state-management/working-with-tags"}},c=[],u={toc:c};function l(e){var t=e.components,n=(0,a.Z)(e,["components"]);return(0,i.kt)("wrapper",(0,r.Z)({},u,n,{components:t,mdxType:"MDXLayout"}),(0,i.kt)("p",null,"Sometimes you need to pass initial values to your ",(0,i.kt)("inlineCode",{parentName:"p"},"StateNotifier"),". In such cases, you can use the ",(0,i.kt)("inlineCode",{parentName:"p"},"StateNotifierArgumentsProvider")," class and call the ",(0,i.kt)("inlineCode",{parentName:"p"},"setArguments")," function to set argument values that will be retrieved in the creator callback of your provider."),(0,i.kt)("p",null,"Next, you can use the ",(0,i.kt)("inlineCode",{parentName:"p"},"ref")," parameter of your callback generator to access the arguments passed in the ",(0,i.kt)("inlineCode",{parentName:"p"},"initState")," method."),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{4,24}","{4,24}":!0},"final loginProvider = StateNotifierArgumentsProvider<LoginNotifier, LoginState, String>(\n  (ref) => LoginNotifier(\n    LoginState(\n      email: ref.arguments, // here ref.arguments is a String\n      password: '',\n    ),\n  ),\n);\n\n\nclass LoginPage extends StatefulWidget {\n  const LoginPage({Key? key}) : super(key: key);\n\n  @override\n  _LoginPageState createState() => _LoginPageState();\n}\n\nclass _LoginPageState extends State<LoginPage> {\n  @override\n  void initState() {\n    super.initState();\n    // you must set your arguments\n    // before call loginProvider.read or before use watch(loginProvider)\n    loginProvider.setArguments(\"initial@email.com\");\n  }\n\n  @override\n  Widget build(BuildContext context) {\n    // YOUR CODE HERE\n  }\n}\n")),(0,i.kt)("div",{className:"admonition admonition-note alert alert--secondary"},(0,i.kt)("div",{parentName:"div",className:"admonition-heading"},(0,i.kt)("h5",{parentName:"div"},(0,i.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,i.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,i.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.3 5.69a.942.942 0 0 1-.28-.7c0-.28.09-.52.28-.7.19-.18.42-.28.7-.28.28 0 .52.09.7.28.18.19.28.42.28.7 0 .28-.09.52-.28.7a1 1 0 0 1-.7.3c-.28 0-.52-.11-.7-.3zM8 7.99c-.02-.25-.11-.48-.31-.69-.2-.19-.42-.3-.69-.31H6c-.27.02-.48.13-.69.31-.2.2-.3.44-.31.69h1v3c.02.27.11.5.31.69.2.2.42.31.69.31h1c.27 0 .48-.11.69-.31.2-.19.3-.42.31-.69H8V7.98v.01zM7 2.3c-3.14 0-5.7 2.54-5.7 5.68 0 3.14 2.56 5.7 5.7 5.7s5.7-2.55 5.7-5.7c0-3.15-2.56-5.69-5.7-5.69v.01zM7 .98c3.86 0 7 3.14 7 7s-3.14 7-7 7-7-3.12-7-7 3.14-7 7-7z"}))),"note")),(0,i.kt)("div",{parentName:"div",className:"admonition-content"},(0,i.kt)("p",{parentName:"div"},"You can use the static function ",(0,i.kt)("inlineCode",{parentName:"p"},"withArguments")," to create a ",(0,i.kt)("inlineCode",{parentName:"p"},"StateNotifierArgumentsProvider")),(0,i.kt)("pre",{parentName:"div"},(0,i.kt)("code",{parentName:"pre",className:"language-dart"},"final loginProvider = StateNotifierProvider.withArguments<LoginNotifier, LoginState, String>(\n  (ref) => LoginNotifier(\n    LoginState(\n      email: ref.arguments,\n      password: '',\n    ),\n  ),\n);\n")))))}l.isMDXComponent=!0}}]);