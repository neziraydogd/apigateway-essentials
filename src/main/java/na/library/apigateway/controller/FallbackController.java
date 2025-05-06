package na.library.apigateway.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;

@RestController
public class FallbackController {

    @GetMapping("/user-service-fallback")
    public Mono<String> userServiceFallback() {
        return Mono.just("The user service is currently unavailable. Please try again later.");
    }
}