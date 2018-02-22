# This file is part of vue-styled-jss
# Copyright (C) 2018-present Dario Giovannetti <dev@dariogiovannetti.net>
# Licensed under MIT
# https://github.com/kynikos/vue-styled-jss/blob/master/LICENSE

# TODO: Verify the tag names against html-tag-names in tests like in
#       hyperscript-helpers
#       Also include the SVG tags?
# See https://github.com/ohanhi/hyperscript-helpers/issues/34 for the reason
# why the tags aren't simply required from html-tag-names
HTML_TAG_NAMES = [
  'a', 'abbr', 'acronym', 'address', 'applet', 'area', 'article', 'aside',
  'audio', 'b', 'base', 'basefont', 'bdi', 'bdo', 'bgsound', 'big', 'blink',
  'blockquote', 'body', 'br', 'button', 'canvas', 'caption', 'center', 'cite',
  'code', 'col', 'colgroup', 'command', 'content', 'data', 'datalist', 'dd',
  'del', 'details', 'dfn', 'dialog', 'dir', 'div', 'dl', 'dt', 'element', 'em',
  'embed', 'fieldset', 'figcaption', 'figure', 'font', 'footer', 'form',
  'frame', 'frameset', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'head', 'header',
  'hgroup', 'hr', 'html', 'i', 'iframe', 'image', 'img', 'input', 'ins',
  'isindex', 'kbd', 'keygen', 'label', 'legend', 'li', 'link', 'listing',
  'main', 'map', 'mark', 'marquee', 'math', 'menu', 'menuitem', 'meta',
  'meter', 'multicol', 'nav', 'nextid', 'nobr', 'noembed', 'noframes',
  'noscript', 'object', 'ol', 'optgroup', 'option', 'output', 'p', 'param',
  'picture', 'plaintext', 'pre', 'progress', 'q', 'rb', 'rbc', 'rp', 'rt',
  'rtc', 'ruby', 's', 'samp', 'script', 'section', 'select', 'shadow', 'slot',
  'small', 'source', 'spacer', 'span', 'strike', 'strong', 'style', 'sub',
  'summary', 'sup', 'svg', 'table', 'tbody', 'td', 'template', 'textarea',
  'tfoot', 'th', 'thead', 'time', 'title', 'tr', 'track', 'tt', 'u', 'ul',
  'var', 'video', 'wbr', 'xmp'
]

module.exports = (jss, options) ->
    styled = (tagName, style) ->
        # TODO: Find a way to support composition, i.e. passing a component
        #       instead of a tagName string

        # TODO: Support dynamic styles based on the passed component's props

        styleobj = {}
        styleobj[tagName] = style
        className = jss.createStyleSheet(styleobj, options).attach()
            .classes[tagName]

        return {
            functional: true

            render: (h, context) ->
                if Array.isArray(context.data.class)
                    context.data.class.push(className)
                else
                    context.data.class = [context.data.class, className]
                h(tagName, context.data, context.children)
        }

    styled.factory = (tagName) ->
        (style) ->
            styled(tagName, style)

    for tagName in HTML_TAG_NAMES
        styled[tagName] = styled.factory(tagName)
        styled[tagName.charAt(0).toUpperCase() + tagName.slice(1)] =
            styled.factory(tagName)

    return styled
