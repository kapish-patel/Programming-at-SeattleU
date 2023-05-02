CLASSES = BitonicSequential.class  BitonicStage.class BitonicPipeline.class RandomArrayGenerator.class StageOne.class
JAVAFLAGS = -J-Xmx48m

all: $(CLASSES)

%.class : %.java
	javac $(JAVAFLAGS) $<

clean:
	@rm -f *.class
