## What is this project?

**[The Magic Book Project](https://github.com/runemadsen/Magic-Book-Project) is an open-source framework that facilitates the design and production of electronic and print books for authors.**

Here’s a circa-2008 scenario for you.  An author is excited to hear that a big company has decided to publish his or her book. The author sits down and types a lot of text into Microsoft Word.  The publisher takes that text and “typesets” it using Adobe InDesign, painstakingly laying out each individual page by hand. To market the book, the author decides to post an 
excerpt from the book online as HTML and performs an elaborate contortion of copying/pasting and reformatting.   The book is published and is offered for sale for fifty dollars.  An ebook is also for sale for ﬁfty dollars.  The author receives a few dollars when a book is sold.  Anyone on the internet, however, can easily download a free, illegal PDF version of the book.

See any problems with this scenario?

This is is the impetus behind the Magic Book Project, developed by a small team of ITP faculty, researchers, and students.The Magic Book Project seeks to help authors self-publish in variety of formats, making books available to the widest audience possible at the cheapest prices.

Rather than type into a word processor, the Magic Book Project allows an author to write a book once (using ASCIIDOC, a simple text document format) and procedurally generate the layout for a variety of formats using modern code-based design tools, such as CSS, the stylesheet standard.   Write your book once, press a magic button, and out come multiple versions: printed hardcopy, digital PDF, HTML, MOBI, and EPUB.


## Installing the App

1. Clone this repository

        $ git clone https://github.com/runemadsen/Magic-Book-Project.git
        $ cd Magic-Book-Project

2. Use Ruby 1.9.3. To manage multiple rubies, install either [RVM](https://rvm.io//), [rbenv](https://github.com/sstephenson/rbenv), or [chruby](https://github.com/postmodern/chruby).
3. Run bundler to install gems (if you don't have bundler do `$ gem install bundler`).

        $ bundle install

   One of the gems we use, Nokogiri, has some system pre-requirements. Under Ubuntu 12.04, before you run `bundle install` you need to install the development libraries for xml and xslt with 

        $ sudo apt-get install libxml2-dev libxslt1-dev

4. We are using a custom build of the asciidoc gem. To keep track of changes to
this gem use git [submodules](http://git-scm.com/book/en/Git-Tools-Submodules).
From the root of the repository run the following two commands to initialize
the submodule and then get any updates.

        $ git submodule init
        $ git submodule update

5. Now you need the asciidoc program. We recommend installing asciidoc with
[homebrew](http://mxcl.github.com/homebrew/). Once you have homebrew installed
get the asciidoc keg like so

        $ brew install asciidoc

    Under Ubuntu, you'll need to install asciidoc with

        $ sudo apt-get install asciidoc

### Notes

If your book will include code blocks you'll need to install pygments for
syntax highlighting.

        $ sudo easy_install Pygments

    Under Ubuntu, it's probably better to install it as a system package:

        $ sudo apt-get install python-pygments

## To run the app

1. `cd Magic-Book-Project`
2. `shotgun config.ru`
3. Then visit in your browser one of these urls: 

 * localhost:9393/create_html/:filename 
 * localhost:9393/create_html_chapters/:filename
 * localhost:9393/create_pdf/:filename

   where `:filename` is the path to an `.asc`, `.asciidoc` or `.txt` file.

   Note: For the time being, the asciidoc gem uses Prince XML for PDF
   rendering (we are using this until we find a good, open-source HTML to PDF
   renderer). If you want to produce PDF output, you'l need to download and
   install it from http://www.princexml.com/download/.

If it's been a while since you've used this app, update the asciidoc gem by
running `$ git submodule update`.
