langs=en ru

all: $(langs)

$(langs:=-clean):
	make -C $(@:-clean=) clean

$(langs):
	make -C $@ html

clean: $(langs:=-clean)

.PHONY: $(langs) $(langs:=-clean)
