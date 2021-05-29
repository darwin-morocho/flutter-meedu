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
      ],
    },
    footer: {
      style: "dark",
      copyright: `Copyright © ${new Date().getFullYear()} FLUTTER MEEDU. Built with Docusaurus.`,
    },
    prism: {
      theme: require("prism-react-renderer/themes/dracula"),
      additionalLanguages: ["powershell", "dart"],
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
