(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[3536],{3905:function(e,r,t){"use strict";t.d(r,{Zo:function(){return p},kt:function(){return m}});var n=t(7294);function o(e,r,t){return r in e?Object.defineProperty(e,r,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[r]=t,e}function i(e,r){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(e);r&&(n=n.filter((function(r){return Object.getOwnPropertyDescriptor(e,r).enumerable}))),t.push.apply(t,n)}return t}function a(e){for(var r=1;r<arguments.length;r++){var t=null!=arguments[r]?arguments[r]:{};r%2?i(Object(t),!0).forEach((function(r){o(e,r,t[r])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):i(Object(t)).forEach((function(r){Object.defineProperty(e,r,Object.getOwnPropertyDescriptor(t,r))}))}return e}function l(e,r){if(null==e)return{};var t,n,o=function(e,r){if(null==e)return{};var t,n,o={},i=Object.keys(e);for(n=0;n<i.length;n++)t=i[n],r.indexOf(t)>=0||(o[t]=e[t]);return o}(e,r);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(n=0;n<i.length;n++)t=i[n],r.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(o[t]=e[t])}return o}var c=n.createContext({}),s=function(e){var r=n.useContext(c),t=r;return e&&(t="function"==typeof e?e(r):a(a({},r),e)),t},p=function(e){var r=s(e.components);return n.createElement(c.Provider,{value:r},e.children)},d={inlineCode:"code",wrapper:function(e){var r=e.children;return n.createElement(n.Fragment,{},r)}},u=n.forwardRef((function(e,r){var t=e.components,o=e.mdxType,i=e.originalType,c=e.parentName,p=l(e,["components","mdxType","originalType","parentName"]),u=s(t),m=o,f=u["".concat(c,".").concat(m)]||u[m]||d[m]||i;return t?n.createElement(f,a(a({ref:r},p),{},{components:t})):n.createElement(f,a({ref:r},p))}));function m(e,r){var t=arguments,o=r&&r.mdxType;if("string"==typeof e||o){var i=t.length,a=new Array(i);a[0]=u;var l={};for(var c in r)hasOwnProperty.call(r,c)&&(l[c]=r[c]);l.originalType=e,l.mdxType="string"==typeof e?e:o,a[1]=l;for(var s=2;s<i;s++)a[s]=t[s];return n.createElement.apply(null,a)}return n.createElement.apply(null,t)}u.displayName="MDXCreateElement"},2968:function(e,r,t){"use strict";t.r(r),t.d(r,{frontMatter:function(){return a},metadata:function(){return l},toc:function(){return c},default:function(){return p}});var n=t(2122),o=t(9756),i=(t(7294),t(3905)),a={sidebar_position:8},l={unversionedId:"state-managment/testing",id:"version-3.x.x/state-managment/testing",isDocsHomePage:!1,title:"Testing",description:"Overriding providers",source:"@site/versioned_docs/version-3.x.x/state-managment/testing.md",sourceDirName:"state-managment",slug:"/state-managment/testing",permalink:"/es/docs/3.x.x/state-managment/testing",editUrl:"https://github.com/darwin-morocho/flutter-meedu/edit/master/website/i18n/es/docusaurus-plugin-content-docs/current",version:"3.x.x",lastUpdatedBy:"Darwin Morocho",lastUpdatedAt:1624736668,formattedLastUpdatedAt:"26/6/2021",sidebarPosition:8,frontMatter:{sidebar_position:8},sidebar:"version-3.x.x/mySidebar",previous:{title:"Listen when a provider has disposed a Notifier",permalink:"/es/docs/3.x.x/state-managment/listen-when-a-provider-dispose-a-notifier"},next:{title:"Dependency Injection",permalink:"/es/docs/3.x.x/dependency-injection"}},c=[{value:"Overriding providers",id:"overriding-providers",children:[]},{value:"Cleaning your providers",id:"cleaning-your-providers",children:[]}],s={toc:c};function p(e){var r=e.components,t=(0,o.Z)(e,["components"]);return(0,i.kt)("wrapper",(0,n.Z)({},s,t,{components:r,mdxType:"MDXLayout"}),(0,i.kt)("h2",{id:"overriding-providers"},"Overriding providers"),(0,i.kt)("p",null,"Consider the next provider"),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-dart"},"final loginProvider = StateProvider<LoginController, LoginState>(\n  (_) => LoginController(),\n);\n")),(0,i.kt)("p",null,"So, maybe in one test you need mock the LoginController behavior then you can use the ",(0,i.kt)("inlineCode",{parentName:"p"},"overrideProvider")," method."),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:mocktail/mocktail.dart';\n\nfinal loginProvider = StateProvider<LoginController, LoginState>(\n  (_) => LoginController(),\n);\n\nclass MockLoginController extends Mock implements LoginController {}\n")),(0,i.kt)("p",null,"Next before your test you can use the ",(0,i.kt)("inlineCode",{parentName:"p"},"setUp")," method."),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-dart"},"setUp((){\n  loginProvider.overrideProvider(\n    (_) => MockLoginController(),\n  );\n});\n")),(0,i.kt)("h2",{id:"cleaning-your-providers"},"Cleaning your providers"),(0,i.kt)("p",null,"Before or after each test you will need the default state of all SimpleNotifier or StateNotifier. So you can use ",(0,i.kt)("inlineCode",{parentName:"p"},"ProviderScope.clear();")," to clear all provider saved in the ProviderScope."),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-dart"},"setUp((){\n  ProviderScope.clear();\n});\n\nor \n\n\ntearDown((){\n  ProviderScope.clear();\n});\n")))}p.isMDXComponent=!0}}]);