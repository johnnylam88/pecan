The goal is to provide enough infrastructure to build `epkg' with package
profile support.  The remaining packages in the pecan source tree can be
built either using this same infrastructure, or by using encap profiles.
See encap_profile(5) for more information.

Currently, the dependency chain for `epkg' looks like:

	gzip
	tar
	expat
	libiconv
	pkg-config
	gettext-runtime
	sed
	zlib
	perl
	openssl
	curl
	m4
	epkg
