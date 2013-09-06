JAVA = java
JAVAC = javac
JAR = jar

PREFIX = /usr
BIN = /bin
DATA = /share
LICENSES = $(DATA)/licenses
SHEBANG = /usr/bin/$(JAVA) -jar

PKGNAME = port-trigger
COMMAND = porttrigger



.PHONY: all
all: bin/porttrigger


bin/porttrigger: bin/porttrigger.jar
	echo "#!$(SHEBANG)" > "$@"
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
	install -dm755 -- "$(DESTDIR)$(PREFIX)$(BIN)"
	install -m755 bin/porttrigger -- "$(DESTDIR)$(PREFIX)$(BIN)/$(COMMAND)"
	install -dm755 -- "$(DESTDIR)$(PREFIX)$(LICENSES)/$(PKGNAME)"
	install -m644 COPYING LICENSE -- "$(DESTDIR)$(PREFIX)$(LICENSES)/$(PKGNAME)"


.PHONY: uninstall
uninstall:
	-rm -- "$(DESTDIR)$(PREFIX)$(BIN)/$(COMMAND)"
	-rm -- "$(DESTDIR)$(PREFIX)$(LICENSES)/$(PKGNAME)/COPYING"
	-rm -- "$(DESTDIR)$(PREFIX)$(LICENSES)/$(PKGNAME)/LICENSE"
	-rmdir -- "$(DESTDIR)$(PREFIX)$(LICENSES)/$(PKGNAME)"



.PHONY: clean
clean:
	-rm -r bin obj

