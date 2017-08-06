package demo;

import java.util.HashMap;
import java.util.Map;

/**
 * @author jhirschbeck
 *
 * Used this class to generate very simple heap dumps for analysis in vjisualvm.
 *
 */
public class MemoryLeak {

    private Map<String, Foo> causeForLeak = new HashMap<>();

    public static void main(String[] args) {

        MemoryLeak leaker = new MemoryLeak();

        if (args.length > 0 && "leak".equals(args[0])) {
            System.out.println("run with leak");
            leaker.leak();
        } else {
            System.out.println("run without leak");
            leaker.dontLeak();
        }
        System.gc();
        try {
            System.out.println("take dump");
            Thread.sleep(Integer.MAX_VALUE);
        } catch (InterruptedException e) {
            //ignore
        }
    }

    private void dontLeak() {
        for (int i = 1; i < 10; i++) {
            Foo f = new Foo();
            f.setName("SomeFoo" + i);
            f.setWeight(122.3);
        }
    }

    private void leak() {
        for (int i = 1; i < 10; i++) {
            Foo f = new Foo();
            f.setName("SomeFoo" + i);
            f.setWeight(122.3);
            causeForLeak.put(f.getName(), f);
        }
    }


    public class Foo {
        private String name;
        private Double weight;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public Double getWeight() {
            return weight;
        }

        public void setWeight(Double weight) {
            this.weight = weight;
        }
    }

}
