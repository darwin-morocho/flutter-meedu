(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[714],{3905:function(e,t,n){"use strict";n.d(t,{Zo:function(){return s},kt:function(){return y}});var r=n(7294);function o(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function i(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,r)}return n}function a(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?i(Object(n),!0).forEach((function(t){o(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):i(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function c(e,t){if(null==e)return{};var n,r,o=function(e,t){if(null==e)return{};var n,r,o={},i=Object.keys(e);for(r=0;r<i.length;r++)n=i[r],t.indexOf(n)>=0||(o[n]=e[n]);return o}(e,t);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(r=0;r<i.length;r++)n=i[r],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(o[n]=e[n])}return o}var p=r.createContext({}),u=function(e){var t=r.useContext(p),n=t;return e&&(n="function"==typeof e?e(t):a(a({},t),e)),n},s=function(e){var t=u(e.components);return r.createElement(p.Provider,{value:t},e.children)},l={inlineCode:"code",wrapper:function(e){var t=e.children;return r.createElement(r.Fragment,{},t)}},d=r.forwardRef((function(e,t){var n=e.components,o=e.mdxType,i=e.originalType,p=e.parentName,s=c(e,["components","mdxType","originalType","parentName"]),d=u(n),y=o,m=d["".concat(p,".").concat(y)]||d[y]||l[y]||i;return n?r.createElement(m,a(a({ref:t},s),{},{components:n})):r.createElement(m,a({ref:t},s))}));function y(e,t){var n=arguments,o=t&&t.mdxType;if("string"==typeof e||o){var i=n.length,a=new Array(i);a[0]=d;var c={};for(var p in t)hasOwnProperty.call(t,p)&&(c[p]=t[p]);c.originalType=e,c.mdxType="string"==typeof e?e:o,a[1]=c;for(var u=2;u<i;u++)a[u]=n[u];return r.createElement.apply(null,a)}return r.createElement.apply(null,n)}d.displayName="MDXCreateElement"},6692:function(e,t,n){"use strict";n.r(t),n.d(t,{frontMatter:function(){return a},metadata:function(){return c},toc:function(){return p},default:function(){return s}});var r=n(2122),o=n(9756),i=(n(7294),n(3905)),a={sidebar_position:9},c={unversionedId:"dependency-injection",id:"dependency-injection",isDocsHomePage:!1,title:"Dependency Injection",description:"With the Get module you can easy inject your dependencies as a singleton, lazy singleton or as a factory.",source:"@site/docs/dependency-injection.md",sourceDirName:".",slug:"/dependency-injection",permalink:"/docs/dependency-injection",editUrl:"https://github.com/darwin-morocho/flutter-meedu/edit/master/website/docs/dependency-injection.md",version:"current",sidebarPosition:9,frontMatter:{sidebar_position:9},sidebar:"tutorialSidebar",previous:{title:"Testing",permalink:"/docs/testing"},next:{title:"Reactive programming",permalink:"/docs/reactive-programming"}},p=[{value:"Testing",id:"testing",children:[]}],u={toc:p};function s(e){var t=e.components,n=(0,o.Z)(e,["components"]);return(0,i.kt)("wrapper",(0,r.Z)({},u,n,{components:t,mdxType:"MDXLayout"}),(0,i.kt)("p",null,"With the ",(0,i.kt)("inlineCode",{parentName:"p"},"Get")," module you can easy inject your dependencies as a singleton, lazy singleton or as a factory."),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:flutter_meedu/meedu.dart';\n\n// inject the dependency as a singleton\nGet.i.put<AuthRepository>(new AuthRepositoryImpl());\n\n\n// whenever part of your code you can get the dependency\nGet.i.find<AuthRepository>();\n\n\n// remove the dependency\nGet.i.remove<AuthRepository>();\n\n\n// use a lazy put to inject the dependency as a singleton\n// but it only will be created until Get.i.find<AuthRepository>() is called\nGet.i.lazyPut<AuthRepository>(()=>new AuthRepositoryImpl());\n\n\n// creates a new instance of AuthRepositoryImpl \n// every time that Get.i.find<AuthRepository>() is called\nGet.i.factoryPut<AuthRepository>(()=>new AuthRepositoryImpl());\n")),(0,i.kt)("h2",{id:"testing"},"Testing"),(0,i.kt)("p",null,"To avoid conflics with dependencies injected in the Get module you can clear the dependencies using a ",(0,i.kt)("inlineCode",{parentName:"p"},"setUp")," or a ",(0,i.kt)("inlineCode",{parentName:"p"},"tearDown"),"  before or after each test."),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-dart"},"setUp((){\n Get.i.clear(); // remove all dependencies\n});\n")))}s.isMDXComponent=!0}}]);