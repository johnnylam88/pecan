--------------------------------------------------------------------------------
Pecan is `encap' from a slightly different point of view.

Pecan is a software packaging idea that implements some of the concepts of
[package views][1] using the [Encap package format][2].

Most of the problems with software installations occur when something needs to
be upgraded for some reason, e.g., security fix, bug fix, new features, etc.

A pecan package should store its immutable files within a single package
directory, e.g., /usr/local/pecan/postfix-2.4.5.

A pecan package should store its configuration files in an `etc' directory
shared with other pecan packages.

A pecan package should store its temporary state files in a `var' directory
shared with other pecan packges.

A Pecan installation can be managed with Encap package tools, e.g., [epkg][3].

  [1]: http://www.netbsd.org/docs/software/pkgviews.pdf
  [2]: http://www.encap.org/specification.html
  [3]: http://www.encap.org/epkg/
