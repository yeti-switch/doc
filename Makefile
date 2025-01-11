langs=en

all: $(langs)

$(langs:=-clean):
	make -C $(@:-clean=) clean

$(langs):
	make -C $@ html

linkcheck:
	make -C $(langs) linkcheck

spellcheck:
	make -C $(langs) spelling

clean: $(langs:=-clean)

dep:
	aptitude install fonts-font-awesome fonts-lato libjs-modernizr

.PHONY: $(langs) $(langs:=-clean)
