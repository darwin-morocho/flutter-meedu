/** @type {import('@docusaurus/types').DocusaurusConfig} */
module.exports = {
  title: "Flutter - Meedu",
  tagline: "Dinosaurs are cool",
  url: "https://flutter.meedu.app",
  baseUrl: "/",
  onBrokenLinks: "throw",
  onBrokenMarkdownLinks: "warn",
  favicon: "img/favicon.ico",
  organizationName: "darwin-morocho", // Usually your GitHub org/user name.
  projectName: "flutter-meedu", // Usually your repo name.
  themeConfig: {
    algolia: {
      apiKey: "6c5197db7b9f081004b66fd142ac6627",
      indexName: "flutter-meedu",
    },
    navbar: {
      title: "",
      logo: {
        alt: "Flutter Meedu",
        src: "img/logo.svg",
      },
      items: [
        {
          type: "doc",
          docId: "intro",
          position: "left",
          label: "Docs",
        },
        {
          href: "https://github.com/darwin-morocho/flutter-meedu",
          label: "GitHub",
          position: "right",
        },
        {
          type: "docsVersionDropdown",
          position: "right",
          dropdownActiveClassDisabled: true,
        },
      ],
    },
    footer: {
      style: "dark",
      copyright: `Copyright © ${new Date().getFullYear()} FLUTTER MEEDU. Built with Docusaurus.`,
    },
    prism: {
      theme: require("prism-react-renderer/themes/dracula"),
      additionalLanguages: ["powershell", "dart", "yaml"],
    },
  },
  presets: [
    [
      "@docusaurus/preset-classic",
      {
        docs: {
          sidebarPath: require.resolve("./sidebars.js"),
          // Please change this to your repo.
          editUrl:
            "https://github.com/darwin-morocho/flutter-meedu/edit/master/website/",
          lastVersion: "current",
          versions: {
            current: {
              label: "4.2.0",
              path: "4.x.x",
            },
            "3.x.x": {
              label: "3.x.x",
              path: "3.x.x",
            },
          },
        },
        blog: {
          showReadingTime: true,
          // Please change this to your repo.
          editUrl:
            "https://github.com/darwin-morocho/flutter-meedu/edit/master/website/blog/",
        },
        theme: {
          customCss: require.resolve("./src/css/custom.css"),
        },
      },
    ],
  ],
};
