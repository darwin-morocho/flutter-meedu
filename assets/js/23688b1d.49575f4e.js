(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[6937],{3905:function(e,t,n){"use strict";n.d(t,{Zo:function(){return l},kt:function(){return f}});var r=n(7294);function o(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function a(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,r)}return n}function s(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?a(Object(n),!0).forEach((function(t){o(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):a(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function u(e,t){if(null==e)return{};var n,r,o=function(e,t){if(null==e)return{};var n,r,o={},a=Object.keys(e);for(r=0;r<a.length;r++)n=a[r],t.indexOf(n)>=0||(o[n]=e[n]);return o}(e,t);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);for(r=0;r<a.length;r++)n=a[r],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(o[n]=e[n])}return o}var i=r.createContext({}),c=function(e){var t=r.useContext(i),n=t;return e&&(n="function"==typeof e?e(t):s(s({},t),e)),n},l=function(e){var t=c(e.components);return r.createElement(i.Provider,{value:t},e.children)},p={inlineCode:"code",wrapper:function(e){var t=e.children;return r.createElement(r.Fragment,{},t)}},d=r.forwardRef((function(e,t){var n=e.components,o=e.mdxType,a=e.originalType,i=e.parentName,l=u(e,["components","mdxType","originalType","parentName"]),d=c(n),f=o,m=d["".concat(i,".").concat(f)]||d[f]||p[f]||a;return n?r.createElement(m,s(s({ref:t},l),{},{components:n})):r.createElement(m,s({ref:t},l))}));function f(e,t){var n=arguments,o=t&&t.mdxType;if("string"==typeof e||o){var a=n.length,s=new Array(a);s[0]=d;var u={};for(var i in t)hasOwnProperty.call(t,i)&&(u[i]=t[i]);u.originalType=e,u.mdxType="string"==typeof e?e:o,s[1]=u;for(var c=2;c<a;c++)s[c]=n[c];return r.createElement.apply(null,s)}return r.createElement.apply(null,n)}d.displayName="MDXCreateElement"},2204:function(e,t,n){"use strict";n.r(t),n.d(t,{frontMatter:function(){return s},metadata:function(){return u},toc:function(){return i},default:function(){return l}});var r=n(2122),o=n(9756),a=(n(7294),n(3905)),s={},u={unversionedId:"hooks",id:"version-8.x.x/hooks",isDocsHomePage:!1,title:"Hooks",description:"If you like flutterhooks the GOOD NEWS is that flutter meedu is compatible with hooks.",source:"@site/versioned_docs/version-8.x.x/hooks.md",sourceDirName:".",slug:"/hooks",permalink:"/docs/8.x.x/hooks",editUrl:"https://github.com/darwin-morocho/flutter-meedu/edit/master/website/versioned_docs/version-8.x.x/hooks.md",version:"8.x.x",lastUpdatedBy:"darwin-morocho",lastUpdatedAt:1697048754,formattedLastUpdatedAt:"10/11/2023",frontMatter:{},sidebar:"version-8.x.x/mySidebar",previous:{title:"Testing",permalink:"/docs/8.x.x/state-management/testing"},next:{title:"Dependency Injection",permalink:"/docs/8.x.x/dependency-injection"}},i=[],c={toc:i};function l(e){var t=e.components,n=(0,o.Z)(e,["components"]);return(0,a.kt)("wrapper",(0,r.Z)({},c,n,{components:t,mdxType:"MDXLayout"}),(0,a.kt)("p",null,"If you like ",(0,a.kt)("a",{parentName:"p",href:"https://pub.dev/packages/flutter_hooks"},"flutter_hooks")," the GOOD NEWS is that flutter meedu is compatible with hooks."),(0,a.kt)("p",null,"First add ",(0,a.kt)("a",{parentName:"p",href:"https://pub.dev/packages/hooks_meedu"},"hooks_meedu")," to your ",(0,a.kt)("inlineCode",{parentName:"p"},"pubspec.yaml")),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-yaml"},"dependencies:\n  hooks_meedu: ^0.0.1\n")),(0,a.kt)("p",null,"Now you can use the ",(0,a.kt)("inlineCode",{parentName:"p"},"HookConsumerWidget")," class to create a widget that can works with hooks and meedu at the same time."),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart"},"class HookConsumerTest extends HookConsumerWidget {\n  const HookConsumerTest({super.key});\n\n  @override\n  Widget build(BuildContext context, BuilderRef ref) {\n    final count = useState(0);\n    final state = ref.watch(myProvider).state;\n\n    return YOUR_WIDGET;\n  }\n}\n")),(0,a.kt)("p",null,"Also you can use the ",(0,a.kt)("inlineCode",{parentName:"p"},"HookConsumer")," widget."),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart"},'HookConsumer(\n  builder: (_, ref, child) {\n    final text = useState("");\n    final state = ref.watch(myProvider).state;\n\n    return YOUR_WIDGE;\n  },\n)\n')),(0,a.kt)("p",null,"If you need to work with a StatefulWidget, hooks and flutter meedu you can use the ",(0,a.kt)("inlineCode",{parentName:"p"},"StatefulHookConsumerWidget")," class."),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-dart"},"class HookStatefulTest extends StatefulHookConsumerWidget {\n  const HookStatefulTest({super.key});\n\n  @override\n  HookStatefulTestState createState() => HookStatefulTestState();\n}\n\nclass HookStatefulTestState extends ConsumerState<HookStatefulTest> {\n  int count = 0;\n\n  @override\n  Widget build(BuildContext context) {\n    final count2 = useState(0);\n    final state = ref.watch(provider).state;\n\n    return GestureDetector(\n      onTap: () {\n        count2.value++;\n        setState(() => count++);\n      },\n      child: OTHER_WIDGET,\n    );\n  }\n}\n")))}l.isMDXComponent=!0}}]);