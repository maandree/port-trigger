JAVA=/usr/bin/java
JAVAC=javac
JAR=jar



.PHONY: all
all: bin/porttrigger


bin/porttrigger: bin/porttrigger.jar
	echo "#!$(JAVA) -jar" > "$@"
	cat "$<" >> "$@"

bin/porttrigger.jar: META-INF/MANIFEST.MF obj/PortTrigger.class
	mkdir -p bin
	$(JAR) cfm "$@" $^

obj/%.class: src/%.java
	mkdir -p obj
	$(JAVAC) -g -cp src -s src -d obj $<



.PHONY: clean
clean:
	-rm -r bin obj

