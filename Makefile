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
	$(JAR) cfm "$@" $^

obj/%.class: src/%.java
	mkdir -p obj
	$(JAVAC) -g -cp src -s src -d obj $<



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

