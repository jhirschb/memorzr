package nashorn;

import javax.script.Invocable;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;

/**
 * demonstrate runtime difference for js code called in a loop
 * @author jhirschbeck
 */
public class CallJsFunction {

    public static void main(String[] args) {
        CallJsFunction self = new CallJsFunction();
        try {
            self.callDirect();
            self.callFunction();
        } catch (ScriptException | NoSuchMethodException e) {
            System.out.println(e.getMessage());
        }
    }


    private ScriptEngine getEngine() {
        ScriptEngineManager factory = new ScriptEngineManager();
        return factory.getEngineByName("nashorn");
    }

    private void callFunction() throws ScriptException, NoSuchMethodException {
        String js = "function docalc(param) {var x = 2 * 3 + param;}";

        final long start = System.currentTimeMillis();
        final ScriptEngine scriptEngine = getEngine();
        scriptEngine.eval(js);
        final Invocable invocable = (Invocable) scriptEngine;

        System.out.println("start");
        for (int i = 1; i < 10000; i++) {

            invocable.invokeFunction("docalc", i);
        }
        final long end = System.currentTimeMillis();
        System.out.println("millis passed: " + (end - start));
    }

    private void callDirect() throws ScriptException {
        String js = "var x = 2 * 3 + ";
        final long start = System.currentTimeMillis();
        final ScriptEngine engine = getEngine();
        System.out.println("start");
        for (int i = 1; i < 10000; i++) {
            engine.eval(js + i);
        }
        final long end = System.currentTimeMillis();
        System.out.println("millis passed: " + (end - start));
    }


}
