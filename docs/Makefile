langs=en ru

all: $(langs)

$(langs:=-clean):
	make -C $(@:-clean=) clean

$(langs):
	make -C $@ html

clean: $(langs:=-clean)

dep:
	aptitude install fonts-font-awesome fonts-lato libjs-modernizr

.PHONY: $(langs) $(langs:=-clean)
