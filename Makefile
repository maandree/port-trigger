PREFIX = /usr
BIN = /bin

COMMAND = porttrigger

JAVA = /usr/bin/java
JAVAC = javac
JAR = jar



.PHONY: all
all: bin/porttrigger


bin/porttrigger: bin/porttrigger.jar
	echo "#!$(JAVA) -jar" > "$@"
	cat "$<" >> "$@"
	chmod a+x "$@"

bin/porttrigger.jar: META-INF/MANIFEST.MF obj/PortTrigger.class
	mkdir -p bin
	$(JAR) cfm "$@" META-INF/MANIFEST.MF -C obj PortTrigger.class

obj/%.java: src/%.java
	mkdir -p $(shell dirname "$@")
	cp "$<" "$@"
	sed -i 's/@COMMAND@/$(COMMAND)/g' "$@"

obj/%.class: obj/%.java
	$(JAVAC) -g -cp obj -s obj -d obj "$<"



.PHONY: install
install: bin/porttrigger
	install -D -- "$(DESTDIR)$(PREFIX)$(BIN)"
	install -m755 bin/porttrigger -- "$(DESTDIR)$(PREFIX)$(BIN)/$(COMMAND)"


.PHONY: uninstall
uninstall:
	rm -- "$(DESTDIR)$(PREFIX)$(BIN)/$(COMMAND)"



.PHONY: clean
clean:
	-rm -r bin obj

