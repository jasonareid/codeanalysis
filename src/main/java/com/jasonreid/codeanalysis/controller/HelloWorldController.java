package com.jasonreid.codeanalysis.controller;

import co.paralleluniverse.fibers.Fiber;
import co.paralleluniverse.fibers.SuspendExecution;
import co.paralleluniverse.fibers.Suspendable;
import com.jasonreid.codeanalysis.service.HelloWorldService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.Map;

@RestController
public class HelloWorldController {
    @Autowired
    HelloWorldService helloWorldService;

    @RequestMapping(value = "/", method = RequestMethod.GET, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Suspendable
    public Map<String, String> hello() throws SuspendExecution, InterruptedException {
        Fiber.sleep(100);
        return Collections.singletonMap("message",
                this.helloWorldService.getHelloMessage());
    }
}
