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
      label: "State Managment",
      items: [
        "state-managment/intro",
        "state-managment/simple-notifier",
        "state-managment/state-notifier",
        "state-managment/working-with-arguments",
        "state-managment/working-with-tags",
        "state-managment/listen-when-a-provider-dispose-a-notifier",
        "state-managment/testing",
      ],
    },
    "dependency-injection", 
    "reactive-programming", 
    "navigation", 
    "screen-utils", 
  ],
};
