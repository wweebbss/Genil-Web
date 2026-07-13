# Summary

Keep HTML readable.

- Semantic HTML, should capture the meaning of the layout.
- Composable CSS, it should be reusable and concise.
- Opinons belong in theme variables, not hidden in glue CSS.
- Appropriate units for accessibility.

## Structure

- Keep nesting shallow where practical.
- Prefer explicit document structure over clever abstractions.
- Extract repeated fragments into partials instead of inventing generic wrappers.

# Layout

Avoid falling into `div`-hell, use explicit tags like `main`, `header` or `footer` where they mean something. Use `div`s where they genuilly change downstream layout and have a global layout meaning instead of a nitpick.

# Selectors

Prefer small, composable layout classes over large component classes. Layout concerns should be reflected directly in the HTML (e.g. `.flex.row`), while component styling belongs in component-specific stylesheets.

# Context

Avoid magic values or opinionated defaults in shared styles. Common utilities should be parametrized by the theme instead of parametrizing themselves.

# Units

Keep units concise for the sake of accessibility across devices with different font sizes. As a general rule, think if your distance is related to:

- Typography: `em`, `rem`, `ch`
- Spacing: mostly `rem`
- Content width: `ch` or `rem`
- Viewport/layout: `%,` `vw`, `vh`
- Borders/hairlines: `px`
