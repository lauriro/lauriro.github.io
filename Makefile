

define TAG
---
layout: tags
title: %s
---

endef

define POST
---
layout: post
published: true
title: %s
summary:
tags: []
time: %s
---

%s
=======



endef


#ALL_TAGS = $(shell grep -Irh '^tags:' . | tr -s ' [],:' '\n' | sort -u | xargs -I@ sh -c 'echo "tags/@.md"')

export TAG

.PHONY: tags

all: tags


hello:
	# hello

#bla: $(ALL_TAGS)

tags:
	@grep -Irh '^tags:' . | \
		tr -s ' [],:' '\n' | sort -u | \
		xargs -I@ sh -c 'if [ ! -e tags/@.md ]; then echo "New tag: @"; printf -- "$$TAG" "@" > tags/@.md; fi'


tags/*.md:
	echo $@

post:
	@echo "Please provide a post title: "; \
	read title; \
	clean=$$(printf %s "$$title" | tr A-Z a-z | tr -sc [:alnum:] -); \
	FILE="_posts/`date +%Y-%m-%d-`$${clean}.md"; \
	printf -- "$$TAG" "$$title" `date +%H:%M` "$$title" > $$FILE



