
DAT=dat
WWW=www
IMAGES=$(WWW)/images
STATIC=$(addprefix $(WWW)/,head.html foot.html)
vpath %.html $(WWW)/
vpath %.css $(WWW)/

all: index.html

annotatedLog.txt:
	bin/gitmetric-treeshare.sh

gitline.conf: annotatedLog.txt
	bin/parseAnnotatedLog_conf.pl < annotatedLog.txt

sparks: gitline.conf annotatedLog.txt
	bin/parseAnnotatedLog_spark.pl < annotatedLog.txt
	bin/log_sparks.sh $(IMAGES) $(DAT)
	touch sparks

$(WWW)/index.html: annotatedLog.txt head.html foot.html sparks
	bin/parseAnnotatedLog_html.pl < annotatedLog.txt > $(WWW)/body.html
	cat $(WWW)/head.html $(WWW)/body.html $(WWW)/foot.html > $(WWW)/index.html

colors.css: gitline.conf
	grep "^author" gitline.conf | sed 's/^author /./;s/=/ {background:/;s/$/}/' > $(WWW)/colors.css

$(STATIC):;