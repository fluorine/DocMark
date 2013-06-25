DocMark (v 0.1 beta)
====================
DocMark is another lightweight markup language.

This Ruby implementation is able to traslate 
DocMark to HTML, but it's easy to parse it in 
any programming language using just some
regular expressions.

It's like a Markdown dialect, but it's more
flexible and it attepts to process a slighty
different paintext formatting.

So, what's new? The features
----------------------------
DocMark attempts to be more flexible than MarkDown
and other lightweight markup languages.

For example, you can write an H1 header in
**MarkDown** this way:

	# Header 1

Or just:

	Header 1
	========

However, **DocMark** allows you to use any of these
characters for headers, so you can have your style:

	+ Header H1 +++++++++++++

	# Header H1 #############

	- Header H1 -------------

One on these symbols at beginning means H1, two
symbols mean H2, and so on.

	# H1 ##########

	++ H2 +++++++++

	--- H3 --------

The second sequence of characters will always be
ignored because it's only useful for visibility
as raw text, but the last sequence itself is 
not requiered anyway (like in Markdown):

	+++ H3

Spaces between sequences and text are ignored too, 
so you have even more options for format:

	---         H3        ---

Usage of docmark.rb
-------------------
This script converts DocMark text to HTML.

	docmark.rb sample.txt

This command produces a **sample.html** document.

TODO list
---------
Implemented features:
	* Headers
	* Paragraphs

Future features:
	* Line breaks (two spaces at end, like in Markdown)
	* Horizontal line
	* **Bold** and __Italics__
	* Bollets
	* Links between sections
	* HTTP links
	* Pictures
