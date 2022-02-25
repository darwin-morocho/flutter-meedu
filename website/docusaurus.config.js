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
          type: "localeDropdown",
          position: "right",
        },
        {
          type: "docsVersionDropdown",
          position: "right",
          dropdownActiveClassDisabled: true,
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
      additionalLanguages: ["powershell", "dart", "yaml"],
    },
  },
  presets: [
    [
      "@docusaurus/preset-classic",
      {
        docs: {
          editLocalizedFiles: true,
          showLastUpdateAuthor: true,
          showLastUpdateTime: true,
          editUrl: ({ locale, versionDocsDirPath, docPath }) => {
            if (locale !== "en") {
              return `https://github.com/darwin-morocho/flutter-meedu/edit/master/website/i18n/${locale}/${versionDocsDirPath}/${docPath}`;
            }
            return `https://github.com/darwin-morocho/flutter-meedu/edit/master/website/${versionDocsDirPath}/${docPath}`;
          },
          sidebarPath: require.resolve("./sidebars.js"),
          lastVersion: "current",
          versions: {
            current: {
              label: "6.0.0",
            },
            "5.x.x": {
              label: "5.3.0",
              path: "5.x.x",
            },
            "4.x.x": {
              label: "4.4.1",
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
  i18n: {
    defaultLocale: "en",
    locales: ["en", "es"],
    localeConfigs: {
      en: {
        label: "English",
      },
      es: {
        label: "Español",
      },
    },
  },
};
