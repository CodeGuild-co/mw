import java.util.HashMap;
import java.util.Map;

import static spark.Spark.*;
import spark.template.freemarker.FreeMarkerEngine;
import spark.ModelAndView;
import static spark.Spark.get;

public class Main {

    public static void main(String[] args) {

        String port_value = System.getenv("PORT");
        if (port_value == null) {
            port_value = "3000";
        }
        port(Integer.valueOf(port_value));
        staticFileLocation("/public");

        get("/", (request, response) -> {
                Map<String, Object> attributes = new HashMap<>();
                attributes.put("message", "Hello World!");

                return new ModelAndView(attributes, "index.ftl");
            }, new FreeMarkerEngine()
        );

        get("/posts/:name/", (request, response) -> {
                Map<String, Object> attributes = new HashMap<>();
                return new ModelAndView(attributes, "posts/" + request.params("name") + ".ftl");
            }, new FreeMarkerEngine()
        );
    }
}
