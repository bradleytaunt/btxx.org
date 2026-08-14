# Sublime Text

Personal configuration for the text editor [Sublime Text](https://www.sublimetext.com)

## Themes / Color Schemes

* Theme: Spacegray
* Color scheme is set to default

## Plugins

* Package Control
* BracketHighlighter
* Copy Relative Path
* Spacegray UI Theme
* Emmet

## Settings

~~~sh
{
  "ignored_packages":
  [
    "Vintage",
  ],
  "font_face": "Maple Mono Normal Regular",
  "font_size": 12,
  "line_padding_bottom": 2,
  "line_padding_top": 2,
  "word_wrap": true,
  "wrap_width": 100,
  "tab_size": 2,
  "translate_tabs_to_spaces": true,
  "trim_automatic_white_space": true,
  "theme": "auto",
  "highlight_line": true,
  "index_files": true,
  "show_definitions": false,
  "dark_theme": "Spacegray Light.sublime-theme",
  "light_theme": "Spacegray.sublime-theme",
}
~~~

## Tweaks to Existing Theme

Open `Preferences` > `Customize Theme`:

~~~sh
"rules":
[
  {
    "class": "sidebar_label",
    "font.size": 14
  },
  {
    "class": "sidebar_heading",
    "font.size": 13
  },
  {
    "class": "tab_label",
    "font.size": 14
  },
  {
    "class": "tabset_control",
    "tab_height": 40
  }
]
~~~

