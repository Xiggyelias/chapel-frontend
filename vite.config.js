import { defineConfig } from 'vite';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
    plugins: [
        tailwindcss(),
    ],
    build: {
        outDir: '../public/build',
        emptyOutDir: false,
        rollupOptions: {
            input: {
                app: 'js/app.js',
                style: 'css/app.css',
            },
        },
    },
});
