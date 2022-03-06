/**
 * Creating a sidebar enables you to:
 - create an ordered group of docs
 - render a sidebar for each doc of that group
 - provide next/previous navigation

 The sidebars can be generated from the filesystem, or explicitly defined here.

 Create as many sidebars as you want.
 */

module.exports = {
  mySidebar: [
    {
      type: "category",
      label: "Getting Started",
      items: ["intro"],
    },
    {
      type: "category",
      label: "State Management",
      items: [
        "state-management/intro",
        "state-management/simple-notifier",
        "state-management/state-notifier",
        "state-management/working-with-arguments",
        "state-management/working-with-tags",
        "state-management/listen-when-a-provider-dispose-a-notifier",
        "state-management/testing",
      ],
    },
    "dependency-injection",
    "persistent-state",
    "reactive-programming",
    "navigation",
    "screen-utils",
  ],
};
