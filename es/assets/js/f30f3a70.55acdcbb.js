(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[3195],{3905:function(e,n,t){"use strict";t.d(n,{Zo:function(){return u},kt:function(){return m}});var r=t(7294);function i(e,n,t){return n in e?Object.defineProperty(e,n,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[n]=t,e}function o(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);n&&(r=r.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,r)}return t}function a(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?o(Object(t),!0).forEach((function(n){i(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):o(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}function l(e,n){if(null==e)return{};var t,r,i=function(e,n){if(null==e)return{};var t,r,i={},o=Object.keys(e);for(r=0;r<o.length;r++)t=o[r],n.indexOf(t)>=0||(i[t]=e[t]);return i}(e,n);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(r=0;r<o.length;r++)t=o[r],n.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(i[t]=e[t])}return i}var s=r.createContext({}),c=function(e){var n=r.useContext(s),t=n;return e&&(t="function"==typeof e?e(n):a(a({},n),e)),t},u=function(e){var n=c(e.components);return r.createElement(s.Provider,{value:n},e.children)},d={inlineCode:"code",wrapper:function(e){var n=e.children;return r.createElement(r.Fragment,{},n)}},p=r.forwardRef((function(e,n){var t=e.components,i=e.mdxType,o=e.originalType,s=e.parentName,u=l(e,["components","mdxType","originalType","parentName"]),p=c(t),m=i,g=p["".concat(s,".").concat(m)]||p[m]||d[m]||o;return t?r.createElement(g,a(a({ref:n},u),{},{components:t})):r.createElement(g,a({ref:n},u))}));function m(e,n){var t=arguments,i=n&&n.mdxType;if("string"==typeof e||i){var o=t.length,a=new Array(o);a[0]=p;var l={};for(var s in n)hasOwnProperty.call(n,s)&&(l[s]=n[s]);l.originalType=e,l.mdxType="string"==typeof e?e:i,a[1]=l;for(var c=2;c<o;c++)a[c]=t[c];return r.createElement.apply(null,a)}return r.createElement.apply(null,t)}p.displayName="MDXCreateElement"},2981:function(e,n,t){"use strict";t.r(n),t.d(n,{frontMatter:function(){return a},metadata:function(){return l},toc:function(){return s},default:function(){return u}});var r=t(2122),i=t(9756),o=(t(7294),t(3905)),a={sidebar_position:6},l={unversionedId:"state-managment/working-with-tags",id:"version-3.x.x/state-managment/working-with-tags",isDocsHomePage:!1,title:"Working with tags",description:"If you need to have multiples providers using the same SimpleNotifier or StateNotifier class but you don't want create a provider for each notifier you could use the withTag method to create multiples providers for a single Notifier class with its own state.",source:"@site/versioned_docs/version-3.x.x/state-managment/working-with-tags.md",sourceDirName:"state-managment",slug:"/state-managment/working-with-tags",permalink:"/es/docs/3.x.x/state-managment/working-with-tags",editUrl:"https://github.com/darwin-morocho/flutter-meedu/edit/master/website/i18n/es/docusaurus-plugin-content-docs/current",version:"3.x.x",lastUpdatedBy:"Darwin Morocho",lastUpdatedAt:1624736668,formattedLastUpdatedAt:"26/6/2021",sidebarPosition:6,frontMatter:{sidebar_position:6},sidebar:"version-3.x.x/mySidebar",previous:{title:"Working with arguments",permalink:"/es/docs/3.x.x/state-managment/working-with-arguments"},next:{title:"Listen when a provider has disposed a Notifier",permalink:"/es/docs/3.x.x/state-managment/listen-when-a-provider-dispose-a-notifier"}},s=[],c={toc:s};function u(e){var n=e.components,t=(0,i.Z)(e,["components"]);return(0,o.kt)("wrapper",(0,r.Z)({},c,t,{components:n,mdxType:"MDXLayout"}),(0,o.kt)("p",null,"If you need to have multiples providers using the same ",(0,o.kt)("inlineCode",{parentName:"p"},"SimpleNotifier")," or ",(0,o.kt)("inlineCode",{parentName:"p"},"StateNotifier")," class but you don't want create a provider for each notifier you could use the ",(0,o.kt)("inlineCode",{parentName:"p"},"withTag")," method to create multiples providers for a single Notifier class with its own state."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"class CounterController extends SimpleNotifier {\n  int counter = 0;\n  void increment() {\n    counter++;\n    notify();\n  }\n}\n")),(0,o.kt)("p",null,"Now you can create yours provider using ",(0,o.kt)("inlineCode",{parentName:"p"},"SimpleProvider.withTag")," or ",(0,o.kt)("inlineCode",{parentName:"p"},"StateProvider.withTag")),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart",metastring:"{1-3,21-24,27-30,55,69}","{1-3,21-24,27-30,55,69}":!0},"final counterProviderWithTag = SimpleProvider.withTag(\n  (_) => CounterController(),\n);\n\n\nclass SimpleTagPage extends StatelessWidget {\n  const SimpleTagPage({Key? key}) : super(key: key);\n\n  @override\n  Widget build(BuildContext context) {\n    return Scaffold(\n      appBar: AppBar(),\n      body: SafeArea(\n        child: Container(\n          width: double.infinity,\n          height: double.infinity,\n          child: Column(\n            children: [\n              // each SimpleConsumerWithTag has their own state\n              Expanded(\n                child: SimpleConsumerWithTag(\n                  tagName: 'counter1',\n                  color: Colors.black26,\n                ),\n              ),\n              Expanded(\n                child: SimpleConsumerWithTag(\n                  tagName: 'counter2',\n                  color: Colors.redAccent.withOpacity(0.3),\n                ),\n              ),\n            ],\n          ),\n        ),\n      ),\n    );\n  }\n}\n\nclass SimpleConsumerWithTag extends StatelessWidget {\n  final String tagName;\n  final Color color;\n  const SimpleConsumerWithTag({\n    Key? key,\n    required this.tagName,\n    required this.color,\n  }) : super(key: key);\n\n  @override\n  Widget build(BuildContext context) {\n    return Consumer(\n      builder: (_, watch, __) {\n        // the find method creates a new unique provider using a string as key\n        final controller = watch(\n          counterProviderWithTag.find(tagName),\n        );\n        final counter = controller.counter;\n        return Container(\n          color: this.color,\n          alignment: Alignment.center,\n          child: Column(\n            mainAxisAlignment: MainAxisAlignment.center,\n            children: [\n              Text(\"$counter\"),\n              SizedBox(height: 10),\n              CupertinoButton(\n                color: Colors.blue,\n                onPressed: () {\n                  controller.increment();\n                },\n                child: Text(\"increment\"),\n              ),\n            ],\n          ),\n        );\n      },\n    );\n  }\n}\n")),(0,o.kt)("p",null,"Also you can use ",(0,o.kt)("inlineCode",{parentName:"p"},"counterProviderWithTag.find('tagName')")," to pass an initial argument to your notifier"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"counterProviderWithTag.find(tagName).setArguments('initial argument');\n")),(0,o.kt)("p",null,"Also for ",(0,o.kt)("inlineCode",{parentName:"p"},"StateNotifier")," you can use the ",(0,o.kt)("inlineCode",{parentName:"p"},"withTag")," method but you need to define the generic types"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-dart"},"final loginProviderWithTag = StateProvider.withTag<LoginController, LoginState>(\n  (_) => LoginController(),\n);\n")))}u.isMDXComponent=!0}}]);