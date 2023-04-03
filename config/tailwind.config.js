const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
    mode: "jit",
    purge: [
        "./app/views/**/*.html.erb",
        "./app/helpers/**/*.rb",
        "./app/javascript/**/*.js",
    ],
    content: [
        "./public/*.html",
        "./app/helpers/**/*.rb",
        "./app/javascript/**/*.js",
        "./app/views/**/*.{erb,haml,html,slim}",
    ],
    theme: {
        extend: {
            fontFamily: {
                sans: ["Inter var", ...defaultTheme.fontFamily.sans],
            },
            colors: {
                "space-cadet": "#192A51",
                khaki: "#E6DEC1",
                maroon: "#580707",
                charcoal: "#8D99A5",

                lightGray: "#f5f7fa",
            },
        },
    },
    plugins: [
        require("@tailwindcss/forms"),
        require("@tailwindcss/aspect-ratio"),
        require("@tailwindcss/typography"),
    ],
    variants: {
        extend: {
            //Allows this property to be triggered by a parent and activate a child
            display: ["group-hover"], //For sign out button under profile picture
        },
    },
};
