package com.jasonreid.codeanalysis.service;

import co.paralleluniverse.fibers.Fiber;
import co.paralleluniverse.fibers.SuspendExecution;
import co.paralleluniverse.fibers.Suspendable;
import org.springframework.stereotype.Service;

@Service
public class HelloWorldService {

    @Suspendable
    public String getHelloMessage() throws SuspendExecution, InterruptedException {
        Fiber.sleep(2000);
        return "Hello world";
    }
}
