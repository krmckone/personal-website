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

Hard wrapping (inserting literal line breaks) may cause issues in some environments that utilize lightweight markdown syntax. Kramdown allows content such as paragraphs or blockquotes to be hard wrapped, that is, chopped up accross several lines in a literal sense. This may be called "lazy syntax" as the same level of indentation for lines following the first is not required.

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
The first line of the paragraph can be indented up to three spaces while any other line can have arbitrary level of indentation; this is due to paragraphs being a block-level element which has support for "lazy syntax". A paragraph will end when a definition list line is found or in any of the cases outlined in the line wrapping section.

Separate two paragraphs by using one or more blank lines in a row. A new line or a line break in the Kramdown file does not indicate a line break in the output content (lazy syntax). End a line with two or more space characters or two backslash characters.

For example:

```kramdown
This line had a line break
here in the source file but still renders as one paragraph.
```

This line had a line break
here in the source file but still renders as one paragraph.

```kramdown
This line had two spaces  
here and will appear as a line break.
```

This line had two spaces  
here and will appear as a line break.

```kramdown
This line has two backslash characters \\
here at the previous line.
```

This line has two backslash characters \\
here at the previous line.

You can not use a line break on the last line of a paragraph and trailing/leading whitespace will be stripped from paragraph content.

```kramdown
   Here's what    whitespace looks like
      in differen't place     s in a   para
graph.
```

   Here's what    whitespace looks like
      in differen't place     s in a   para
graph.

In general, paragraph text will be lenient and work the way that you expect in terms of whitespace and indentation.

### Headers

There exists in kramdown support for both Setext and atx headers; both can be used inside a kramdown document.

#### Setext headers

Setext must begin on a block boundary with the header text itself and a single line directly following with equal signs for a first level header or dashes for the second level. Only one dash or equal sign is necessary but more may aid in readability. Any leading or trailing whitespace is stripped from the header text but three spaces of indent is allowed. Align the equal signs or dashes with first column of document. 

```kramdown
Dashes for second level header
--

Equals for first level header
==
```

Dashes for second level header
--

Equals for first level header
==

Setext headers start on block boundaries. So in the majority of cases, they will be preceeded by a blank line. A blank line is not required after a setext header. Best practice is typically to use a blank line after a setext header, however. This is slightly different from original Markdown syntax, which allows the absence of a blank line before a setext header. This is not allowed in kramdown to aid readability and reduce ambiguity.

Setext headers are processed before horizontal rules, that is, you will need to use a `___` or other markdown syntax for horizontal rule instead of `---`.

#### atx headers

Atx style headers must start on a boundary block. The line must start with one or more hash characters directly followed by the header text. No spaces can appear before the hash characters. The number of hashes indicates the heading level; the lower the number of hashes, the bigger the header. The maximum number of hashes is six for the level six header, the smallest. All leading or trailing spaces are stripped from header text. Markdown allows you to omit the blank line before an atx header. Kramdown does not allow this.

#### Specify header ID

Use curly brackets on the same line of a header text to specify a header ID. This feature is from PHP Markdown Extra and Maruku. This is not a feature of standard Markdown

### Blockquotes

Start a blockquote by the `>` character, followed by zero or one spaces, and the blockquote content. Indent the `>` three spaces at the most. Blockquotes support line wrapping (lazy syntax), so any line breaks which follow the first `>` character will be a part of the same blockquote. The contents of a blockquote always block-level content. Then it is the case that text in a blockquote will be of the form of a paragraph.

```kramdown
> This is a blockquote with several
line breaks
      It's all part of the same
> blockquote.
>
Use a blankline for a separate paragraph. The > on this line is optional due to support for line wrapping and since there is a > on the preceeding line.
```

> This is a blockquote with several
line breaks
      It's all part of the same
> blockquote.
>
Use a blankline for a separate paragraph. The > on this line is optional due to support for line wrapping and since there is a > on the preceeding line.

Since a blockquote is a block-level element, blockquotes can exist within blockquotes.

> This is the blockquote which contains
> > a blockquote which contains
> > > a blockquote.

This is accomplished by using one more `>` to indicate the increased level of nesting within the blockquote.

```kramdown
> This is the blockquote which contains
> > a blockquote which contains
> > > a blockquote.
```

All other block-level elements are supported within blockquotes as well.

```kramdown
> Regular paragraph text is here.
>
> ## A level two header is here
>
> ___
> Horizontal rules work just fine. This is another paragraph
with lazy syntax. Still the same paragraph in the same blockquote
despite the hard wrap.
>
> ___
>
* List element is here
* > Another list element which is itself a blockquote
1. Numbered list
2. within that nexted blockquote.
3. Notice the hard line wrapping.
4. It's all inside the list element inside the blockquote.
>
> > > ### A level three header nested three blockquotes deep
```

> Regular paragraph text is here.
>
> ## A level two header is here
>
> ___
> Horizontal rules work just fine. This is another paragraph
with lazy syntax. Still the same paragraph in the same blockquote
despite the hard wrap.
>
> ___
>
* List element is here
>
* > Another list element which is itself a blockquote
> >
1. Numbered list
2. within that nexted blockquote.
3. Notice the hard line wrapping.
4. It's all inside the list element inside the blockquote.
>
> > > ### A level three header nested three blockquotes deep

The lazy syntax arguably hurts readability. Use the explicit `>` characters to be explicit in meaning.

### Code Blocks

Code blocks do not allow the parser to modify text based on syntax rules of kramdown. That is, the contents of clode blocks are left as-is and can be used to reprsent verbatim program gists or code fragments.

#### Code Blocks Standard Form

Use four spaces or one tab to begin code block text. Code blocks support line wrapping and thus any further lines do not explicitly need to be indented in the same manner (lazy syntax). If the indentation is present in any succeeding lines, it is stripped and the contents is simply appended to the preceding block. Similarly, any wrapped code lines are appended to the preceding block. This is specific to kramdown; markdown syntax does not allow line wrapping in code blocks.

```kramdown
    Here is my code block, started by four spaces
still the same code block despite no indentation
```

    Here is my code block, started by four spaces
still the same code block despite no indentation

Code blocks which follow eachother in direct sequence separated by a blank line are not interpreted as separate but are instead combined into one block. Use an EOB marker to separate the code blocks written in sequence.

    Code block started by four spaces

    Another code block started by four spaces after a newline.
    But is actually a part of the first code block.

#### Code Blocks Fenced Form

Fenced syntax does not use indentation for code blocks. Start a fenced block with three or more `~` characters. Close the block with at least the same number of the opening `~` characters. Indentation is not necessary anywhere.

```kramdown
~~~
Fenced code block is here using three ~'s
~~~
```

If `~` characters are needed in the code block, use a larger sequence of `~` characters in the fences.

~~~~~
~~~~
~~~
The othermost fence has five ~'s
~~~
~~~~
~~~~~

Used fenced forms for copy and pasted code as indentation inside fenced blocks is not necessary.

#### Code Blocks Language

Use IAL to inform kramdown of the language used in the code block. This aids in syntax highlighting functionality.

~~~~
~~~
def my_python_function(var):
    print(f"in my_python_function {var}")
    return "Done"
~~~
{: .language-python}
~~~~

~~~
def my_python_function(var):
    print(f"in my_python_function {var}")
    return "Done"
~~~
{: .language-python}

An alternate form is using the backtick syntax.

````kramdown
```python
def my_python_function(var):
    print(f"in my_python_function {var}")
    return "Done"
```
````

```python
def my_python_function(var):
    print(f"in my_python_function {var}")
    return "Done"
```

Both render in the same manner.

### Lists

Ordered lists, unordered lists, and definition lists are supported by kramdown syntax.

#### Ordered and Unordered Forms


