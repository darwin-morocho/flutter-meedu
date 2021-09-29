(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[9671],{3905:function(e,t,n){"use strict";n.d(t,{Zo:function(){return c},kt:function(){return u}});var a=n(7294);function r(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function i(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);t&&(a=a.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,a)}return n}function o(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?i(Object(n),!0).forEach((function(t){r(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):i(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function s(e,t){if(null==e)return{};var n,a,r=function(e,t){if(null==e)return{};var n,a,r={},i=Object.keys(e);for(a=0;a<i.length;a++)n=i[a],t.indexOf(n)>=0||(r[n]=e[n]);return r}(e,t);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(a=0;a<i.length;a++)n=i[a],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(r[n]=e[n])}return r}var p=a.createContext({}),l=function(e){var t=a.useContext(p),n=t;return e&&(n="function"==typeof e?e(t):o(o({},t),e)),n},c=function(e){var t=l(e.components);return a.createElement(p.Provider,{value:t},e.children)},m={inlineCode:"code",wrapper:function(e){var t=e.children;return a.createElement(a.Fragment,{},t)}},d=a.forwardRef((function(e,t){var n=e.components,r=e.mdxType,i=e.originalType,p=e.parentName,c=s(e,["components","mdxType","originalType","parentName"]),d=l(n),u=r,g=d["".concat(p,".").concat(u)]||d[u]||m[u]||i;return n?a.createElement(g,o(o({ref:t},c),{},{components:n})):a.createElement(g,o({ref:t},c))}));function u(e,t){var n=arguments,r=t&&t.mdxType;if("string"==typeof e||r){var i=n.length,o=new Array(i);o[0]=d;var s={};for(var p in t)hasOwnProperty.call(t,p)&&(s[p]=t[p]);s.originalType=e,s.mdxType="string"==typeof e?e:r,o[1]=s;for(var l=2;l<i;l++)o[l]=n[l];return a.createElement.apply(null,o)}return a.createElement.apply(null,n)}d.displayName="MDXCreateElement"},426:function(e,t,n){"use strict";n.r(t),n.d(t,{frontMatter:function(){return o},metadata:function(){return s},toc:function(){return p},default:function(){return c}});var a=n(2122),r=n(9756),i=(n(7294),n(3905)),o={sidebar_position:1},s={unversionedId:"intro",id:"intro",isDocsHomePage:!1,title:"What is flutter_meedu?",description:"Is a powerful State Managment, Dependency Injection, Reactive programming and Navigation for Flutter apps.",source:"@site/docs/intro.md",sourceDirName:".",slug:"/intro",permalink:"/docs/5.x.x/intro",editUrl:"https://github.com/darwin-morocho/flutter-meedu/edit/master/website/docs/intro.md",version:"current",sidebarPosition:1,frontMatter:{sidebar_position:1},sidebar:"mySidebar",next:{title:"Configuration",permalink:"/docs/5.x.x/state-managment/intro"}},p=[{value:"Features",id:"features",children:[]},{value:"Install",id:"install",children:[]}],l={toc:p};function c(e){var t=e.components,n=(0,r.Z)(e,["components"]);return(0,i.kt)("wrapper",(0,a.Z)({},l,n,{components:t,mdxType:"MDXLayout"}),(0,i.kt)("p",null,"Is a ",(0,i.kt)("strong",{parentName:"p"},"powerful")," State Managment, Dependency Injection, Reactive programming and Navigation for Flutter apps."),(0,i.kt)("p",{align:"center"},(0,i.kt)("a",{href:"https://pub.dev/packages/flutter_meedu"},(0,i.kt)("img",{alt:"pub version",src:"https://img.shields.io/pub/v/flutter_meedu?include_prereleases&label=flutter_meedu"})),(0,i.kt)("img",{style:{marginLeft:10},alt:"last commit",src:"https://img.shields.io/github/last-commit/darwin-morocho/flutter-meedu"}),(0,i.kt)("a",{style:{marginLeft:10},href:"https://codecov.io/gh/darwin-morocho/flutter-meedu"},(0,i.kt)("img",{src:"https://codecov.io/gh/darwin-morocho/flutter-meedu/branch/master/graph/badge.svg?token=VM29N1NHWJ"})),(0,i.kt)("a",{style:{marginLeft:10},href:"https://discord.gg/rV4bPsdefj"},(0,i.kt)("img",{src:"https://img.shields.io/static/v1?label=Discord&message=Server&color=1565c0"})),(0,i.kt)("img",{style:{marginLeft:10},alt:"license",src:"https://img.shields.io/github/license/darwin-morocho/flutter-meedu"}),(0,i.kt)("img",{style:{marginLeft:10},alt:"stars",src:"https://img.shields.io/github/stars/darwin-morocho/flutter-meedu?style=social"})),(0,i.kt)("div",{className:"admonition admonition-note alert alert--secondary"},(0,i.kt)("div",{parentName:"div",className:"admonition-heading"},(0,i.kt)("h5",{parentName:"div"},(0,i.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,i.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,i.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.3 5.69a.942.942 0 0 1-.28-.7c0-.28.09-.52.28-.7.19-.18.42-.28.7-.28.28 0 .52.09.7.28.18.19.28.42.28.7 0 .28-.09.52-.28.7a1 1 0 0 1-.7.3c-.28 0-.52-.11-.7-.3zM8 7.99c-.02-.25-.11-.48-.31-.69-.2-.19-.42-.3-.69-.31H6c-.27.02-.48.13-.69.31-.2.2-.3.44-.31.69h1v3c.02.27.11.5.31.69.2.2.42.31.69.31h1c.27 0 .48-.11.69-.31.2-.19.3-.42.31-.69H8V7.98v.01zM7 2.3c-3.14 0-5.7 2.54-5.7 5.68 0 3.14 2.56 5.7 5.7 5.7s5.7-2.55 5.7-5.7c0-3.15-2.56-5.69-5.7-5.69v.01zM7 .98c3.86 0 7 3.14 7 7s-3.14 7-7 7-7-3.12-7-7 3.14-7 7-7z"}))),"INFO")),(0,i.kt)("div",{parentName:"div",className:"admonition-content"},(0,i.kt)("p",{parentName:"div"},"This project was inspired by ",(0,i.kt)("strong",{parentName:"p"},"GetX, riverpod")," and ",(0,i.kt)("strong",{parentName:"p"},"flutter_bloc"),". We don't use any code of these projects only get the best fetaures\nof them and we have implemented them with a total refactoring."))),(0,i.kt)("div",{className:"admonition admonition-info alert alert--info"},(0,i.kt)("div",{parentName:"div",className:"admonition-heading"},(0,i.kt)("h5",{parentName:"div"},(0,i.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,i.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,i.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M7 2.3c3.14 0 5.7 2.56 5.7 5.7s-2.56 5.7-5.7 5.7A5.71 5.71 0 0 1 1.3 8c0-3.14 2.56-5.7 5.7-5.7zM7 1C3.14 1 0 4.14 0 8s3.14 7 7 7 7-3.14 7-7-3.14-7-7-7zm1 3H6v5h2V4zm0 6H6v2h2v-2z"}))),"INFO")),(0,i.kt)("div",{parentName:"div",className:"admonition-content"},(0,i.kt)("p",{parentName:"div"},"You can join to the discord server ",(0,i.kt)("a",{parentName:"p",href:"https://discord.gg/rV4bPsdefj"},"here")))),(0,i.kt)("h2",{id:"features"},"Features"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("p",{parentName:"li"},"A State Management for simple and complex states."),(0,i.kt)("p",{parentName:"li"},"flutter_meedu helps you to manage the state of your flutter app without boilerplate, code generators or InheritedWidget.")),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("p",{parentName:"li"},"Navigate without BuildContext."),(0,i.kt)("p",{parentName:"li"},"Navigate to your app without a custom Page class, a custom MaterialApp.")),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("p",{parentName:"li"},"Simple dependecy injection.")),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("p",{parentName:"li"},"Reactive programming.")),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("p",{parentName:"li"},"Easy to test."))),(0,i.kt)("h2",{id:"install"},"Install"),(0,i.kt)("p",null,"Add the following to your ",(0,i.kt)("inlineCode",{parentName:"p"},"pubspec.yaml")),(0,i.kt)("pre",null,(0,i.kt)("code",{parentName:"pre",className:"language-yaml"},'environment:\n  sdk: ">=2.13.0 <3.0.0"\n  flutter: ">=2.0.0"\n\ndependencies:\n  flutter_meedu: "^5.1.0"\n')),(0,i.kt)("div",{className:"admonition admonition-note alert alert--secondary"},(0,i.kt)("div",{parentName:"div",className:"admonition-heading"},(0,i.kt)("h5",{parentName:"div"},(0,i.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,i.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,i.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.3 5.69a.942.942 0 0 1-.28-.7c0-.28.09-.52.28-.7.19-.18.42-.28.7-.28.28 0 .52.09.7.28.18.19.28.42.28.7 0 .28-.09.52-.28.7a1 1 0 0 1-.7.3c-.28 0-.52-.11-.7-.3zM8 7.99c-.02-.25-.11-.48-.31-.69-.2-.19-.42-.3-.69-.31H6c-.27.02-.48.13-.69.31-.2.2-.3.44-.31.69h1v3c.02.27.11.5.31.69.2.2.42.31.69.31h1c.27 0 .48-.11.69-.31.2-.19.3-.42.31-.69H8V7.98v.01zM7 2.3c-3.14 0-5.7 2.54-5.7 5.68 0 3.14 2.56 5.7 5.7 5.7s5.7-2.55 5.7-5.7c0-3.15-2.56-5.69-5.7-5.69v.01zM7 .98c3.86 0 7 3.14 7 7s-3.14 7-7 7-7-3.12-7-7 3.14-7 7-7z"}))),"note")),(0,i.kt)("div",{parentName:"div",className:"admonition-content"},(0,i.kt)("p",{parentName:"div"},(0,i.kt)("strong",{parentName:"p"},"Spanish course with unit testing and widget testing")),(0,i.kt)("p",{parentName:"div"},"You can find a complete video course (",(0,i.kt)("strong",{parentName:"p"},"Spanish"),") about how to use ",(0,i.kt)("strong",{parentName:"p"},"flutter_meedu")," ",(0,i.kt)("a",{parentName:"p",href:"https://meedu.app/curso/flutter-gestion-de-estados-con-meedu"},"here")))))}c.isMDXComponent=!0}}]);