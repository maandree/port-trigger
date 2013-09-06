JAVA=/usr/bin/java
JAVAC=javac
JAR=jar



.PHONY: all
all: bin/porttrigger


bin/porttrigger: bin/porttrigger.jar
	echo "#!$(JAVA) -jar" > "$@"
	cat "$<" >> "$@"

bin/porttrigger.java: META-INF/MANIFEST.MF obj/porttrigger.class
	mkdir -p bin
	$(JAR) cfm "$@" $^

obj/%.class: src/%.class
	mkdir -p obj
	$(JAVAC) -g -cp src -s src -b obj $<



.PHONY: clean
clean:
	-rm -r bin obj

