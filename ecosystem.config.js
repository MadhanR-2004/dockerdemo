module.exports = {
  apps: [
    {
      name: "app",
      script: "src/index.js",
      instances: 2,          // ← 2 instances of your app
      exec_mode: "cluster",  // ← cluster mode = load balancing
    }
  ]
}