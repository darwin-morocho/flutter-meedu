(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[7759],{3905:function(e,n,t){"use strict";t.d(n,{Zo:function(){return p},kt:function(){return m}});var a=t(7294);function r(e,n,t){return n in e?Object.defineProperty(e,n,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[n]=t,e}function o(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);n&&(a=a.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,a)}return t}function i(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?o(Object(t),!0).forEach((function(n){r(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):o(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}function s(e,n){if(null==e)return{};var t,a,r=function(e,n){if(null==e)return{};var t,a,r={},o=Object.keys(e);for(a=0;a<o.length;a++)t=o[a],n.indexOf(t)>=0||(r[t]=e[t]);return r}(e,n);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(a=0;a<o.length;a++)t=o[a],n.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(r[t]=e[t])}return r}var u=a.createContext({}),c=function(e){var n=a.useContext(u),t=n;return e&&(t="function"==typeof e?e(n):i(i({},n),e)),t},p=function(e){var n=c(e.components);return a.createElement(u.Provider,{value:n},e.children)},l={inlineCode:"code",wrapper:function(e){var n=e.children;return a.createElement(a.Fragment,{},n)}},d=a.forwardRef((function(e,n){var t=e.components,r=e.mdxType,o=e.originalType,u=e.parentName,p=s(e,["components","mdxType","originalType","parentName"]),d=c(t),m=r,y=d["".concat(u,".").concat(m)]||d[m]||l[m]||o;return t?a.createElement(y,i(i({ref:n},p),{},{components:t})):a.createElement(y,i({ref:n},p))}));function m(e,n){var t=arguments,r=n&&n.mdxType;if("string"==typeof e||r){var o=t.length,i=new Array(o);i[0]=d;var s={};for(var u in n)hasOwnProperty.call(n,u)&&(s[u]=n[u]);s.originalType=e,s.mdxType="string"==typeof e?e:r,i[1]=s;for(var c=2;c<o;c++)i[c]=t[c];return a.createElement.apply(null,i)}return a.createElement.apply(null,t)}d.displayName="MDXCreateElement"},207:function(e,n,t){"use strict";t.r(n),t.d(n,{frontMatter:function(){return i},metadata:function(){return s},toc:function(){return u},default:function(){return p}});var a=t(2122),r=t(9756),o=(t(7294),t(3905)),i={},s={unversionedId:"dependency-injection",id:"dependency-injection",isDocsHomePage:!1,title:"Inyecci\xf3n de dependencias",description:"Con el modulo Get puede facilmente injectar sus dependencias como un singleton, lazy singleton o un factory.",source:"@site/i18n/es/docusaurus-plugin-content-docs/current/dependency-injection.md",sourceDirName:".",slug:"/dependency-injection",permalink:"/es/docs/dependency-injection",editUrl:"https://github.com/darwin-morocho/flutter-meedu/edit/master/website/i18n/es/docusaurus-plugin-content-docs/current",version:"current",lastUpdatedBy:"Darwin",lastUpdatedAt:1645821380,formattedLastUpdatedAt:"25/2/2022",frontMatter:{},sidebar:"mySidebar",previous:{title:"Testing",permalink:"/es/docs/state-management/testing"},next:{title:"Programaci\xf3n Reactiva",permalink:"/es/docs/reactive-programming"}},u=[{value:"Singletons",id:"singletons",children:[]},{value:"Auto remove",id:"auto-remove",children:[]},{value:"Escuchando cuando un singleton es removido",id:"escuchando-cuando-un-singleton-es-removido",children:[]},{value:"Factory",id:"factory",children:[]},{value:"Testing",id:"testing",children:[]}],c={toc:u};function p(e){var n=e.components,t=(0,r.Z)(e,["components"]);return(0,o.kt)("wrapper",(0,a.Z)({},c,t,{components:n,mdxType:"MDXLayout"}),(0,o.kt)("p",null,"Con el modulo ",(0,o.kt)("inlineCode",{parentName:"p"},"Get")," puede facilmente injectar sus dependencias como un singleton, lazy singleton o un factory."),(0,o.kt)("h2",{id:"singletons"},"Singletons"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:flutter_meedu/meedu.dart';\n\n// inyecta la dependencia como un singleton\n// pero esta es creada y almacenada en memoria inmediatamente\nGet.put<AuthRepository>(AuthRepositoryImpl());\n\n// inyecta la dependencia como un singleton pero solo sera creada\n// en el momento de la llamada a Get.find<AuthRepository>()\nGet.lazyPut<AuthRepository>(() => AuthRepositoryImpl());\n\n// En cualquier parte de su codigo puede recupar su dependencia\n// usando\nGet.find<AuthRepository>();\n// o\nfinal AuthRepository auth = Get.find();\n\n\n// use este metodo para eliminar su dependencia\nGet.remove<AuthRepository>();\n")),(0,o.kt)("h2",{id:"auto-remove"},"Auto remove"),(0,o.kt)("p",null,"Primero asegurese de agregar el observer de flutter_meedu en su MaterialApp o en sus navigator. ",(0,o.kt)("a",{parentName:"p",href:"/docs/state-management/intro#how-it-works"},"M\xe1s info."),"."),(0,o.kt)("p",null,"Ahora cuando llame a ",(0,o.kt)("inlineCode",{parentName:"p"},"Get.put")," o ",(0,o.kt)("inlineCode",{parentName:"p"},"Get.lazyPut")," puede usar el par\xe1metro ",(0,o.kt)("inlineCode",{parentName:"p"},"autoRemove")," y de esta manera cuando la ruta que creo su singleton sea eliminada del Stack su dependencia tambi\xe9n ser\xe1 removido del modulo ",(0,o.kt)("inlineCode",{parentName:"p"},"Get"),"."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"Get.lazyPut<AuthRepository>(\n  () => AuthRepositoryImpl(),\n  autoRemove: true,\n);\n")),(0,o.kt)("h2",{id:"escuchando-cuando-un-singleton-es-removido"},"Escuchando cuando un singleton es removido"),(0,o.kt)("p",null,"Puede usar el par\xe1metro ",(0,o.kt)("inlineCode",{parentName:"p"},"onRemove")," para definir un callback que sera llamado cuando su singleton sea removido."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"Get.lazyPut<AuthRepository>(\n  () => AuthRepositoryImpl(),\n  onRemove: (authRepository) {\n      /// YOUR CODE HERE\n    authRepository.dispose();\n  }\n);\n")),(0,o.kt)("h2",{id:"factory"},"Factory"),(0,o.kt)("p",null,"Si desea recuperar una nueva instancia en lugar de un singleton use el m\xe9todo ",(0,o.kt)("inlineCode",{parentName:"p"},"factoryPut")),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"class AuthRepository {\n  final String apiHost;\n  Person([this.apiHost = 'https://dev.api.com']);\n}\n\n// register a factory\nGet.factoryPut<AuthRepository, void>((_) => AuthRepository());\n\n// get a new instance of AuthRepository\nfinal repository = Get.factoryFind<AuthRepository, void>();\n")),(0,o.kt)("div",{className:"admonition admonition-success alert alert--success"},(0,o.kt)("div",{parentName:"div",className:"admonition-heading"},(0,o.kt)("h5",{parentName:"div"},(0,o.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,o.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"12",height:"16",viewBox:"0 0 12 16"},(0,o.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.5 0C3.48 0 1 2.19 1 5c0 .92.55 2.25 1 3 1.34 2.25 1.78 2.78 2 4v1h5v-1c.22-1.22.66-1.75 2-4 .45-.75 1-2.08 1-3 0-2.81-2.48-5-5.5-5zm3.64 7.48c-.25.44-.47.8-.67 1.11-.86 1.41-1.25 2.06-1.45 3.23-.02.05-.02.11-.02.17H5c0-.06 0-.13-.02-.17-.2-1.17-.59-1.83-1.45-3.23-.2-.31-.42-.67-.67-1.11C2.44 6.78 2 5.65 2 5c0-2.2 2.02-4 4.5-4 1.22 0 2.36.42 3.22 1.19C10.55 2.94 11 3.94 11 5c0 .66-.44 1.78-.86 2.48zM4 14h5c-.23 1.14-1.3 2-2.5 2s-2.27-.86-2.5-2z"}))),"NOTE")),(0,o.kt)("div",{parentName:"div",className:"admonition-content"},(0,o.kt)("p",{parentName:"div"},"Si queremos pasar un argumento a nuestro ",(0,o.kt)("strong",{parentName:"p"},"AuthRepository")),(0,o.kt)("pre",{parentName:"div"},(0,o.kt)("code",{parentName:"pre",className:"language-dart"},'Get.factoryPut<AuthRepository, String>(\n    (String? arguments) => AuthRepository(arguments!),\n);\n\n// get a new instance of AuthRepository with a initial value\nfinal testRepo = Get.factoryFind<AuthRepository, String>(\n  arguments:"https://test.api.com",\n);\nfinal liveRepo = Get.factoryFind<AuthRepository, String>(\n  arguments:"https://live.api.com",\n);\n')))),(0,o.kt)("h2",{id:"testing"},"Testing"),(0,o.kt)("p",null,"Para evitar conflictos con las dependencias inyectadas use el m\xe9todo ",(0,o.kt)("inlineCode",{parentName:"p"},"clear")," en un ",(0,o.kt)("inlineCode",{parentName:"p"},"setUp")," o un ",(0,o.kt)("inlineCode",{parentName:"p"},"tearDown")," antes o despues de cada test."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"setUp((){\n Get.i.clear(); // remove all dependencies\n});\n")))}p.isMDXComponent=!0}}]);