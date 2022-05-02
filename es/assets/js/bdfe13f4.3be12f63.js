(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[3116],{3905:function(e,t,n){"use strict";n.d(t,{Zo:function(){return c},kt:function(){return m}});var o=n(7294);function r(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function a(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);t&&(o=o.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,o)}return n}function i(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?a(Object(n),!0).forEach((function(t){r(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):a(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function s(e,t){if(null==e)return{};var n,o,r=function(e,t){if(null==e)return{};var n,o,r={},a=Object.keys(e);for(o=0;o<a.length;o++)n=a[o],t.indexOf(n)>=0||(r[n]=e[n]);return r}(e,t);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);for(o=0;o<a.length;o++)n=a[o],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(r[n]=e[n])}return r}var p=o.createContext({}),l=function(e){var t=o.useContext(p),n=t;return e&&(n="function"==typeof e?e(t):i(i({},t),e)),n},c=function(e){var t=l(e.components);return o.createElement(p.Provider,{value:t},e.children)},u={inlineCode:"code",wrapper:function(e){var t=e.children;return o.createElement(o.Fragment,{},t)}},d=o.forwardRef((function(e,t){var n=e.components,r=e.mdxType,a=e.originalType,p=e.parentName,c=s(e,["components","mdxType","originalType","parentName"]),d=l(n),m=r,y=d["".concat(p,".").concat(m)]||d[m]||u[m]||a;return n?o.createElement(y,i(i({ref:t},c),{},{components:n})):o.createElement(y,i({ref:t},c))}));function m(e,t){var n=arguments,r=t&&t.mdxType;if("string"==typeof e||r){var a=n.length,i=new Array(a);i[0]=d;var s={};for(var p in t)hasOwnProperty.call(t,p)&&(s[p]=t[p]);s.originalType=e,s.mdxType="string"==typeof e?e:r,i[1]=s;for(var l=2;l<a;l++)i[l]=n[l];return o.createElement.apply(null,i)}return o.createElement.apply(null,n)}d.displayName="MDXCreateElement"},1367:function(e,t,n){"use strict";n.r(t),n.d(t,{frontMatter:function(){return i},metadata:function(){return s},toc:function(){return p},default:function(){return c}});var o=n(2122),r=n(9756),a=(n(7294),n(3905)),i={},s={unversionedId:"dependency-injection",id:"version-6.x.x/dependency-injection",isDocsHomePage:!1,title:"Dependency Injection",description:"With the Get module you can easy inject your dependencies as a singleton, lazy singleton or as a factory.",source:"@site/versioned_docs/version-6.x.x/dependency-injection.md",sourceDirName:".",slug:"/dependency-injection",permalink:"/es/docs/6.x.x/dependency-injection",editUrl:"https://github.com/darwin-morocho/flutter-meedu/edit/master/website/i18n/es/docusaurus-plugin-content-docs/current",version:"6.x.x",lastUpdatedBy:"Darwin",lastUpdatedAt:1651503966,formattedLastUpdatedAt:"2/5/2022",frontMatter:{},sidebar:"version-6.x.x/mySidebar",previous:{title:"Testing",permalink:"/es/docs/6.x.x/state-management/testing"},next:{title:"Persistent state",permalink:"/es/docs/6.x.x/persistent-state"}},p=[{value:"Singletons",id:"singletons",children:[]},{value:"Auto remove",id:"auto-remove",children:[]},{value:"Listen when a singleton was removed",id:"listen-when-a-singleton-was-removed",children:[]},{value:"Factory",id:"factory",children:[]},{value:"Testing",id:"testing",children:[]}],l={toc:p};function c(e){var t=e.components,n=(0,r.Z)(e,["components"]);return(0,a.kt)("wrapper",(0,o.Z)({},l,n,{components:t,mdxType:"MDXLayout"}),(0,a.kt)("p",null,"With the ",(0,a.kt)("inlineCode",{parentName:"p"},"Get")," module you can easy inject your dependencies as a singleton, lazy singleton or as a factory."),(0,a.kt)("h2",{id:"singletons"},"Singletons"),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart"},"import 'package:flutter_meedu/meedu.dart';\n\n// inject the dependency as a singleton\nGet.put<AuthRepository>(AuthRepositoryImpl());\n\n// for lazy singletons use lazyPut\nGet.lazyPut<AuthRepository>(\n  () => AuthRepositoryImpl(),\n);\n\n// whenever part of your code you can get the dependency using\nGet.find<AuthRepository>();\n// or\nfinal AuthRepository auth = Get.find();\n\n// remove the dependency\nGet.remove<AuthRepository>();\n\n")),(0,a.kt)("h2",{id:"auto-remove"},"Auto remove"),(0,a.kt)("p",null,"First make sure that you have added the meedu observer in your navigator observers ",(0,a.kt)("a",{parentName:"p",href:"/docs/state-management/intro#how-it-works"},"more info"),"."),(0,a.kt)("p",null,"Now when tou call to ",(0,a.kt)("inlineCode",{parentName:"p"},"Get.put")," or ",(0,a.kt)("inlineCode",{parentName:"p"},"Get.lazyPut")," you can use the ",(0,a.kt)("inlineCode",{parentName:"p"},"autoRemove")," parameter and set the value to ",(0,a.kt)("inlineCode",{parentName:"p"},"true")," then when the router who created the dependency\nis popped the dependency will be deleted from memory."),(0,a.kt)("h2",{id:"listen-when-a-singleton-was-removed"},"Listen when a singleton was removed"),(0,a.kt)("p",null,"You can use the ",(0,a.kt)("inlineCode",{parentName:"p"},"onRemove")," to define a callback to listen when a dependency has been deleted from memory, so when you call to ",(0,a.kt)("inlineCode",{parentName:"p"},"Get.remove")," or when you called to ",(0,a.kt)("inlineCode",{parentName:"p"},"Get.put")," or ",(0,a.kt)("inlineCode",{parentName:"p"},"Get.lazyPut")," using ",(0,a.kt)("inlineCode",{parentName:"p"},"autoRemove")," equals to ",(0,a.kt)("inlineCode",{parentName:"p"},"true")," the onRemove callback will be called."),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart"},"Get.lazyPut<AuthRepository>(\n  () => new AuthRepositoryImpl(),\n  onRemove: (authRepository) {\n      /// YOUR CODE HERE\n    authRepository.dispose();\n  }\n);\n")),(0,a.kt)("h2",{id:"factory"},"Factory"),(0,a.kt)("p",null,"If you want to get a new instance every time you call find in that case you could use ",(0,a.kt)("inlineCode",{parentName:"p"},"factoryPut")),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart"},"class AuthRepository {\n  final String apiHost;\n  Person([this.apiHost = 'https://dev.api.com']);\n}\n\n// register a factory\nGet.factoryPut<AuthRepository, void>((_) => AuthRepository());\n\n// get a new instance of AuthRepository\nfinal repository = Get.factoryFind<AuthRepository, void>();\n")),(0,a.kt)("div",{className:"admonition admonition-success alert alert--success"},(0,a.kt)("div",{parentName:"div",className:"admonition-heading"},(0,a.kt)("h5",{parentName:"div"},(0,a.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,a.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"12",height:"16",viewBox:"0 0 12 16"},(0,a.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.5 0C3.48 0 1 2.19 1 5c0 .92.55 2.25 1 3 1.34 2.25 1.78 2.78 2 4v1h5v-1c.22-1.22.66-1.75 2-4 .45-.75 1-2.08 1-3 0-2.81-2.48-5-5.5-5zm3.64 7.48c-.25.44-.47.8-.67 1.11-.86 1.41-1.25 2.06-1.45 3.23-.02.05-.02.11-.02.17H5c0-.06 0-.13-.02-.17-.2-1.17-.59-1.83-1.45-3.23-.2-.31-.42-.67-.67-1.11C2.44 6.78 2 5.65 2 5c0-2.2 2.02-4 4.5-4 1.22 0 2.36.42 3.22 1.19C10.55 2.94 11 3.94 11 5c0 .66-.44 1.78-.86 2.48zM4 14h5c-.23 1.14-1.3 2-2.5 2s-2.27-.86-2.5-2z"}))),"NOTE")),(0,a.kt)("div",{parentName:"div",className:"admonition-content"},(0,a.kt)("p",{parentName:"div"},"If you want pass an initial value to ",(0,a.kt)("strong",{parentName:"p"},"AuthRepository")),(0,a.kt)("pre",{parentName:"div"},(0,a.kt)("code",{parentName:"pre",className:"language-dart"},'Get.factoryPut<AuthRepository, String>(\n    (String? arguments) => AuthRepository(arguments!),\n);\n\n// get a new instance of AuthRepository with a initial value\nfinal testRepo = Get.factoryFind<AuthRepository, String>(\n  arguments:"https://test.api.com",\n);\nfinal liveRepo = Get.factoryFind<AuthRepository, String>(\n  arguments:"https://live.api.com",\n);\n')))),(0,a.kt)("h2",{id:"testing"},"Testing"),(0,a.kt)("p",null,"To avoid conflics with dependencies injected in the Get module you can clear the dependencies using a ",(0,a.kt)("inlineCode",{parentName:"p"},"setUp")," or a ",(0,a.kt)("inlineCode",{parentName:"p"},"tearDown")," before or after each test."),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart"},"setUp((){\n Get.clear(); // remove all dependencies\n});\n")))}c.isMDXComponent=!0}}]);