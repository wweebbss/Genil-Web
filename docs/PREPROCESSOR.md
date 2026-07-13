The preprocessor is a custom script that takes HTML code where preprocessor directives with content are `<% ...DIRECTIVE %>` and `<% ...DIRECTIVE />` for standalone ones.

Currently the only preprocessing done is a standaloine one that parses the directive as a JSON string (must include quotes) and including in-place and recursively such path relative to the source directory.

This may be expanded to support more actions in the form of `<% directive="value" %>` if further preprocessing is needed.
