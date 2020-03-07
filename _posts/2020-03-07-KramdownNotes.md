---
layout: post
title:  "Notes for using Kramdown"
categories: [tools]
tags: [kramdown]
date:   2020-03-06 12:00:00 -0500
---

Kramdown is baed on Markdown syntax. It borrows from features in other implementations of Markdown, such as Maruku, PHP Markdown Extra, etc. Kramdown has extra rules with strict syntax so it will not be completely compatible with vanilla Markdown. However, most Markdown files should work just fine with Kramdown parsing.

What follows is the syntax definition for all Kramdown elements in a shorthand when compared to [Kramdown docs](https://kramdown.gettalong.org/syntax.html).

## Source text format

Kramdown docs can possess any encoding (ASCII, UTF-8, ISO-8859-1). Output does not depend on source encoding.

Docs contain two types of elements. **block-level** and **span-level**.

**Block-level**: Main structure of content; answers the question of what part of the text is a paragraph, list, quote, etc. Defines the meaning of structure of the document.

**Span-level**: Small parts of the text; links, bold text, italics, etc.

Then it is the case that span-level elements can only appear inside block-level elements or inside another span-level element.

References to the "first column"/"first character" of a block-level element line is meant to be relative to the present level of indentation. Block level elements may start a new deeper level of indentation, such as blockquotes. Kramdown docs start with the default level of indentation and begins at the first column of the content itself.

### Line Wraps

Hard wrapping may cause issues in some environments that utilize lightweight markdown syntax. Kramdown allows content such as paragraphs or blockquotes to be hard wrapped, that is, chopped up accross several lines. This may be called "lazy syntax" as the same level of indentation for lines following the first is not required.

Block-level elments that implement support for line wrappling exhibit line wrpaping under two conditions:

1. end of document is met (block boundary), block IAL, EOB marker line, or a blank line
2. HTML block

Kramdown docs support line wrapping throughout the entire document. However, what follows are the block-level elements which do not support hard-wrapping (lazy syntax):

1. headers
   1. headers usually fit on one line anyway
   2. use HTML syntax if needed
2. fenced code blocks
   1. Everything taken within the fenced code block is as-is
3. definition list terms
   1. each term must be a separate line. lazy syntax would cause a new term to be introduced unintentionally
4. tables
   1. each line must represent a new row in the table

It is **Not recommended** to use the "lazy syntax" in Kramdown docs. Kramdown has flexibility with respect to line wrapping baked into the syntax and it has potential to hinder readability; do not use it when possible.

### Tabs

Kramdown tabs are assumed to be a multiple of four. Pay attention to this value, particularly when using list indentations. Tabs are only usable at the start of a line when text is indented and there must not be any preceding space characters; unexpected results may follow.

### Automatic and Manual Escapes

Some characters may require special formatting. Kramdown docs to HTML docs require special handling, for example, when dealing with <, >, and & as these have special meaning in HTML docs. They are automatically escaped in the correct manner, depending on the target document format.

The implies that <, >, and & may be used freely without manual escape characters in Kramdown docs. Additionally, HTML elements may be liberally included in Kramdown docs without being escaped.

When Kramdown syntax needs to be used in the literal sense, these characters do need to be manually escaped. For example, you would need to escape the backtick characters if you need their literal representation in the target content.

\` This is not a code span \` because the backticks are escaped.

What follows is a list of all the characters that may be escaped in a Kramdown doc.

```
\           backslash character
.           period
*           asterick
_           underscore
+           plus
-           minus
=           equal sign
`           backtick
()[]{}<>    left/right parens/square/curly/angled
#           hash
!           bang
<<          left redirection
>>          right redirection
:           colon
|           pipe operator
"           double quote
'           single quote
$           dollar symbol
```

### Block Boundaries

Block elements may have a start and/or ends, therefore, posessing block boundaries. Two cases pertain to block boundaries having effect:

1. If an element which is a block-level element must start on a block boundary, it must come after a blank line, EOB marker, block IAL, or must itself be the first element.
2. If an element which is a block-level element must end on a block boundary, it must be directly succeeded by a blank line, EOB marker, block IAL, or must itself be the last element.

## Structural Elements

Used to structure content, all structural elements are block-level elements. Their primary use is to mark-up textual content.

### Blank lines

Kramdown views all lines which contain only whitespace, tab, or space characters as blank. Blank lines will be 1 or more consecutive blank lines in the content, that is, many blank lines in a row will still translate to a single blank line in the output. Blank lines separate block-level elements. For the most part, then, blank lines are semantically meaningless other than serving as separators. Exceptions to this rule follow:

Blank lines in:

* Headers
* Code blocks
* Lists
* Math blocks
* Elements which must start or end on block boundaries

Refer to these specific contexts to understand the exceptions.

### Paragraphs

Paragraphs serve as the most commonly used of the block-level elements. 1 or more lines of text in sequence will be considered one paragraph.