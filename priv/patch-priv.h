Fix inverted tests.

--- priv.h.orig	1997-07-08 02:19:07.000000000 -0400
+++ priv.h	2012-11-17 00:59:48.000000000 -0500
@@ -140,10 +140,10 @@
 #ifndef HAVE_STRERROR
 char   *strerror(int errnum);
 #endif
-#ifdef HAVE_STRSPN
+#ifndef HAVE_STRSPN
 size_t  strspn(const char *s, const char *charset);
 #endif
-#ifdef HAVE_STRTOUL
+#ifndef HAVE_STRTOUL
 unsigned long strtoul(const char *nptr, char **endptr, int base);
 #endif
 
