(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[6243],{3905:function(e,n,t){"use strict";t.d(n,{Zo:function(){return p},kt:function(){return m}});var a=t(7294);function r(e,n,t){return n in e?Object.defineProperty(e,n,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[n]=t,e}function i(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);n&&(a=a.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,a)}return t}function o(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?i(Object(t),!0).forEach((function(n){r(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):i(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}function l(e,n){if(null==e)return{};var t,a,r=function(e,n){if(null==e)return{};var t,a,r={},i=Object.keys(e);for(a=0;a<i.length;a++)t=i[a],n.indexOf(t)>=0||(r[t]=e[t]);return r}(e,n);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(a=0;a<i.length;a++)t=i[a],n.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(r[t]=e[t])}return r}var s=a.createContext({}),d=function(e){var n=a.useContext(s),t=n;return e&&(t="function"==typeof e?e(n):o(o({},n),e)),t},p=function(e){var n=d(e.components);return a.createElement(s.Provider,{value:n},e.children)},u={inlineCode:"code",wrapper:function(e){var n=e.children;return a.createElement(a.Fragment,{},n)}},c=a.forwardRef((function(e,n){var t=e.components,r=e.mdxType,i=e.originalType,s=e.parentName,p=l(e,["components","mdxType","originalType","parentName"]),c=d(t),m=r,g=c["".concat(s,".").concat(m)]||c[m]||u[m]||i;return t?a.createElement(g,o(o({ref:n},p),{},{components:t})):a.createElement(g,o({ref:n},p))}));function m(e,n){var t=arguments,r=n&&n.mdxType;if("string"==typeof e||r){var i=t.length,o=new Array(i);o[0]=c;var l={};for(var s in n)hasOwnProperty.call(n,s)&&(l[s]=n[s]);l.originalType=e,l.mdxType="string"==typeof e?e:r,o[1]=l;for(var d=2;d<i;d++)o[d]=t[d];return a.createElement.apply(null,o)}return a.createElement.apply(null,t)}c.displayName="MDXCreateElement"},4253:function(e,n,t){"use strict";t.r(n),t.d(n,{frontMatter:function(){return o},metadata:function(){return l},toc:function(){return s},default:function(){return p}});var a=t(2122),r=t(9756),i=(t(7294),t(3905)),o={sidebar_position:4},l={unversionedId:"state-management/state-notifier",id:"state-management/state-notifier",isDocsHomePage:!1,title:"StateNotifier",description:"Para manejo de estados mas complejos considere usar un StateNotifier en lugar de un",source:"@site/i18n/es/docusaurus-plugin-content-docs/current/state-management/state-notifier.md",sourceDirName:"state-management",slug:"/state-management/state-notifier",permalink:"/es/docs/state-management/state-notifier",editUrl:"https://github.com/darwin-morocho/flutter-meedu/edit/master/website/i18n/es/docusaurus-plugin-content-docs/current",version:"current",lastUpdatedBy:"Darwin",lastUpdatedAt:1645821380,formattedLastUpdatedAt:"25/2/2022",sidebarPosition:4,frontMatter:{sidebar_position:4},sidebar:"mySidebar",previous:{title:"SimpleNotifier",permalink:"/es/docs/state-management/simple-notifier"},next:{title:"Trabajar con argumentos",permalink:"/es/docs/state-management/working-with-arguments"}},s=[{value:"Usando equatable",id:"usando-equatable",children:[]},{value:"Usando Freezed",id:"usando-freezed",children:[]}],d={toc:s};function p(e){var n=e.components,t=(0,r.Z)(e,["components"]);return(0,i.kt)("wrapper",(0,a.Z)({},d,t,{components:n,mdxType:"MDXLayout"}),(0,i.kt)("p",null,"Para manejo de estados mas complejos considere usar un ",(0,i.kt)("inlineCode",{parentName:"p"},"StateNotifier")," en lugar de un\n",(0,i.kt)("inlineCode",{parentName:"p"},"SimpleNotifier"),"."),(0,i.kt)("p",null,"Un ",(0,i.kt)("inlineCode",{parentName:"p"},"StateNotifier")," almacena un \xfanico estado inmutable."),(0,i.kt)("p",null,"Un estado inmutable es una instancia de una clase que sobreescribe el operador  ",(0,i.kt)("inlineCode",{parentName:"p"},"==")," y el  ",(0,i.kt)("inlineCode",{parentName:"p"},"hashCode"),". Para esto puede usar ",(0,i.kt)("a",{parentName:"p",href:"https://pub.dev/packages/equatable"},"equatable")," o ",(0,i.kt)("a",{parentName:"p",href:"https://pub.dev/packages/freezed"},"freezed")," para crear clases inmutables."),(0,i.kt)("h3",{id:"usando-equatable"},"Usando equatable"),(0,i.kt)("p",null,"Agregue ",(0,i.kt)("inlineCode",{parentName:"p"},"equatable")," como dependencia en su archivo ",(0,i.kt)("inlineCode",{parentName:"p"},"pubspec.yaml")),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-yaml"},"equatable: latest_version\n")),(0,i.kt)("p",null,"Ahora puede crear una clase inmutable para su estado como se muestra\na continuaci\xf3n"),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:equatable/equatable.dart';\n\nclass LoginState extends Equatable {\n  final String email, password;\n  LoginState({\n    required this.email,\n    required this.password,\n  });\n\n  static LoginState get initialState => LoginState(email: '', password: '');\n\n  LoginState copyWith({\n    String? email,\n    String? password,\n  }) {\n    return LoginState(\n      email: email ?? this.email,\n      password: password ?? this.password,\n    );\n  }\n\n  @override\n  List<Object?> get props => [email, password];\n}\n")),(0,i.kt)("h3",{id:"usando-freezed"},"Usando Freezed"),(0,i.kt)("p",null,"Para trabajar con freezed necesita ",(0,i.kt)("a",{parentName:"p",href:"https://pub.dev/packages/build_runner"},"build_runner")," y ",(0,i.kt)("a",{parentName:"p",href:"https://pub.dev/packages/freezed_annotation"},"freezed_annotation")),(0,i.kt)("p",null,"Luego en su ",(0,i.kt)("inlineCode",{parentName:"p"},"pubspec.yaml")," (reemplace ",(0,i.kt)("inlineCode",{parentName:"p"},"latest_version")," con la ultima versi\xf3n estable de freezed)"),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-yaml"},"dependencies:\n  flutter:\n    sdk: flutter\n  freezed_annotation: latest_version\n\ndev_dependencies:\n  flutter_test:\n    sdk: flutter\n\n  build_runner: latest_version\n  freezed: latest_version\n")),(0,i.kt)("p",null,"Si tiene alg\xfan problema al tratar  de instalar y configurar frezeed consulte\nla documentaci\xf3n oficial ",(0,i.kt)("a",{parentName:"p",href:"https://pub.dev/packages/freezed"},"https://pub.dev/packages/freezed")),(0,i.kt)("p",null,"El siguiente c\xf3digo muestra como generar  una clase inmutable con frezee en\ndonde freezed generar\xe1 el m\xe9todo ",(0,i.kt)("inlineCode",{parentName:"p"},"copyWith")," por nosotros."),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:freezed_annotation/freezed_annotation.dart';\npart 'login_state.freezed.dart';\n\n@freezed\nclass LoginState with _$LoginState {\n  const LoginState({\n    @Default('') String email,\n    @Default('') String password,\n  }) = _LoginState;\n\n  static LoginState get initialState => LoginState();\n}\n")),(0,i.kt)("p",null,"Ahora ejecute el siguiente comando para genrar los archivos con extensi\xf3n ",(0,i.kt)("inlineCode",{parentName:"p"},".frezeed.dart")),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-shell"},"flutter pub run build_runner build --delete-conflicting-outputs\n")),(0,i.kt)("p",null,"Ahora puede usar la clase ",(0,i.kt)("inlineCode",{parentName:"p"},"LoginState")," para trabajar con una clase que extiende de ",(0,i.kt)("inlineCode",{parentName:"p"},"StateNotifier")),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:flutter_meedu/meedu.dart';\n\nclass LoginController extends StateNotifier<LoginState> {\n  // you need pass an inital state using super\n  LoginController():super(LoginState.initialState);\n\n  void onEmailChanged(String email) {\n    state = state.copyWith(email: email);\n  }\n\n  void onPasswordChanged(String password) {\n    state = state.copyWith(password: password);\n  }\n}\n")),(0,i.kt)("div",{className:"admonition admonition-info alert alert--info"},(0,i.kt)("div",{parentName:"div",className:"admonition-heading"},(0,i.kt)("h5",{parentName:"div"},(0,i.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,i.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,i.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M7 2.3c3.14 0 5.7 2.56 5.7 5.7s-2.56 5.7-5.7 5.7A5.71 5.71 0 0 1 1.3 8c0-3.14 2.56-5.7 5.7-5.7zM7 1C3.14 1 0 4.14 0 8s3.14 7 7 7 7-3.14 7-7-3.14-7-7-7zm1 3H6v5h2V4zm0 6H6v2h2v-2z"}))),"info")),(0,i.kt)("div",{parentName:"div",className:"admonition-content"},(0,i.kt)("p",{parentName:"div"},"Un StateNotifier automaticamente notifica cuando la propiedad ",(0,i.kt)("inlineCode",{parentName:"p"},"state"),"  ha cambiado."),(0,i.kt)("p",{parentName:"div"},"Si solo desea codificar el ",(0,i.kt)("inlineCode",{parentName:"p"},"state")," de su ",(0,i.kt)("inlineCode",{parentName:"p"},"StateNotifier")," sin notificar a los oyentes (sin reconstruir sus widgets ",(0,i.kt)("inlineCode",{parentName:"p"},"Consumer")," y sin escuchar los cambios en un ",(0,i.kt)("inlineCode",{parentName:"p"},"ProviderListener"),")\npuede usar el m\xe9todo ",(0,i.kt)("inlineCode",{parentName:"p"},"onlyUpdate"),"de su ",(0,i.kt)("inlineCode",{parentName:"p"},"StateNotifier"),"."),(0,i.kt)("pre",{parentName:"div"},(0,i.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{7}","{7}":!0},"class LoginController extends StateNotifier<LoginState> {\n  // you need pass an inital state using super\n  LoginController():super(LoginState.initialState);\n\n  void onEmailChanged(String email) {\n    // only update the state without rebuil of Consumers or\n    // listening in your ProviderListener\n    onlyUpdate(state.copyWith(email: email));\n  }\n  .\n  .\n  .\n\n}\n")))),(0,i.kt)("p",null,"Ahora debe crear un provider usando la clase ",(0,i.kt)("inlineCode",{parentName:"p"},"StateProvider")," a dem\xe1s de definir los\n",(0,i.kt)("inlineCode",{parentName:"p"},"Generic Types")," indicando que clase es la que extiende de ",(0,i.kt)("inlineCode",{parentName:"p"},"StateNotifier")," y la clase usada\npara el estado."),(0,i.kt)("p",null,"Para escuchar los cambios en su ",(0,i.kt)("inlineCode",{parentName:"p"},"StateNotifier")," utilice el widget ",(0,i.kt)("inlineCode",{parentName:"p"},"Consumer")),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-dart"},'import \'package:flutter/material.dart\';\nimport \'package:flutter_meedu/flutter_meedu.dart\';\n\n\nfinal loginProvider = StateProvider<LoginController, LoginState>(\n  (_) => LoginController(),\n);\n\n\nclass LoginPage extends StatelessWidget {\n  const LoginPage({Key? key}) : super(key: key);\n\n  @override\n  Widget build(BuildContext context) {\n    return Scaffold(\n      body: SafeArea(\n        child: Padding(\n          padding: const EdgeInsets.all(8.0),\n          child: Column(\n            children: [\n              TextField(\n                onChanged: loginProvider.read.onEmailChanged,\n                decoration: InputDecoration(\n                  labelText: "Email",\n                ),\n              ),\n              TextField(\n                onChanged: loginProvider.read.onPasswordChanged,\n                decoration: InputDecoration(\n                  labelText: "Password",\n                ),\n              ),\n              SizedBox(height: 30),\n              Consumer(\n                builder: (_, ref, __) {\n                  final controller = ref.watch(loginProvider);\n                  final state = controller.state;\n\n                  final email = state.email;\n                  final password = state.password;\n\n                  final enabled = email.isNotEmpty && password.isNotEmpty;\n\n                  return ElevatedButton(\n                    onPressed: enabled\n                        ? () {\n                            // YOUR CODE HERE\n                          }\n                        : null,\n                    child: Text("SEND"),\n                  );\n                },\n              )\n            ],\n          ),\n        ),\n      ),\n    );\n  }\n}\n')),(0,i.kt)("p",null,"Tambi\xe9n puede usar el filtro ",(0,i.kt)("inlineCode",{parentName:"p"},".select")," para reconstruir sus ",(0,i.kt)("inlineCode",{parentName:"p"},"Consumer")," solo cuando es necesario."),(0,i.kt)("p",null,"Por ejemplo el siguiente c\xf3digo actualiza el Consumer solo cuando la propiedad ",(0,i.kt)("inlineCode",{parentName:"p"},"email"),"\nen nuestro ",(0,i.kt)("inlineCode",{parentName:"p"},"LoginState")," ha cambiado."),(0,i.kt)("p",null,"Aqu\xed usamos ",(0,i.kt)("inlineCode",{parentName:"p"},"ref.select")," para acceder directamente al valor retornado por ",(0,i.kt)("inlineCode",{parentName:"p"},"loginProvider.select")," pero si desea acceder al notifier vinculado a ",(0,i.kt)("inlineCode",{parentName:"p"},"loginProvider")," utilice ",(0,i.kt)("inlineCode",{parentName:"p"},"ref.watch")," con ",(0,i.kt)("inlineCode",{parentName:"p"},"loginProvider.select")),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{4}","{4}":!0},"Consumer(\n  builder: (_, ref, __) {\n    final email = ref.select(\n      loginProvider.select((_)=>_.email),\n    );\n    return Text(email);\n  },\n)\n")),(0,i.kt)("div",{className:"admonition admonition-note alert alert--secondary"},(0,i.kt)("div",{parentName:"div",className:"admonition-heading"},(0,i.kt)("h5",{parentName:"div"},(0,i.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,i.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,i.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.3 5.69a.942.942 0 0 1-.28-.7c0-.28.09-.52.28-.7.19-.18.42-.28.7-.28.28 0 .52.09.7.28.18.19.28.42.28.7 0 .28-.09.52-.28.7a1 1 0 0 1-.7.3c-.28 0-.52-.11-.7-.3zM8 7.99c-.02-.25-.11-.48-.31-.69-.2-.19-.42-.3-.69-.31H6c-.27.02-.48.13-.69.31-.2.2-.3.44-.31.69h1v3c.02.27.11.5.31.69.2.2.42.31.69.31h1c.27 0 .48-.11.69-.31.2-.19.3-.42.31-.69H8V7.98v.01zM7 2.3c-3.14 0-5.7 2.54-5.7 5.68 0 3.14 2.56 5.7 5.7 5.7s5.7-2.55 5.7-5.7c0-3.15-2.56-5.69-5.7-5.69v.01zM7 .98c3.86 0 7 3.14 7 7s-3.14 7-7 7-7-3.12-7-7 3.14-7 7-7z"}))),"note")),(0,i.kt)("div",{parentName:"div",className:"admonition-content"},(0,i.kt)("p",{parentName:"div"},"Tambi\xe9n puede usar el filtro ",(0,i.kt)("inlineCode",{parentName:"p"},".when")," para comprobar el estado actual y el estado\nanterior y determinar si el widget Consumer debe actualizarse."),(0,i.kt)("pre",{parentName:"div"},(0,i.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{4}","{4}":!0},"Consumer(\n  builder: (_, ref, __) {\n    final email = ref.watch(\n      loginProvider.when((prev, current) => prev.email != current.email),\n    ).state.email;\n    return Text(email);\n  },\n)\n")))),(0,i.kt)("div",{className:"admonition admonition-info alert alert--info"},(0,i.kt)("div",{parentName:"div",className:"admonition-heading"},(0,i.kt)("h5",{parentName:"div"},(0,i.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,i.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,i.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M7 2.3c3.14 0 5.7 2.56 5.7 5.7s-2.56 5.7-5.7 5.7A5.71 5.71 0 0 1 1.3 8c0-3.14 2.56-5.7 5.7-5.7zM7 1C3.14 1 0 4.14 0 8s3.14 7 7 7 7-3.14 7-7-3.14-7-7-7zm1 3H6v5h2V4zm0 6H6v2h2v-2z"}))),"info")),(0,i.kt)("div",{parentName:"div",className:"admonition-content"},(0,i.kt)("p",{parentName:"div"},"De la misma manera puede escuchar los cambios en su ",(0,i.kt)("inlineCode",{parentName:"p"},"StateNofier")," suando el widget ",(0,i.kt)("inlineCode",{parentName:"p"},"ProviderListener")," o mediante un ",(0,i.kt)("inlineCode",{parentName:"p"},"StreamSubscription")))),(0,i.kt)("p",null,"Tambi\xe9n la clase ",(0,i.kt)("inlineCode",{parentName:"p"},"StateNotifier")," le permite escuchar cuando el estado va a cambiar o ya cambio."),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-dart"},"class LoginController extends StateNotifier<LoginState> {\n  // you need pass an inital state using super\n  LoginController() : super(LoginState.initialState);\n\n  void onEmailChanged(String email) {\n    state = state.copyWith(email: email);\n  }\n\n  void onPasswordChanged(String password) {\n    state = state.copyWith(password: password);\n  }\n\n  @override\n  void onStateChanged(LoginState oldState, LoginState currentState) {\n    // YOUR CODE HERE\n  }\n\n  @override\n  bool onStateWillChange(LoginState oldState, LoginState newState) {\n    // YOUR CODE HERE\n    return true; // you need to return a boolean to decide if the update of the state is allowed\n  }\n}\n")))}p.isMDXComponent=!0}}]);