(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[1305],{3905:function(e,t,n){"use strict";n.d(t,{Zo:function(){return p},kt:function(){return u}});var a=n(7294);function i(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function r(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);t&&(a=a.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,a)}return n}function o(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?r(Object(n),!0).forEach((function(t){i(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):r(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function s(e,t){if(null==e)return{};var n,a,i=function(e,t){if(null==e)return{};var n,a,i={},r=Object.keys(e);for(a=0;a<r.length;a++)n=r[a],t.indexOf(n)>=0||(i[n]=e[n]);return i}(e,t);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);for(a=0;a<r.length;a++)n=r[a],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(i[n]=e[n])}return i}var l=a.createContext({}),d=function(e){var t=a.useContext(l),n=t;return e&&(n="function"==typeof e?e(t):o(o({},t),e)),n},p=function(e){var t=d(e.components);return a.createElement(l.Provider,{value:t},e.children)},m={inlineCode:"code",wrapper:function(e){var t=e.children;return a.createElement(a.Fragment,{},t)}},c=a.forwardRef((function(e,t){var n=e.components,i=e.mdxType,r=e.originalType,l=e.parentName,p=s(e,["components","mdxType","originalType","parentName"]),c=d(n),u=i,g=c["".concat(l,".").concat(u)]||c[u]||m[u]||r;return n?a.createElement(g,o(o({ref:t},p),{},{components:n})):a.createElement(g,o({ref:t},p))}));function u(e,t){var n=arguments,i=t&&t.mdxType;if("string"==typeof e||i){var r=n.length,o=new Array(r);o[0]=c;var s={};for(var l in t)hasOwnProperty.call(t,l)&&(s[l]=t[l]);s.originalType=e,s.mdxType="string"==typeof e?e:i,o[1]=s;for(var d=2;d<r;d++)o[d]=n[d];return a.createElement.apply(null,o)}return a.createElement.apply(null,n)}c.displayName="MDXCreateElement"},5957:function(e,t,n){"use strict";n.r(t),n.d(t,{frontMatter:function(){return o},metadata:function(){return s},toc:function(){return l},default:function(){return p}});var a=n(2122),i=n(9756),r=(n(7294),n(3905)),o={sidebar_position:4},s={unversionedId:"state-managment/state-notifier",id:"version-3.x.x/state-managment/state-notifier",isDocsHomePage:!1,title:"StateNotifier",description:"If you have a more complex state consider using the StateNotifier class instead of SimpleNotifier.",source:"@site/versioned_docs/version-3.x.x/state-managment/state-notifier.md",sourceDirName:"state-managment",slug:"/state-managment/state-notifier",permalink:"/docs/3.x.x/state-managment/state-notifier",editUrl:"https://github.com/darwin-morocho/flutter-meedu/edit/master/website/versioned_docs/version-3.x.x/state-managment/state-notifier.md",version:"3.x.x",sidebarPosition:4,frontMatter:{sidebar_position:4},sidebar:"version-3.x.x/mySidebar",previous:{title:"SimpleNotifier",permalink:"/docs/3.x.x/state-managment/simple-notifier"},next:{title:"Working with arguments",permalink:"/docs/3.x.x/state-managment/working-with-arguments"}},l=[],d={toc:l};function p(e){var t=e.components,n=(0,i.Z)(e,["components"]);return(0,r.kt)("wrapper",(0,a.Z)({},d,n,{components:t,mdxType:"MDXLayout"}),(0,r.kt)("p",null,"If you have a more complex state consider using the StateNotifier class instead of SimpleNotifier."),(0,r.kt)("p",null,"A StateNotifier stores a single immutable state."),(0,r.kt)("p",null,"An immutable state is an instance of one Class that overrides ",(0,r.kt)("inlineCode",{parentName:"p"},"==")," and ",(0,r.kt)("inlineCode",{parentName:"p"},"hashCode"),". For example you could use ",(0,r.kt)("a",{parentName:"p",href:"https://pub.dev/packages/equatable"},"equatable")," to create an immutable Class."),(0,r.kt)("p",null,"Add equatable as a dependency in your ",(0,r.kt)("inlineCode",{parentName:"p"},"pubspec.yaml")," file"),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-yaml"},'equatable: "^2.0.2"\n')),(0,r.kt)("p",null,"Now you can create a Class to manage your state"),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:equatable/equatable.dart';\n\nclass LoginState extends Equatable {\n  final String email, password;\n  LoginState({\n    required this.email,\n    required this.password,\n  });\n\n  static LoginState get initialState => LoginState(email: '', password: '');\n\n  LoginState copyWith({\n    String? email,\n    String? password,\n  }) {\n    return LoginState(\n      email: email ?? this.email,\n      password: password ?? this.password,\n    );\n  }\n\n  @override\n  List<Object?> get props => [email, password];\n}\n")),(0,r.kt)("p",null,"Now you can use the ",(0,r.kt)("inlineCode",{parentName:"p"},"LoginState")," class to create a ",(0,r.kt)("inlineCode",{parentName:"p"},"StateNotifier")),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:flutter_meedu/meedu.dart';\n\nclass LoginController extends StateNotifier<LoginState> {\n  // you need pass an inital state using super\n  LoginController():super(LoginState.initialState);\n\n  void onEmailChanged(String email) {\n    state = state.copyWith(email: email);\n  }\n\n  void onPasswordChanged(String password) {\n    state = state.copyWith(password: password);\n  }\n}\n")),(0,r.kt)("p",null,"Next you need to create a ",(0,r.kt)("inlineCode",{parentName:"p"},"StateNotifier")," and use the ",(0,r.kt)("inlineCode",{parentName:"p"},"Consumer")," widget to listen the changes in your state"),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-dart"},'import \'package:flutter/material.dart\';\nimport \'package:flutter_meedu/flutter_meedu.dart\';\n\n\nfinal loginProvider = StateProvider<LoginController, LoginState>(\n  (_) => LoginController(),\n);\n\n\nclass LoginPage extends StatelessWidget {\n  const LoginPage({Key? key}) : super(key: key);\n\n  @override\n  Widget build(BuildContext context) {\n    return Scaffold(\n      body: SafeArea(\n        child: Padding(\n          padding: const EdgeInsets.all(8.0),\n          child: Column(\n            children: [\n              TextField(\n                onChanged: loginProvider.read.onEmailChanged,\n                decoration: InputDecoration(\n                  labelText: "Email",\n                ),\n              ),\n              TextField(\n                onChanged: loginProvider.read.onPasswordChanged,\n                decoration: InputDecoration(\n                  labelText: "Password",\n                ),\n              ),\n              SizedBox(height: 30),\n              Consumer(\n                builder: (_, watch, __) {\n                  final controller = watch(loginProvider);\n                  final state = controller.state;\n\n                  final email = state.email;\n                  final password = state.password;\n\n                  final enabled = email.isNotEmpty && password.isNotEmpty;\n\n                  return ElevatedButton(\n                    onPressed: enabled\n                        ? () {\n                            // YOUR CODE HERE\n                          }\n                        : null,\n                    child: Text("SEND"),\n                  );\n                },\n              )\n            ],\n          ),\n        ),\n      ),\n    );\n  }\n}\n')),(0,r.kt)("p",null,"Also you can use the ",(0,r.kt)("inlineCode",{parentName:"p"},"WatchFilter")," class to only rebuild your ",(0,r.kt)("inlineCode",{parentName:"p"},"Consumer")," when is need it."),(0,r.kt)("p",null,"For example the next code only rebuilds the Consumer widget when the ",(0,r.kt)("inlineCode",{parentName:"p"},"email")," in our ",(0,r.kt)("inlineCode",{parentName:"p"},"LoginState")," has changed."),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{3,6}","{3,6}":!0},"Consumer(\n  builder: (_, watch, __) {\n    final email = watch<LoginController, LoginState>(\n      loginProvider,\n      WatchFilter(\n        when: (prev, current) => prev.email != current.email,\n      ),\n    ).state.email;\n    return Text(email);\n  },\n)\n")),(0,r.kt)("div",{className:"admonition admonition-note alert alert--secondary"},(0,r.kt)("div",{parentName:"div",className:"admonition-heading"},(0,r.kt)("h5",{parentName:"div"},(0,r.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,r.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,r.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.3 5.69a.942.942 0 0 1-.28-.7c0-.28.09-.52.28-.7.19-.18.42-.28.7-.28.28 0 .52.09.7.28.18.19.28.42.28.7 0 .28-.09.52-.28.7a1 1 0 0 1-.7.3c-.28 0-.52-.11-.7-.3zM8 7.99c-.02-.25-.11-.48-.31-.69-.2-.19-.42-.3-.69-.31H6c-.27.02-.48.13-.69.31-.2.2-.3.44-.31.69h1v3c.02.27.11.5.31.69.2.2.42.31.69.31h1c.27 0 .48-.11.69-.31.2-.19.3-.42.31-.69H8V7.98v.01zM7 2.3c-3.14 0-5.7 2.54-5.7 5.68 0 3.14 2.56 5.7 5.7 5.7s5.7-2.55 5.7-5.7c0-3.15-2.56-5.69-5.7-5.69v.01zM7 .98c3.86 0 7 3.14 7 7s-3.14 7-7 7-7-3.12-7-7 3.14-7 7-7z"}))),"note")),(0,r.kt)("div",{parentName:"div",className:"admonition-content"},(0,r.kt)("p",{parentName:"div"},"When you use the ",(0,r.kt)("inlineCode",{parentName:"p"},"WatchFilter")," to listen the changes in a ",(0,r.kt)("inlineCode",{parentName:"p"},"StateNotifier")," you need to define the generic types\nin the watch method."),(0,r.kt)("ul",{parentName:"div"},(0,r.kt)("li",{parentName:"ul"},"The first generic type is the class witch extends of StateNotifier."),(0,r.kt)("li",{parentName:"ul"},"The second generic type is the class used to manage our state."),(0,r.kt)("li",{parentName:"ul"},"The ",(0,r.kt)("inlineCode",{parentName:"li"},"ids")," and ",(0,r.kt)("inlineCode",{parentName:"li"},"select")," params only work with a ",(0,r.kt)("inlineCode",{parentName:"li"},"SimpleNotifier"),".")))),(0,r.kt)("div",{className:"admonition admonition-info alert alert--info"},(0,r.kt)("div",{parentName:"div",className:"admonition-heading"},(0,r.kt)("h5",{parentName:"div"},(0,r.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,r.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,r.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M7 2.3c3.14 0 5.7 2.56 5.7 5.7s-2.56 5.7-5.7 5.7A5.71 5.71 0 0 1 1.3 8c0-3.14 2.56-5.7 5.7-5.7zM7 1C3.14 1 0 4.14 0 8s3.14 7 7 7 7-3.14 7-7-3.14-7-7-7zm1 3H6v5h2V4zm0 6H6v2h2v-2z"}))),"info")),(0,r.kt)("div",{parentName:"div",className:"admonition-content"},(0,r.kt)("p",{parentName:"div"},"In the same way you can listen the changes of your ",(0,r.kt)("inlineCode",{parentName:"p"},"StateNofier")," using the ",(0,r.kt)("inlineCode",{parentName:"p"},"ProviderListener")," widget or using a ",(0,r.kt)("inlineCode",{parentName:"p"},"StreamSubscription")))),(0,r.kt)("p",null,"Also the ",(0,r.kt)("inlineCode",{parentName:"p"},"StateNotifier")," class allows you to listen when the state is going to change and listen when the state has changed."),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-dart"},"class LoginController extends StateNotifier<LoginState> {\n  // you need pass an inital state using super\n  LoginController() : super(LoginState.initialState);\n\n  void onEmailChanged(String email) {\n    state = state.copyWith(email: email);\n  }\n\n  void onPasswordChanged(String password) {\n    state = state.copyWith(password: password);\n  }\n\n  @override\n  void onStateChanged(LoginState oldState, LoginState currentState) {\n    // YOUR CODE HERE\n  }\n\n  @override\n  bool onStateWillChange(LoginState oldState, LoginState newState) {\n    // YOUR CODE HERE\n    return true; // you need to return a boolean to decide if the update of the state is allowed\n  }\n}\n")))}p.isMDXComponent=!0}}]);