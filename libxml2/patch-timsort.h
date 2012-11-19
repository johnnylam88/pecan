__builtin_clzll was introduced in GCC 4.4.5.

--- timsort.h.orig	2012-09-11 01:56:52.000000000 -0400
+++ timsort.h	2012-11-19 01:52:44.000000000 -0500
@@ -40,7 +40,7 @@
 int compute_minrun(uint64_t);
 
 #ifndef CLZ
-#ifdef __GNUC__
+#if __GNUC__ > 4 && __GNUC_MINOR__ > 4 && __GNUC_PATCHLEVEL >= 5
 #define CLZ __builtin_clzll
 #else
 
