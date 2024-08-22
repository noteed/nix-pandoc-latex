# A Nix expression to build a PDF file from Mardown, using Pandoc and LaTeX

This is a minimal repository to show a Nix expression that creates a PDF using
Pandoc.

If you have Nix, you can clone this repository (`cd` into it) and run
`nix-build`. You'll have more output than the code block below the first time
you run the command, since Nix will have to download all the necessary
dependencies.

```
$ nix-build 
this derivation will be built:
  /nix/store/3bw34fhj54q7jnbsk14hmqklff244dyc-hello.drv
building '/nix/store/3bw34fhj54q7jnbsk14hmqklff244dyc-hello.drv'...
/nix/store/dgllxyjaq42adp5rjzawjwbfy0icl1iv-hello
```

The last line above shows where the build artifact is located. In addition you
should have a symlink called `result` in the current directory; it points to
the same location.

```
$ ls -la
total 44
drwxr-xr-x   4 thu users  4096 Aug 22 23:58 .
drwxrwxr-x 410 thu users 20480 Aug 22 23:11 ..
-rw-r--r--   1 thu users  1891 Aug 22 23:50 default.nix
drwxr-xr-x   8 thu users  4096 Aug 22 23:59 .git
-rw-r--r--   1 thu users    36 Aug 22 23:27 hello.md
drwxr-xr-x   2 thu users  4096 Aug 22 23:11 nix
-rw-r--r--   1 thu users  1407 Aug 22 23:58 README.md
lrwxrwxrwx   1 thu users    49 Aug 22 23:50 result -> /nix/store/dgllxyjaq42adp5rjzawjwbfy0icl1iv-hello
```

There, you should have our example PDF, that you can then open:

```
$ ls result/
hello.pdf

$ mupdf result/hello.pd
```
