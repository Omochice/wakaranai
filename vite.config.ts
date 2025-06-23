import { defineConfig } from 'vite'
import { plugin as elm } from 'vite-plugin-elm'

export default defineConfig({
  plugins: [
    elm({
      debug: false,
      optimize: true,
    }),
  ],
  css: {
    transformer: 'lightningcss',
  },
  build: {
    outDir: 'dist',
    emptyOutDir: true,
    rollupOptions: {
      input: {
        main: 'index.html',
      },
    },
  },
  server: {
    port: 3000,
    open: true,
  },
})