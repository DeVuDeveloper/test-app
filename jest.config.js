module.exports = {
  setupFilesAfterEnv: ["./jest.setup.js"],
  "testMatch": ["**/__tests__/**/*.test.js"],
  cacheDirectory: "./tmp/cache/jest",
  moduleNameMapper: {
    "@javascripts(.*)$": "<rootDir>/app/assets/javascripts$1",
  },
  testEnvironment: "jsdom",
  transformIgnorePatterns: ["node_modules"],
};
