MAKE="make"
INSTALL="install"
TAR="tar"
GREP="grep"
NODE="node"
NPM="npm"
DESTDIR="./dist"
PKG_VERSION := $( $(GREP) -Po '(?<="version": ")[^"]*' )
TMPDIR := $(shell mktemp -d)
# default modules
MODULES="php"

all: builddirs npm_dependencies swig htmlmin min-css min-js copy-img copy-htaccess submodules
	
swig:
	$(NODE) node_modules/swig/bin/swig.js render -j dist.json templates/faq.swig > $(CURDIR)/build/faq.html 
	$(NODE) node_modules/swig/bin/swig.js render -j dist.json templates/index.swig > $(CURDIR)/build/index.html 
	$(NODE) node_modules/swig/bin/swig.js render -j dist.json templates/tools.swig > $(CURDIR)/build/tools.html 
	$(NODE) node_modules/swig/bin/swig.js render -j dist.json templates/notfound.swig > $(CURDIR)/build/notfound.html 

htmlmin:
	$(NODE) node_modules/htmlmin/bin/htmlmin $(CURDIR)/build/index.html -o $(CURDIR)/build/index.html 
	$(NODE) node_modules/htmlmin/bin/htmlmin $(CURDIR)/build/faq.html -o $(CURDIR)/build/faq.html 
	$(NODE) node_modules/htmlmin/bin/htmlmin $(CURDIR)/build/tools.html -o $(CURDIR)/build/tools.html 
	$(NODE) node_modules/htmlmin/bin/htmlmin $(CURDIR)/build/notfound.html -o $(CURDIR)/build/notfound.html 

installdirs:
	mkdir -p $(DESTDIR)/ $(DESTDIR)/img/backgrounds
ifneq (,$(findstring php,$(MODULES)))
	mkdir -p $(DESTDIR)/classes $(DESTDIR)/includes
endif
ifneq (,$(findstring moe,$(MODULES)))
	mkdir -p $(DESTDIR)/moe/{css,fonts,includes,js,login,panel/css/font,panel/css/images,register,templates}
endif
	
min-css:
	$(NODE) $(CURDIR)/node_modules/.bin/cleancss --skip-rebase --O1 specialComments:0 $(CURDIR)/static/css/uguu.css --output $(CURDIR)/build/uguu.min.css

min-js:
	echo "// @source https://github.com/nokonoko/uguu/tree/master/static/js" > $(CURDIR)/build/uguu.min.js 
	echo "// @license magnet:?xt=urn:btih:d3d9a9a6595521f9666a5e94cc830dab83b65699&dn=expat.txt Expat" >> $(CURDIR)/build/uguu.min.js
	$(NODE) $(CURDIR)/node_modules/.bin/uglifyjs  --screw-ie8 ./static/js/app.js >> $(CURDIR)/build/uguu.min.js 
	echo "// @license-end" >> $(CURDIR)/build/uguu.min.js

copy-img:
	cp -v $(CURDIR)/static/img/*.svg $(CURDIR)/build/img/
	cp -v $(CURDIR)/static/img/*.png $(CURDIR)/build/img/
	cp -v $(CURDIR)/static/img/backgrounds/*.jpg $(CURDIR)/build/img/backgrounds/
	cp -v $(CURDIR)/static/img/favicon.ico $(CURDIR)/build/favicon.ico

copy-htaccess:
	cp -v $(CURDIR)/static/.htaccess $(CURDIR)/build/

copy-php:
ifneq ($(wildcard $(CURDIR)/static/php/.),)
	cp -rv $(CURDIR)/static/php/* $(CURDIR)/build/
else
	$(error The php submodule was not found)
endif

copy-moe:
ifneq ($(wildcard $(CURDIR)/moe/.),)
	cp -rv $(CURDIR)/moe $(CURDIR)/build/
else
	$(error The moe submodule was not found)
endif

install: installdirs
	cp -rv $(CURDIR)/build/* $(DESTDIR)/
	cp -rv $(CURDIR)/build/.htaccess $(DESTDIR)/

dist:
	DESTDIR=$(TMPDIR)/uguu-$(PKGVERSION)
	export DESTDIR
	install
	$(TAR) cJf uguu-$(PKG_VERSION).tar.xz $(DESTDIR)
	rm -rf $(TMPDIR)
	
clean:
	rm -rvf $(CURDIR)/node_modules 
	rm -rvf $(CURDIR)/build
	
uninstall:
	rm -rvf $(DESTDIR)/
	
npm_dependencies:
	$(NPM) install

builddirs:
	mkdir -p $(CURDIR)/build $(CURDIR)/build/img/backgrounds
ifneq (,$(findstring php,$(MODULES)))
	mkdir -p $(CURDIR)/build/classes $(CURDIR)/build/includes
endif
ifneq (,$(findstring moe,$(MODULES)))
	mkdir -p $(CURDIR)/build/moe/{css,fonts,includes,js,login,panel/css/font,panel/css/images,register,templates}
endif

submodules:
	$(info The following modules will be enabled: $(MODULES))
ifneq (,$(findstring php,$(MODULES)))
	$(MAKE) copy-php
endif
ifneq (,$(findstring moe,$(MODULES)))
	$(MAKE) copy-moe
endif
