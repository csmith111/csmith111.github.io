---
layout: post
title:  "Blogging - using GitHub Pages"
date:   2016-02-06 13:00:28 -0500
summary: My notes on setting up a blogging site using Jekyll and GitHub Pages. It is always amazing when the "magic" we call "technology" works!
categories: jekyll update
---

After a long time I finally decided to create a blog. One of my friends suggested that I should use GitHub Pages to create the site. Apart from regular HTML, GitHub Pages supports [Jekyll][Jekyll] (a static site generator). Amazing how we have come back full circle to realizing that static sites are great and you don't need to have a database running or other complex infrastructure. For many simple situations like a blog site or a project documentation site a "static HTML site" is a simpler, more secure and performant option.
Leveraging Markdown for templates to simplify content editing; and using a site generator to generate the HTML from the markdown template and control the over all layout and look and feel of the site (of course we use css as well) seems to be a reasonable option. That in a nutshell is what a static site generator (in this case Jekyll) will do for you.

Currently along with Jekyll, Github uses `kramdown` for processing markdown templates and`rouge` for syntax highlighting. And I ended up using `MathJax` for displaying equations.

Here are the steps that I took based on information that I found on [git pages documentation][github-pages-doc], [using Jekyll with pages][Jekyll-and-Pages], [Jekyll tips][Jekyll-tips] and [pages help][github-pages-help]. As I am writing this it is interesting to see how many different things you need to understand, version control (git), static site generation (Jekyll), HTML CSS, markdown and perhaps some Ruby as well. You may not need to use all this if you get lucky, but I find luck is overrated when it comes to computers and code.

* First create a github account with a
* Create a repository on github
* Install Ruby, Jekyll and Bundler on your computer
* Create a local folder to store the repo and preview content locally with Jekyll and link it to the git repository
* Create the site and content  locally.
* Push your content.

### Create a github account

{% highlight shell %}
username: "username"
{% endhighlight %}

For a quick introduction to GitHub using GitHub for version control you can use [this great introduction][github-introduction].

### Create a repository

{% highlight Haskell %}
repository: "username".github.io
{% endhighlight %}

The content from the master branch will be use to build and publish the site.

*Note: that github blogs come in two flavors: User pages and Project pages.
So I decided to try User Pages initially.*

I plan to use Project pages as well and will update this documentation once I implement it using the [instructions for setting up project pages][setting-up-project-pages].

Once the repo is set up you can generate pages with the automatic generator. I did not see this option initially or I would have tried it, perhaps I will do this anyway soon and report on the experience.

The other option is to use Jekyll to generate your blog.
Here it probably does make sense to set up Jekyll locally and then push your content to github when you are ready to publish.

Finally you need to make sure that you activate the website generation. On GitHub go to the username.github.io repository, choose Settings, then the GitHub Pages section in order to activate the website generation.

### Install Ruby, Jekyll and Bundler on your computer
I found the instructions on [using Jekyll with pages][Jekyll-and-Pages] pretty much worked as is.

### Create a local folder to store the repo and preview content locally with Jekyll.

Create a local folder with and git clone your blog repository.
`git clone "https://github.com/username/username.github.io"`

To check that you are in sync with the repo and GitHub pages are working you just push a simple index.html page and preview it online as follows:

{% highlight shell%}
cd username.github.io
echo "Hello Blog" >index.html
git add --all
git commit -m "Initial commit"
git push -u origin master
{% endhighlight %}

If all these steps worked you should be able to navigate to
`https://github.com/username.github.io` and see your blog is live!

Essentially create a Gemfile with
{% highlight shell%}
source 'https://rubygems.org'
gem 'github-pages'
{% endhighlight %}

This will install the [GitHub Pages Ruby Gem][GHPages-Gem]
and this should ensure that you have the same version of Jekyll as github. And you can run `bundle update` periodically to keep in sync.

### Set up Jekyll and create the site.

Now open up a terminal change into your site directory and run:
{% highlight shell%}
$jekyll new .
{% endhighlight %}

You can preview your site using `jekyll serve`.
Now navigate to `http://localhost:4000` to see the default local site you have just created.

### Create content
Now that your site is up and running you can start modifying it and creating content.

* Folder structure
  Jekyll creates a default folder structure which currently
  looks like this for me.
{% highlight shell%}
├── Gemfile
├── README.md
├── config.yml
├── includes
├── layouts
│   ├── default.html
│   ├── page.html
│   └── post.html
├── posts
│   ├── 2016-02-06-FirstBlogPost.markdown
│   └── 2016-02-06-welcome-to-jekyll.markdown
├── sass
├── site
├── about.md
├── css
├── feed.xml
└── index.html
{% endhighlight %}

(I have removed the underscore from the names of all the folders for this blog.)

* Files to modify: Now you can start modifying the files as required. Start with about.md and config.yml.

* Creating Posts: Now you can create your first post. Posts
are markdown files that are stored in the posts directory.
The file names have to look like `yyyy-mm-dd-postname.md` so for
example you could create a file with the name
`2016-01-12-firstBlogPost.md`.

{% highlight markdown%}
---
layout: post
title:  "A New Blog!"
date:   2016-02-06 13:00:28 -0500
categories: jekyll update
---
Your markdown content goes here...
{% endhighlight %}

* Creating an index.html
Finally you need to create an index.html file that will be the file that github directs you to when you go to
`https://github.com/username.github.io`. We had already done this earlier but now we need to update this file so it provides the links to all the static files you have generate.

I completely missed this step and spent a lot of time hacking but failed to succeed in seeming the generated pages. I sent a note to GitHub and was pleasantly surprised by a response the next day from John Greet (GitHub staff) helping me resolve the issue. (It is amazing how little we appreciate the value of good support, so thank you John!)
The two points he made was that the generated site pages go to standard locations like:
`https://username.github.io/jekyll/update/2016/02/06/FirstBlogPost.html` which mirror the structure of the sites directory or the output of the Jekyll build.
So you can always access the pages from there. However a cleaner solution is to create an index.html file that points to the correct locations. You place the index.html at the root of the directory and now you access this index.html from: `https://username.github.io/`.
John directed me to a fairly simple example:[index.html][index-sample]
and I was good to go.

### Push your content to GitHub
Create a .gitignore file which contains a list of files/folder you
do not wish to check in. This is what my .gitignore currently
contains.

{% highlight shell%}
site/
.sass-cache/
.jekyll-metadata
Gemfile.lock
.DS_Store
{% endhighlight %}

Please note that the entry above should be "underscore"site
but my editor (atom) messes up the syntax highlighting if I do
that!!

Also note that I am not pushing the site that is generated locally,
GitHub will do this automagically for you when you push your changes to the site.

This is a standard sequence to push you content once you are satisfied with it.

{% highlight shell%}
git add --all
git commit - m "Initial commit"
git push -u origin master
{% endhighlight %}

If you are seeing this page, then all of the above described magic worked! I would love it if you could try this out and let me know if there are any inaccuracies in my description.

### Customizing your site

I have not spent much time customizing the site yet. But we can start by modifying the files in the layout folder and updating the config.yml file.

### Getting Math equations to display

This was another adventure for me, that worked out fine in the end.

I used the config recommended by cwoebker[cwoebker]:
Although he uses rdisount instead of kramdown.

The is a [link on the Jekyll site that refers to mathJax][JekyllMathJax]essentially points to:
[a page by Gaston Sanchez][GastonSanchez]
 which currently seems to be broken in terms of the equations not working correctly?

Anyway all I did was include the following in my post.html file in the `_layouts` folder.

{% highlight html%}
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js"></script>
<script type="text/x-mathjax-config">
    MathJax.Hub.Config({
        jax: ["input/TeX","output/HTML-CSS"],
        extensions: ["tex2jax.js"],
        tex2jax: {
        inlineMath: [ ['$','$'], ["\\(","\\)"] ],
        displayMath: [ ['$$','$$'], ["\\[","\\]"] ],
        processEscapes: true
        },
    });
    </script>

    <script type="text/x-mathjax-config">
    MathJax.Hub.Config({
        tex2jax: {
        skipTags: ['script', 'noscript', 'style', 'textarea', 'pre']
        }
    });

    MathJax.Hub.Queue(function() {
        var all = MathJax.Hub.getAllJax(), i;
        for(i=0; i < all.length; i += 1) {
            all[i].SourceElement().parentNode.className += ' has-jax';
        }
    });
    </script><script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js"></script>
    <script type="text/x-mathjax-config">
        MathJax.Hub.Config({
            jax: ["input/TeX","output/HTML-CSS"],
            extensions: ["tex2jax.js"],
            tex2jax: {
            inlineMath: [ ['$','$'], ["\\(","\\)"] ],
            displayMath: [ ['$$','$$'], ["\\[","\\]"] ],
            processEscapes: true
            },
        });
        </script>

        <script type="text/x-mathjax-config">
        MathJax.Hub.Config({
            tex2jax: {
            skipTags: ['script', 'noscript', 'style', 'textarea', 'pre']
            }
        });

        MathJax.Hub.Queue(function() {
            var all = MathJax.Hub.getAllJax(), i;
            for(i=0; i < all.length; i += 1) {
                all[i].SourceElement().parentNode.className += ' has-jax';
            }
        });
        </script>
{% endhighlight %}

Now you can do something like:

**And God said:**

$$
\begin{equation}
\begin{aligned}
\frac{\partial\mathcal{D}}{\partial t} \quad & = \quad \nabla\times\mathcal{H},   & \quad \text{(Faraday's Law)} \\[5pt]
\frac{\partial\mathcal{B}}{\partial t} \quad & = \quad -\nabla\times\mathcal{E},  & \quad \text{(Ampère's Law)}   \\[5pt]
\nabla\cdot\mathcal{B}                 \quad & = \quad 0,                         & \quad \text{(Gauss Law)}   \\[5pt]
\nabla\cdot\mathcal{D}                 \quad & = \quad 0.                         & \quad \text{(Colomb Law)}
\end{aligned}
\end{equation}
$$

**and there was light!**

### Syntax highlighters
Github uses kramdown as its markdown template processing and rouge for syntax highlighting. You can see that rouge supports a long [list of languages][Rouge examples]. You can also find some documnetation in [the rouge wiki][Rouge].

### Using GitHub project pages for blogging

This is a less documented solution, but it is worth looking into if you want
to maintain multiple blogs on different topics. Or use Jekyll to maintain
documentation for your projects.
Create a repository to host your new site. The name of the repository will be come part of the url of your website so choose a good name for the repository.

Now locally make a folder with the same name as the repository and clone the repository locally.

Create a local folder with and git clone your blog repository.
Then change into that repository and create an orphan branch as follows:
{% highlight shell%}
git clone "https://github.com/username/repositoryname.git"
cd repositoryname
git checkout --orphan gh-pages
{% endhighlight %}

Add your blog files. And check in your files using:
{% highlight shell%}
git add --all
git commit - m "Initial commit"
git push -u origin gh-pages
{% endhighlight %}

That is it! You site should be available at:
http://username.github.io/repositoryname/

Well you are almost done. The links to pages in your site may not work.
In your config.yml file make sure that you set up:

{% highlight shell%}
baseurl: /repositoryname
url: "http://username.github.io/"
{% endhighlight %}

Also all your links now need to be done as follows:
{% highlight html%}
<h2><a href="{{ site.baseurl }}{{xml_escape post.url }}">{{ post.title }}</a></h2>
{% endhighlight %}

{% highlight html%}
<a href="'{'{ site.baseurl }}'{'{post.url }}">'{'{ post.title }}</a></h2>
{% endhighlight %}

Notice how we have prepended the $site.baseurl$ to the $post.url$ to ensure that the generated links have the correct url. (Please ignore the $'$ they are there just to escape the liquid template procesing until I find the right escape character.)

[Jekyll-and-Pages]: https://help.github.com/articles/using-jekyll-with-pages/
[github-pages-doc]: https://pages.github.com/
[github-pages-help]: https://help.github.com/categories/github-pages-basics/
[setting-up-project-pages]:https://help.github.com/articles/creating-project-pages-manually/
[Jekyll]:http://jekyllrb.com/
[Jekyll-tips]:http://jekyll.tips/guide/github/
[github-introduction]:https://try.github.io/levels/1/challenges/1
[Jekyll-tips-blogging]:http://jekyll.tips/guide/blogging/
[GHPages-Gem]:https://github.com/github/pages-gem
[index-sample]:[https://github.com/kneath/kneath.github.com/blob/master/index.html

[cwoebker]:http://cwoebker.com/posts/latex-math-magic
[JekyllMathJax]:http://jekyllrb.com/docs/extras/#math-support
[GastonSanchez]:http://gastonsanchez.com/opinion/2014/02/16/Mathjax-with-jekyll/
[Rouge]:https://github.com/jneen/rouge/wiki
[Rouge Examples]:http://rouge.jayferd.us/demo
