<!DOCTYPE html>
<html>
    <head>
        <#include "../header.ftl">
    </head>
    <body>
        <#include "../nav.ftl">
        <div class="container">
            <div class="row">
<h1 id="billys-guest-post">Billy's Guest Post</h1>

<p>Thanks Matthew for hosting a guest post of mine!</p>

<p>I'm going to write a post on how to get a blog project up and running inside a virtual machine using Java (and Spark).</p>

<p>1... 2... 3... Go!</p>

<p>So, assuming that you've got a working Ubuntu virtual machine you'll first need to open the Terminal. Click on the swirly icon in the top left of the screen (it's called the "dash") and type "terminal" into the search bar. You should see a list of applications, the first being called "Terminal". Open that one and you'll see a dark window with a prompt:</p>

<pre><code>ubuntu@ubuntu-VirtualBox:~$
</code></pre>

<p>The prompt is where you type your commands to be executed by the Terminal. Let's start off by installing some things:</p>

<pre><code>$ sudo apt-get update
$ sudo apt-get install git vim
</code></pre>

<p>Here <code>sudo</code> means "super user do" which tells the Terminal to run the following command as the admin user (with super powers). <code>apt-get</code> is a software package manager, it installs and uninstalls software for you. Think of it as a much better version of the Apple App Store for iOS (or Google Play, etc. etc.). The <code>update</code> command to <code>apt-get</code> tells it go and fetch the latest version of the list of available software. When that's finished we run <code>install git vim</code>, this downloads and installs the <code>git</code> and <code>vim</code> pieces of software. <code>git</code> we'll use to mnage our code in Github, <code>vim</code> we'll use to edit text files in the Terminal (if we have to).</p>

<p>We're writing a blog in Java right? That means we need to intall Java. First up we need to tell <code>apt-get</code> where on the Internet it can find the <code>java</code> package:</p>

<pre><code>$ sudo add-apt-repository ppa:webupd8team/java
</code></pre>

<p>Then we fetch the latest list of software (again) and install <code>java</code>:</p>

<pre><code>$ sudo apt-get update
$ sudo apt-get install oracle-java8-installer oracle-java8-set-default
</code></pre>

<p>You'll have to accept some licensing policies for this one, just say yes. We've now got <code>java</code> but we'll also need <code>mvn</code>. Maven (<code>mvn</code>) is the package manager for Java. It's a bit like <code>apt-get</code> in that it downloads and installs software for you, but it only wqworks for Java things, and it also does more stuff (like compiling and packaging).</p>

<p>Unfortunately, <code>mvn</code> doesn't come with a easy-to-use installer like the other things do. We'll have to download and install it ourselves. First visit the <a href="https://maven.apache.org/download.cgi">Maven website</a> and download the latest version, you're looking for the <code>.tar.gz</code> binary version. You'll now have a file called something like <code>apache-maven-3.3.9-bin.tar.gz</code> in your Downloads folder. Jump into the Terminal again and type:</p>

<pre><code>$ tar xvf ~/Downloads/apache-maven-3.3.9-bin.tar.gz
$ sudo mv apache-maven-3.3.9-bin.tar.gz /usr/local/mvn
</code></pre>

<p><code>tar</code> is the command to "Tape ARchive" something, the names comes from when computers used to have giant reels of tape for backup purposes. <code>tar</code> packages lots of files together to get them ready for the tape. The <code>xvf</code> means "extract" "verbosely" from this "file". The <code>mv</code> command moves the resulting folder to a new folder <code>/usr/local/mvn</code>, this destination is up to you, you can pick a different place, just remember where you've put it.</p>

<p>We've downloaded Maven but now we need to install it. We need to tell the Terminal that there's a program called <code>mvn</code> that lives in the <code>/usr/loca/mvn</code> directory. To do that we're going to modify our <code>$PATH</code>. The <code>PATH</code> is a variable used by the Terminal to discover where software is installed. It's a list of directories to look for executable files in, each directory is separated by a colon. To see what your current <code>PATH</code> looks like run:</p>

<pre><code>$ echo $PATH
</code></pre>

<p>We need to add our directory to this list:</p>

<pre><code>$ export PATH=$PATH:/usr/local/mvn/bin
</code></pre>

<p><code>export</code> means save this variable for the lifetime of this Terminal (i.e. when you close the window down it will forget your changes). <code>PATH=$PATH</code> means set <code>PATH</code> to be whatever <code>PATH</code> already was. Then <code>:/usr/local/mvn/bin</code> says "add this directory to the end of the <code>PATH</code>.</p>

<p>We have one more installation step to do. Our export will only hold until we close our Terminal window. That's no good, we want to use <code>mvn</code> in all of our Terminals. So we add the export line to our <code>.bashrc</code> file. This file is a script that your Terminal executes everytime it opens. You can edit your <code>.bashrc</code> in a text editor (like <code>vim</code>, or <code>gedit</code>):</p>

<pre><code>$ gedit ~/.bashrc
</code></pre>

<p>OR, you can do this:</p>

<pre><code>$ echo "export PATH=$PATH:/usr/local/mvn/bin" &gt;&gt; ~/.bashrc
</code></pre>

<p>The <code>echo</code> means print to the console whatever I type. The <code>&gt;&gt;</code> means intercept the output of the command on the left and append it to the file on the right.</p>

<p>To make sure everything's working as planned, close your Terminal window and open it back up. Now type:</p>

<pre><code>$ mvn -v
</code></pre>

<p>You should see some output about version numbers. If not, panic.</p>

<p>Now we need to grab your code from GitHub:</p>

<pre><code>$ cd ~/Desktop
$ git clone https://github.com/CodeGuild-co/DOMAIN.git
$ cd DOMAIN
</code></pre>

<p>First we change into the Desktop directory, then we ask <code>git</code> to download (or clone) the repo in GitHub to our local machine. We then change into the newly downloaded repo. You'll need to change <code>DOMAIN</code> to be your personal CodeGuild domain (e.g. <code>mw</code> for this blog).</p>

<p>Now let's use <code>mvn</code> to install our project's dependencies:</p>

<pre><code>$ mvn package
</code></pre>

<p>This might take a while…</p>

<p>Ready?</p>

<p><code>mvn</code> will have downloaded everything it needs and then compiled your blog's sourec code into the <code>target</code> directory. You can now run a local copy of your blog like this:</p>

<pre><code>$ java -cp target/classes:target/dependency/* Main
</code></pre>

<p>When that's running you can visit <a href="http://localhost:3000">localhost:3000</a> in your browser and see a local-only version of your blog.</p>

<p>In the Terminal use Ctrl-c to quit the server and regain control.</p>

<p>Make a change to your blog, then re-compile, and re-serve:</p>

<pre><code>$ mvn package
$ java -cp target/classes:target/dependency/* Main
</code></pre>

<p>Once you're happy with all of your changes and you'd like to push them up live to your blog you need to tell <code>git</code> what you've done:</p>

<pre><code>$ git add .
$ git commit -m 'WHAT HAVE YOU CHANGED?'
$ git push
</code></pre>

<p>The <code>git add</code> command says "hey git, I've changed all these files". <code>git commit</code> then says "package all these changes into a single group (called a commit) and describe those changes with a message. You'll have to change the <code>WHAT HAVE YOU CHANGED?</code> part to explain your commit. Finally, <code>git push</code> tells git to push your changes back into GitHub, you'll probably have to type in your GitHub username and password.</p>

<p>Wait for Heroku to pick the changes up and then visit your blog and see your lovely changes.</p>

<p>I hope that works!</p>
          </div>
        </div>
    </body>
</html>
