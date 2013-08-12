
DAT=dat
WWW=www
IMAGES=$(WWW)/images
STATIC=$(addprefix $(WWW)/,head.html table.html foot.html)
vpath %.html $(WWW)/
vpath %.css $(WWW)/
vpath %.pl bin/
DIR:=$(shell grep "^dir" gitline.conf | sed 's/dir=//')
URL:=$(shell grep "^url" gitline.conf | sed 's/url=//')

all: index.html

annotatedLog.txt:
	bin/gitmetric-treeshare.sh $(DIR) > annotatedLog.txt

gitline.conf: annotatedLog.txt
	bin/parseAnnotatedLog_conf.pl < annotatedLog.txt

sparks: gitline.conf annotatedLog.txt
	mkdir -p $(IMAGES) $(DAT)
	bin/parseAnnotatedLog_spark.pl < annotatedLog.txt
	bin/log_sparks.sh $(IMAGES) $(DAT)
	touch sparks

bin/parseAnnotatedLog_html.pl:
	sed 's*%URL%*$(URL)*' bin/parseAnnotatedLog_html.plt > bin/parseAnnotatedLog_html.pl
	chmod a+x bin/parseAnnotatedLog_html.pl

topbar.html: gitline.conf
	bin/topbar.sh

$(WWW)/index.html: annotatedLog.txt head.html topbar.html foot.html sparks parseAnnotatedLog_html.pl
	bin/parseAnnotatedLog_html.pl < annotatedLog.txt > $(WWW)/body.html
	cat $(WWW)/head.html $(WWW)/topbar.html $(WWW)/table.html $(WWW)/body.html $(WWW)/foot.html > $(WWW)/index.html

colors.css: gitline.conf
	grep "^author" gitline.conf | sed 's/^author /./;s/=/ {background:/;s/$/}/' > $(WWW)/colors.css

$(STATIC):;

clean:
	rm -f $(IMAGES)/* $(DAT)/* $(WWW)/colors.css $(WWW)/index.html sparks bin/parseAnnotatedLog_html.pl $(WWW)/topbar.html

cclean:
	rm gitline.conf
	rm annotatedLog.txt