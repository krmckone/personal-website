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

Hard wrapping (inserting literal line breaks) may cause issues in some environments that utilize lightweight markdown syntax. Kramdown allows content such as paragraphs or block quotes to be hard wrapped, that is, chopped up across several lines in a literal sense. This may be called "lazy syntax" as the same level of indentation for lines following the first is not required.

Block-level elements that implement support for line wrapping exhibit line wrapping under two conditions:

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

\` This is not a code span \` because the back ticks are escaped.

What follows is a list of all the characters that may be escaped in a Kramdown doc.

```
\           backslash character
.           period
*           asterisk
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

Block elements may have a start and/or ends, therefore, possessing block boundaries. Two cases pertain to block boundaries having effect:

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
      in different place     s in a   para
graph.
```

   Here's what    whitespace looks like
      in different place     s in a   para
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

Setext headers start on block boundaries. So in the majority of cases, they will be preceded by a blank line. A blank line is not required after a setext header. Best practice is typically to use a blank line after a setext header, however. This is slightly different from original Markdown syntax, which allows the absence of a blank line before a setext header. This is not allowed in kramdown to aid readability and reduce ambiguity.

Setext headers are processed before horizontal rules, that is, you will need to use a `___` or other markdown syntax for horizontal rule instead of `---`.

#### atx headers

Atx style headers must start on a boundary block. The line must start with one or more hash characters directly followed by the header text. No spaces can appear before the hash characters. The number of hashes indicates the heading level; the lower the number of hashes, the bigger the header. The maximum number of hashes is six for the level six header, the smallest. All leading or trailing spaces are stripped from header text. Markdown allows you to omit the blank line before an atx header. Kramdown does not allow this.

#### Specify header ID

Use curly brackets on the same line of a header text to specify a header ID. This feature is from PHP Markdown Extra and Maruku. This is not a feature of standard Markdown

### Block quotes

Start a blockquote by the `>` character, followed by zero or one spaces, and the blockquote content. Indent the `>` three spaces at the most. Block quotes support line wrapping (lazy syntax), so any line breaks which follow the first `>` character will be a part of the same blockquote. The contents of a blockquote always block-level content. Then it is the case that text in a blockquote will be of the form of a paragraph.

```kramdown
> This is a blockquote with several
line breaks
      It's all part of the same
> blockquote.
>
Use a blank line for a separate paragraph. The > on this line is optional due to support for line wrapping and since there is a > on the preceding line.
```

> This is a blockquote with several
line breaks
      It's all part of the same
> blockquote.
>
Use a blank line for a separate paragraph. The > on this line is optional due to support for line wrapping and since there is a > on the preceding line.

Since a blockquote is a block-level element, block quotes can exist within block quotes.

> This is the blockquote which contains
> > a blockquote which contains
> > > a blockquote.

This is accomplished by using one more `>` to indicate the increased level of nesting within the blockquote.

```kramdown
> This is the blockquote which contains
> > a blockquote which contains
> > > a blockquote.
```

All other block-level elements are supported within block quotes as well.

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
2. within that nested blockquote.
3. Notice the hard line wrapping.
4. It's all inside the list element inside the blockquote.
>
> > > ### A level three header nested three block quotes deep
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
2. within that nested blockquote.
3. Notice the hard line wrapping.
4. It's all inside the list element inside the blockquote.
>
> > > ### A level three header nested three block quotes deep

The lazy syntax arguably hurts readability. Use the explicit `>` characters to be explicit in meaning.

### Code Blocks

Code blocks do not allow the parser to modify text based on syntax rules of kramdown. That is, the contents of code blocks are left as-is and can be used to represent verbatim program gists or code fragments.

#### Code Blocks Standard Form

Use four spaces or one tab to begin code block text. Code blocks support line wrapping and thus any further lines do not explicitly need to be indented in the same manner (lazy syntax). If the indentation is present in any succeeding lines, it is stripped and the contents is simply appended to the preceding block. Similarly, any wrapped code lines are appended to the preceding block. This is specific to kramdown; markdown syntax does not allow line wrapping in code blocks.

```kramdown
    Here is my code block, started by four spaces
still the same code block despite no indentation
```

    Here is my code block, started by four spaces
still the same code block despite no indentation

Code blocks which follow each other in direct sequence separated by a blank line are not interpreted as separate but are instead combined into one block. Use an EOB marker to separate the code blocks written in sequence.

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
The outermost fence has five ~'s
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

Start an unordered list with a list marker. List markers are `+`, `-`, or `*` symbols and are interchangeable/mixable in the syntax. Ordered lists markers are a number directly followed by a period character followed by one or more spaces. Follow the list marker with the list element content. Leading or trailing whitespace is stripped off of the list content to implement consistent alignment of list contents. Ordered lists always start at the numeral 1.

```kramdown
* Started with an "*"
+ Started with a "+"
- Started with a "-"
```

```kramdown
5. Number one
2. Number two
3. Number three
6. Number four
```

* Started with an "*"
+ Started with a "+"
- Started with a "-"

1. Number one
2. Number two
3. Number three
4. Number four

Notice how the numbers specified are arbitrary; kramdown handles the proper numbering in numbered lists automatically. Kramdown does not allow markers of unordered and ordered lists to be mixed. That is, kramdown uses the first marker type to specify the list and that type is the type of the list (either explicitly ordered or unordered). So the above syntax generates one unordered list and one ordered list separately.

The first list marker can be indented up to the three spaces. The column of the first non-whitespace character following the list marker is the indentation level required for the rest of the lines pertaining to the content of that list item. When no such character exists, standard indentation is four spaces or one tab character. Line wrapping allows lines of any indentation to directly follow a line of indentation. It is always the case though that a list item ends when a another list marker is encountered. Whitespace is stripped off from the content of the list element all content of the list element is interpreted as block-level content. Then similarly to blockquote, any block element may be a list element. Any list markers which follow may be indented three spaces or the same number of spaces of the most recent list element minus one. The smaller number takes precedence.

Avoid using different indentations for the same level of list elements as it hurts readability and meaning. Vanilla markdown allows indentation of the marker itself. However, this behavior is undefined in particular. Markdown additionally uses a finite number of spaces and tabs to give lines indentation in a list element.

In general, indentation works the same in unordered and ordered lists.

```kramdown
* element 1
* element 2
This is a newline which is part of element 2 (lazy syntax)
    * element 3.1
      * element 3.1.1
        * 1. Element 1 of 3.1.1.1
      * element 3.1.2
    * Element 3.2
* Element 4
* 
1. * Unordered due to line wrapping into ordered with unordered     And an    indent that got stripped off
```

* element 1
* element 2
This is a newline which is part of element 2 (lazy syntax)
    * element 3.1
      * element 3.1.1
        * 1. Element 1 of 3.1.1.1
      * element 3.1.2
    * Element 3.2
* Element 4
* 
1. * Unordered due to line wrapping into ordered with unordered     And an    indent that got stripped off

Remember that tabs in kramdown are multiples of four spaces. The tab character is automatically converted to corresponding space characters for computing indentation depth.

```kramdown
*   Tab indented three spaces, including the `*` character,
    is four spaces overall for this line. Then it is the case that the
    list marker counts towards the indentation and not just whitespace,
    that is, the column number is significant.

    1.    The list marker is indented here with another indent following
the marker. Due to the indentation and lazy syntax, this is a
    sub list of the above unordered list.

```

*   Tab indented three spaces, including the `*` character,
    is four spaces overall for this line. Then it is the case that the
    list marker counts towards the indentation and not just whitespace,
    that is, the column number is significant.

    1.    The list marker is indented here with another indent following
the marker. Due to the indentation and lazy syntax, this is a
    sub list of the above unordered list.

Mix results may occur if you use both tabs and spaces in sequence with each other. 4 spaces as tab spots is
also by definition in kramdown and should always be the standard in a document.

List content that follows a list marker is some text or a block-level element. Textual content is the most simple. The output is not wrapped in a paragraph HTML tag. However, if the first list content is followed by one or more blank lines, then it will be regarded as a paragraph. This will nearly always be the case when you are done with a list and move on to the next element in the document. Use an EOB marker to prevent the paragraph tag on the last list item if you want to leave a space after it.

```kramdown
* A couple list
* Items side by side followed

* By a list item which has a space above it

* Another list item separated top and bottom

* By a space and this bottom one has a space below it but also an EOB marker

^
```

* A couple list
* Items side by side followed

* By a list item which has a space above it

* Another list item separated top and bottom

* By a space and this bottom one has a space below it but also an EOB marker

^

The last list item's content will get a paragraph tag if all other list items also contain a paragraph as the first element. Then it makes it so that typical lists work as expected.

```kramdown
* A very basic list with

* Some bullet points just

* with white space between them all
```

* A very basic list with

* Some bullet points just

* with white space between them all

A list item's content can contain elements which are block-level. Therefore, you can always nest block elements in a list element.

````kramdown
1. Ordered list here
2. > Block quote in the ordered list
   > * Now we have an unordered list.
3. Back to a normal element.
4. ```kramdown
   A code block as well.
   > A block quote inside the code block inside the
   > ordered list.
   ```
````

1. Ordered list here
2. > Block quote in the ordered list
   > * Now we have an unordered list.
3. Back to a normal element.
4. ```kramdown
   A code block as well.
   > A block quote inside the code block inside the
   > ordered list.
   ```

#### Definition Lists

Definition lists are for assigning definitions to terms.

Start a definition list with a normal paragraph directly followed by a line with a definition maker. A definition marker is a colon that can be optionally indented three spaces maximum. Following the definition marker is at least one tab or one space. Then type the definition of the term.The definition marker and the previous paragraph may optionally be separated by a blank line. Whitespace is stripped from the beginning of the first definition line. Each line of the previous paragraph is interpreted as a term and each line is separately contained as a span-level element.

For example:

```kramdown
Python
: A general-purpose, object-oriented, high level programming language with a reference implementation in C

GCC
: GNU Compiler Collection, a selection of compiler tools supported by GNU
```

Python
: A general-purpose, object-oriented, high level programming
language with a reference implementation in C

GCC
: GNU Compiler Collection, a selection of compiler tools
supported by GNU

I prefer to add bold text to the term element with my theme. This reduces ambiguity when term lists are rendered with small spacing.

```kramdown
**C#**
: An object-oriented language developed and maintained by Microsoft. Runs on .NET common language infrastructure.

**F#**
: A language developed and maintained by Microsoft with functional-first features inspired by languages like standard ML and OCaml.

**TypeScript**
: Another language developed by Microsoft. A strongly typed, compiled super set of JavaScript. Utilized by the Angular project.
```

**C#**
: An object-oriented language developed and maintained by Microsoft. Runs on .NET common language infrastructure.

**F#**
: A language developed and maintained by Microsoft with functional-first features inspired by languages like standard ML and OCaml.

**TypeScript**
: Another language developed by Microsoft. A strongly typed, compiled super set of JavaScript. Utilized by the Angular project.

The deepest non-whitespace character after the definition marker is the column which corresponds the required indentation for the rest of the definition. Otherwise, indentation of four spaces or one tab is utilized.
A list item ends when a line with the next definition marker is found. Indented lines which follow the above rule for indentation may then contain any amount of indentation (line wrapping).

Indentation is cut from the definition element. Then the content of the definition is interpreted as block-level elements. When there is more than one definition element for the same term, the following definitions may be three space indented or the number of spaces used in the indentation of the last definition minus one (take the minimum of the two).

```kramdown
**First Term**
: The first line of the definition. 
  Realize that the first non-whitespace character of the definition 
  is in column 3. then any other line for this definition must also 
  start in column 3, i.e, indented 2 spaces.
: Another definition for the first term.
**Second Term**
    : I've indented this one with a tab. The whitespace is stripped.
        : I want to avoid this useless sort of indentation since it
          hurts readability of the source and adds nothing to the output.
```

**First Term**
: The first line of the definition. 
  Realize that the first non-whitespace character of the definition 
  is in column 3. then any other line for this definition must also 
  start in column 3, i.e, indented 2 spaces.
: Another definition for the first term.
**Second Term**
    : I've indented this one with a tab. The whitespace is stripped.
        : I want to avoid this useless sort of indentation since it
          hurts readability of the source and adds nothing to the output.

Avoid using haphazard indentation in the definition lists. It is not needed and using indents that are unclear in meaning hurts readability.

A definition is made of block-level elements. When it is not coming after a blank line, the definition will be regular paragraph text.

```kramdown
**First Term**
: There is no blank line before this line in the definition.

  > Here is a block-level element. However, notice it is contained in the definition.
    It is indented the correct number of spaces (2).

: This definition does have a blank line before it. Therefore, it is a paragraph.
```
**First Term**
: There is no blank line before this line in the definition.

  > Here is a block-level element. However, notice it is contained in the definition.
    It is indented the correct number of spaces (2).

: This definition does have a blank line before it. Therefore, it is a paragraph.

### Tables

Table syntax in Kramdown is different than that of original Markdown. It is closely based on PHP Markdown
Extra syntax.

Kramdown tables are for collecting data in a form in which HTML syntax is too heavy. Kramdown supports
simple ASCII-formatted data and outputs HTML table syntax.

Leading pipes are optional. If the line that starts a table contains the pipe character as the first character,
then all following leading pipes are ignored on any further lines in the table. If that is not the case, then
leading pipe characters are used when computing the divisions of cells of the table.

For different line types exist for tables in Kramdown.

* Table Row

  This row type is a line which contains the pipe character at least once and does not fall into any
  other case of a line type, i.e., it is the most simple line type. This type is divided into cells of
  of the table by using the pipe character. A trailing pipe character is ignored and is therefore optional
  in the syntax for the table row. Pipe character literals must be escaped unless they appear in a kramdown
  code span or an HTML tagged code element.

  Use the same syntax for a table row to implement headers and footers. Each table cell can be at most one line
  of content. Table cells are interpreted as span-level elements.

  ```kramdown
  | Header for Col 1 | Header for Col 2 | Header for Col 3
  | Element 1 | Element 2 | Element 3
  | Element 4 | Element 5 | Element 6 > No quotes here | 1. No lists here 2. None at all
  ```

  | Header for Col 1 | Header for Col 2 | Header for Col 3
  | Element 1 | Element 2 | Element 3
  | Element 4 | Element 5 | Element 6 > No quotes here | 1. No lists here 2. None at all

* Separator Lines

  Used for splitting a table body into several parts. It is a line which contains only pipe characters, dash
  characters, plus symbols, and whitespace characters. A separator line must contain at least a dash and the
  pipe character for it to be valid syntax. The pipe character and the plus symbol may be used to add
  readability to the source document. Several separator lines in sequence are interpreted as one separator
  line.

  ```kramdown
  ```

  | header 1 | header 2 | header 3
  |-
  | This is right below the header separator | Second content | Tons of content
  | What is next? | More stuff on this row | Last row last column

  The first separator line to follow the first line of the table is regarded as the header separator line.
  It may contain information that gives specific alignment definition to the header line. All rows above the
  first separator line are regarded as header lines. The syntax of the header separator alignment definition
  is as follows.

  * An optional whitespace character directly followed by
  * an optional colon directly followed by (NO WHITESPACE)
  * one or more dash characters followed by (NO WHITESAPCE)
  * an optional colon terminated by an optional space character

    The colon characters are what sets the column alignment. No colon characters implies default column
  alignment. A single colon character on the line that appears before the dash characters implies left
  alignment. If there are colon characters before and after the dash characters, then the column will be
  center aligned. One colon character only after the dashes implies right column alignment. Each alignment
  definition will set the alignment for only ONE column. Therefore, multiple alignment definitions will be
  needed if more than one column appears in the table. The default is left alignment.

  ```kramdown
  | Left aligned header | Right aligned header
  | :- | -:
  | Column 1 | Column 2

  | Center aligned header | Center aligned header | Left aligned header
  | :-: | :-: |
  | Column 1 | Column 2 | Column 3

  | Right aligned | Right aligned | Center aligned
  | -: | -: | :-:
  | Column 1 | Column 2 | Column 3
  ```

  | Left aligned header | Right aligned header
  | :- | -:
  | Column 1 | Column 2

  | Center aligned header | Center aligned header | Left aligned header
  | :-: | :-: |
  | Column 1 | Column 2 | Column 3

  | Right aligned | Right aligned | Center aligned
  | -: | -: | :-:
  | Column 1 | Column 2 | Column 3

* Footer Separator Line

  A footer separator fills the same purpose as a header line separator, just for the footer. The syntax is
  similar; replace the dash characters with equal sign characters. This line may appear only once in a table.
  The last appearance of a footer separator line is used in the table. Any separator line used after the footer
  separator line are not interpreted as separator lines.

You do not need to type the same number of columns in a separator line as there are actual columns in the
table. Therefore, `|-` or `|=` are valid separator lines for header and footer, respectively.

Therefore, tables consist of the following in order.

* Optional separator line
* Optional zero or more table rows
* Optional Header separator line
* one or more table rows, each potentially separated by separator lines to improve readability of doc
* Optional footer separator line
* Zero or more table rows
* Optional terminating separator line

The first line of the table may not be indented by more than three whitespace characters. Additionally,
each line of the table must have at a minimum one non-escaped pipe character. Tables must also start and
finish on block boundaries. Kramdown separates itself from the inspiration syntax of PHP Markdown Extra by
not requiring a table header, allowing structure in the doc by using separator lines, allowing a table footer,
and by needing to be separate from any other block-level element.

This section concludes with a couple full-fledged examples to demonstrate the power of the Kramdown syntax with
respect to tables.

```kramdown
|---------------------------+--------------------------+--------------------------+-------------------------|
| Header 1, default aligned | Header 2, center aligned | Header 3, center aligned | Header 4, right aligned |
|---------------------------+:-----------:-------------+--------------------------+-------------------------|
| Column 1                  | Column 2                 | Column 3                 | Column 4                |
| Third line                | Wow                      | Lots of spaces           | looks good in the doc   |
|---------------------------+--------------------------+--------------------------+-------------------------|
| Another portion separated | Column 2 again           | Column 3 coming at you   | Line 4 column 4         |
| Another whole line        | Data is important        | Getting hard to maintain | This hard of syntax     |
|===========================+==========================+==========================+=========================|
| The row above was a       | Footer separator line so | This row is treated as a | footer                  |
|---------------------------+--------------------------+--------------------------+-------------------------|
```

|---------------------------+--------------------------+--------------------------+-------------------------|
| Header 1, default aligned | Header 2, center aligned | Header 3, center aligned | Header 4, right aligned |
|---------------------------|:------------------------:|:------------------------:|------------------------:|
| Column 1                  | Column 2                 | Column 3                 | Column 4                |
| Third line                | Wow                      | Lots of spaces           | looks good in the doc   |
|---------------------------+--------------------------+--------------------------+-------------------------|
| Another portion separated | Column 2 again           | Column 3 coming at you   | Line 4 column 4         |
| Another whole line        | Data is important        | Getting hard to maintain | This hard of syntax     |
|===========================+==========================+==========================+=========================|
| The row above was a       | Footer separator line so | This row is treated as a | footer                  |
|---------------------------+--------------------------+--------------------------+-------------------------|

This syntax looks good in the Kramdown document itself. However, it is not necessary for the output to be
formatted correctly. The short-hand syntax is much more maintainable over time and is much faster to type.

```kramdown
|---
| Header 1, default aligned | Header 2, center aligned | Header 3, center aligned | Header 4, right aligned
| :- | :-: | :-: | -:
| Column 1 | Column 2 | Column 3 | Column 4
| Third line | Wow | Not many spaces | Doesn't look as good in the doc
| Not separated by a line this time | Column 2 again | Column 3 coming at you | line 4 column 4
| Another whole line | Data is important | Easier to maintain | less typing in the syntax
|===
| The row above | wasn't much of | a footer this | time around
```

|---
| Header 1, default aligned | Header 2, center aligned | Header 3, center aligned | Header 4, right aligned
| :- | :-: | :-: | -:
| Column 1 | Column 2 | Column 3 | Column 4
| Third line | Wow | Not many spaces | Doesn't look as good in the doc
| Not separated by a line this time | Column 2 again | Column 3 coming at you | line 4 column 4
| Another whole line | Data is important | Easier to maintain | less typing in the syntax
|===
| The row above | wasn't much of | a footer this | time around

### Horizontal Rules

Horizontal rules are used for visually creating separation between content. Make one by using three or more
asterisks, dash characters, or underscores without mixing the syntax. Each character may be separated
optionally by spaces or tab characters on a line containing no other characters. Indent the first character
by up to three whitespace characters.

```kramdown
_ __
Look
* * *
at
- - -
all
-    - -
of
the
  - -   -
options!
* * *
```

_ __
Look
* * *
at
- - -
all
-    - -
of
the
  - -   -
options!
* * *

### Math Blocks

Math blocks are not contained in the original Markdown syntax. The support for them in Kramdown comes from
Maruku and Pandoc.

Kramdown has built-in support for Latex syntax for writing mathematics. Both block-level and span-level
elements are supported.

Math blocks are started and ended with two dollar symbols `$$` and must begin and end on block boundaries.
The end dollar symbols may be on the same line as the starting dollar symbols. The contents of the math block
must be valid Latex syntax. The latex content will always be wrapped inside `\begin{displaymath} content \end{displaymath}` environment. However, this will not be the case if the content itself has a `\begin` statement.

```kramdown
$$
\begin{equation}
    \label{simple_equation}
    \alpha = \sqrt{ \beta }
    \sqrt{y^\pi}
\end{equation}
$$

$$\sum_{x=1}^5 y^\alpha = \int_a^b f(x)$$
```

$$
\begin{equation}
    \label{simple_equation}
    \alpha = \sqrt{ \beta }
    \sqrt{y^\pi}
\end{equation}
$$

$$\sum_{x=1}^5 y^\alpha = \int_a^b f_1(x)  \gamma
  \\ a \neq b \: and \: b \lt \infty
$$

Escape the dollar signs if you do not want to start math statements. User \vert in proper Latex to avoid
kramdown from parsing a table line in math that needs to use the vertical bar symbol.

Using MathJax, Kramdown should support any valid Latex syntax in kramdown docs.

There are tons of resources available for Latex syntax. [I prefer this as a solid reference](https://en.wikibooks.org/wiki/LaTeX/Basics).

### HTML Blocks

Vanilla Markdown requires HTML blocks to appear with zero indentation whatsoever. The HTML block also needs
to be surrounded entirely by blank lines in regular Markdown. Kramdown does not have this restriction. Kramdown
also allows Markdown syntax within HTML blocks.

Start an HTML block by starting a line with a non-span HTML tag. You can also use a general XML closing or
opening tag. These may be indented up to three spaces. Any span-level HTML tag will not start an HTML block in
Kramdown.

A tag's parsing is dependent on the tag and three potential ways it can be interpreted.
The tags which fall under each condition will be provided below.

* The HTML tag will be parsed as a raw HTML block.
  * If the content is to be handled as raw HTML, only HTML or XML tags parsed from the start on
    and the text will be interpreted as regular raw text until the corresponding closing tag is found or
    the end of the document is reached.
* The HTML content will be parsed as a block-level element
  * If the contents of the tag is to be interpreted as surrounding block-level elements, the
    contents will be processed by the block-level parser. All further tags will be parsed as block-level
    elements until the corresponding end tag of the block-level element is found or the end of the document
    is reached.
* The HTML content will be parsed as a span-level element
  * The content will be interpreted as span-level elements and all containing elements will be parsed as
    span-level elements until the corresponding closing tag is found or the end of the document is reached.

Kramdown parses all HTML block tags or XML tags as raw HTML blocks. This can be controlled by using the
`markdown` html attribute.

* `markdown="1"`
  * The tag is parsed as a raw HTML
* `markdown="0"`
  * The default mechanism for parsing is used
* `markdown="block"`
  * The tag contents is parsed as block-level elements
* `markdown="span"`
  * The tag contents is parsed as span-level elements

The HTML tags that are parsed as raw HTML are

* script
* style
* math
* option
* textarea
* pre
* code
* kbd
* samp
* var

The HTML tags that are parsed as block-level elements are

* applet
* button
* blockquote
* body
* colgroup
* dd
* div
* dl
* fieldset
* form
* iframe
* li
* map
* noscript
* object
* ol
* table
* tbody
* thead
* tfoot
* tr
* td
* ul

The HTML tags that are parsed as span-level elements are

* a
* abbr
* acronym
* address
* b
* bdo
* big
* cite
* caption
* code
* del
* dfn
* dt
* em
* h1 - h6
* i
* ins
* kbd
* label
* legend
* optgroup
* p
* pre
* q
* rb
* rbc
* rp
* rt
* rtc
* ruby
* samp
* select
* small
* span
* strong
* sub
* sup
* th
* tt
* var

Remember that span level elements do not start an HTML block.

I generally do not want to use HTML elements inline in Markdown/Kramdown, so I do not take notes on the
usage portions of the documentation.

## Text Markup

What follows are all span-level elements which may be utilized within block-level elements. They provide
styling or functionality to certain portions of the text.

Span-level elements without content are parsed as-is to the output of the document. That is, they do not become empty HTML elements in the output.

### Links and Images

Kramdown supports three different types of links

#### Automatic Links

Auto links simply utilize `<angle bracket syntax>` to produce a clickable link. The address text will be used
as both the target and the text itself in the output.

```kramdown
Here's a link to <https://www.google.com> or even my site right here <https://kalebmckone.com>.
```

Here's a link to <https://www.google.com> or even my site right here <https://kalebmckone.com>.

You can't specify different text in the output to represent a link using auto links.

#### Inline Links

Inline links provide all information left-to-right with respect to the target URL and the output text used to
represent the link. Use square brackets to represent the text immediately followed by the link surrounded in
parentheses. The link in the parentheses may be succeeded by one space and a title for the link surrounded by
quotes.

```kramdown
Here's a link to [google over there](https://www.google.com) or even [my site right here](https://kalebmckone.com "my site").
```

Here's a link to [google over there](https://www.google.com) or even [my site right here](https://kalebmckone.com "my site").

The link text itself is treated in the same way as span-level text. You may not create nested links in the
link text. Link text in square brackets may also be omitted entirely. That is, it is optional.

#### Reference Links

Reference links may reference link definitions to quickly create links with a particular text representations.
A link definition should exist somewhere in the document before using it as a reference.

Use two sets of square brackets. The first set of the square brackets represents the link text. The
second set contains the link URL. The link URL can not contain any closing bracket, is not case sensitive,
and line breaks and tabs are changed to be spaces. Multiple spaces are squashed to one whitespace character.
If the link URL is omitted, either by not providing the link in the square brackets or forgetting the square
brackets altogether, the link text that is provided is converted to a link while removing all bad characters
and changing whitespace characters for line breaks. When there exists a definition for the link in the
identifier, a link will be made. Else there will be no link converted.