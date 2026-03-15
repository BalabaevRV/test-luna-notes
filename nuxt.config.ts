// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: true },
  modules: ['@nuxt/eslint', '@pinia/nuxt', 'pinia-plugin-persistedstate/nuxt'],
  css: ['~/assets/scss/main.scss'],
    vite: {
    css: {
      preprocessorOptions: {
        scss: {
          additionalData: '@use "~/assets/scss/_colors.scss" as *; @use "~/assets/scss/_fonts.scss" as *; @use "~/assets/scss/_transitions.scss" as *; @use "~/assets/scss/_variables.scss" as *;',
        },
      },
    },
  },
})