
# Spring Cloud API Gateway & Microservices - README

This document provides an overview of key concepts, components, and sample configurations for building 
microservice architectures using Spring Cloud API Gateway and reactive programming principles.

## Table of Contents
- [Introduction](#introduction)
- [Spring Cloud](#spring-cloud)
    - [What is Spring Cloud?](#what-is-spring-cloud)
    - [Why Use Spring Cloud?](#why-use-spring-cloud)
    - [Spring Cloud Modules](#spring-cloud-modules)
- [WebFlux & Reactive Programming](#webflux--reactive-programming)
    - [Key Concepts of Reactive Programming](#key-concepts-of-reactive-programming)
    - [Spring WebFlux](#spring-webFlux)
    - [Reactive Types in WebFlux](#reactive-types-in-webFlux)
    - [Reactive Streams Components](#reactive-streams-components)
    - [Non-blocking I/O & Event Loop Model](#non-blocking-io--event-loop-model)
    - [Spring MVC vs WebFlux](#spring-mvc-vs-webflux)
- [Why Use Spring Cloud Gateway, WebFlux and Resilience4j?](#why-use-spring-cloud-gateway-webflux-and-resilience4j)
- [Spring Cloud Gateway Features](#spring-cloud-gateway-features)
- [Service Discovery](#service-discovery)
- [Actuator Support](#actuator-support)

---

## Introduction

This project explains the concepts you'll need when building a microservices architecture using 
**Spring Cloud Gateway**, **WebFlux**, and **Reactive Programming**.

---

## Spring Cloud

### What is Spring Cloud?

**Spring Cloud** is a set of tools and frameworks built on top of **Spring Boot** that provides solutions for building cloud-native, distributed systems and microservice architectures. 
It simplifies the development and management of microservices, making it easier to handle common challenges in cloud environments.

### Key Features of Spring Cloud:

1. **Service Discovery**: Automatically discovers microservices in a dynamic, cloud environment using tools like **Eureka** or **Consul**, removing the need for hard-coding service locations.

2. **Configuration Management**: Provides a centralized configuration for managing microservices across environments. Typically achieved with **Spring Cloud Config Server**.

3. **API Gateway**: **Spring Cloud Gateway** handles routing, load balancing, and filtering, centralizing the entry points to your microservices and simplifying security, monitoring, and other cross-cutting concerns.

4. **Circuit Breaker**: Implements fault tolerance mechanisms using tools like **Hystrix** or **Resilience4j**. In case a service fails, the system can degrade gracefully and continue to operate.

5. **Distributed Tracing**: Allows tracing requests across microservices with tools like **Sleuth** and **Zipkin**, providing insights into system behavior and aiding troubleshooting.

6. **Event-Driven Communication**: Supports building event-driven architectures with **Spring Cloud Stream**, allowing easy integration of messaging systems.

### Why Use Spring Cloud?
- **Cloud-Native**: It is optimized for cloud environments, easily integrating with platforms like AWS, Azure, and GCP.
- **Microservices-Ready**: Provides a suite of tools for building scalable and maintainable microservices.
- **Community Support**: Spring Cloud is backed by a large and active community, ensuring constant updates, new features, and security patches.

In short, Spring Cloud simplifies the development of distributed systems by offering solutions for common problems like service discovery, configuration management, fault tolerance, and more.

### Spring Cloud Modules

| Feature | Spring Cloud Module |
|--------|----------------------|
| Gateway Management | `spring-cloud-starter-gateway` |
| Gateway (Servlet-based) | `spring-cloud-starter-gateway-mvc` |
| Config Server | `spring-cloud-config-server` |
| Service Discovery | `spring-cloud-starter-netflix-eureka` |
| Load Balancing | `spring-cloud-loadbalancer` |
| Circuit Breaker | `resilience4j`, `spring-cloud-circuitbreaker` |
| Distributed Tracing | `spring-cloud-sleuth`, `zipkin` |
| Messaging | `spring-cloud-stream` |
| App Monitoring | `spring-boot-starter-actuator` |

---

**## WebFlux & Reactive Programming**
### Overview
WebFlux is Spring's reactive programming framework designed for building non-blocking, event-driven applications. 
It allows you to handle high concurrency with fewer resources compared to traditional servlet-based applications.

### Key Concepts of Reactive Programming

Reactive programming focuses on working with asynchronous data streams. It is built around the following core principles:
Reactive Programming is a programming paradigm where data is processed in a continuous flow. 
In reactive programming, data is typically handled asynchronously and in a non-blocking manner.

This means that data flows over time, and the system reacts to this flow. 
The concept of non-blocking refers to not waiting for one operation to complete before allowing other tasks to proceed.

- **Non-blocking**: Operations do not halt execution while waiting for results.
- **Data streams**: Everything is treated as an asynchronous sequence of events.
- **Backpressure**: Mechanisms are provided to handle scenarios where producers generate data faster than consumers can process it.
- **Functional approach**: Emphasis on composable operations and immutability.

### Spring WebFlux

Spring WebFlux provides two programming models:

1. **Annotation-based**: Similar to Spring MVC, but with reactive types.
2. **Functional endpoints**: Using router functions and handlers.

### Reactive Types in WebFlux

WebFlux is built on **Project Reactor**, which implements the Reactive Streams specification. The framework provides two main reactive types:

- **Mono<T>**: Represents 0 or 1 element.
- **Flux<T>**: Represents 0 to N elements.

These types help handle asynchronous data and enable efficient management of concurrent tasks in a non-blocking manner.

### Reactive Streams Components
- **Publisher**: Initiates the data flow.
- **Subscriber**: Listens to and processes data.
- **Subscription**: Manages flow control.
- **Processor**: Acts as both Publisher and Subscriber.

### Non-blocking I/O & Event Loop Model

- **Non-blocking I/O**: Threads do not wait for data.
- **Event Loop**: A single thread continuously checks for events (powered by Netty).

### Spring MVC vs WebFlux

| Feature | Spring MVC | WebFlux |
|--------|------------|---------|
| Architecture | Blocking | Non-blocking |
| Performance | One request per thread | One thread for many requests |
| Server | Servlet (Tomcat, Jetty) | Netty, Undertow |

**WebFlux Example:**
```java
@GetMapping("/reactive")
public Mono<String> hello() {
    return Mono.just("Hello Reactive World");
}
```
## Why Use Spring Cloud, Gateway WebFlux and Resilience4j?

### 1. Spring Cloud Gateway
Spring Cloud Gateway is the core tool for building API Gateways within the Spring ecosystem. It provides routing and filtering mechanisms, offering the following benefits:

- **Routing**: Flexibly route requests to different backend services based on predefined rules (e.g., paths, headers).
- **Filters**: Supports various filters to modify requests and responses, including adding headers, logging, authentication, and more.
- **Spring Ecosystem Integration**: Seamlessly integrates with Spring Boot, Spring Cloud, and other Spring projects.

### 2. WebFlux
WebFlux is the reactive programming model in Spring for building non-blocking, asynchronous applications. It enhances the API Gateway by:

- **Non-blocking I/O**: Allows asynchronous handling of HTTP requests and responses, improving scalability and enabling the Gateway to handle more requests with fewer threads.
- **Reactive Streams**: Handles streams of data asynchronously, making it ideal for parallelizing requests to multiple microservices.
- **Resource Efficiency**: Uses an event-driven, non-blocking approach to optimize memory and CPU usage, especially under high loads.

### 3. Resilience4j
Resilience4j is a library that provides fault tolerance for distributed systems, crucial for robust API Gateways. Key features include:

- **Circuit Breaker**: Prevents the Gateway from making requests to failing services, using fallback methods to ensure availability.
- **Retry**: Automatically retries requests in case of transient errors to enhance fault tolerance.
- **Rate Limiting and Bulkhead**: Offers rate limiting to avoid overloads and bulkheading to isolate failures and minimize their impact.

### Why These Libraries Are Used Together:
- **Performance**: Combining WebFlux's non-blocking behavior with Spring Cloud Gateway's routing capabilities enables efficient handling of large volumes of requests without blocking threads.
- **Fault Tolerance**: Resilience4j's circuit breaker, retry, and rate limiting mechanisms ensure that the Gateway can handle failures gracefully, maintaining system stability even when some services are down.
- **Scalability**: The combination of WebFlux and Resilience4j allows for efficient scaling of the system by optimizing resource usage and handling failures without affecting overall system performance.
- **Integration and Simplicity**: These libraries work seamlessly within the Spring ecosystem, making them easy to integrate into Spring Boot applications and providing out-of-the-box solutions for common API Gateway concerns.

##  Spring Cloud Gateway Features

🌐 Spring Cloud Gateway acts as an API gateway in modern microservice architectures. Key features and use cases are listed below:

### 1. 🔀 Routing
Routes requests to proper microservice URIs based on path.
- **id: user-service** Defines a route ID, used for identifying and managing the route
- **uri: lb://USER-SERVICE** Destination URI for forwarding requests—typically a microservice address.
- **predicates:  Path=/api/users/** Predicate rule to match incoming requests based on the path.
```yaml
spring:
  cloud:
    gateway:
      routes:
        - id: user-service
          uri: lb://USER-SERVICE
          predicates:
            - Path=/api/users/**
```

### 2. 🧹 Filters
Includes `Pre` and `Post` filters that can manipulate both requests and responses.

- **Pre-filters**: Auth, header modification, logging
- **Post-filters**: Add headers to responses, modify body, etc.

```yaml
filters:
  - AddRequestHeader=X-Request-Foo, Bar
  - AddResponseHeader=X-Response-Foo, Baz
```

### 3. 💥 Circuit Breaker & Fallback
Fallback mechanisms when target microservices are unavailable. Typically uses `Resilience4j` or `Hystrix`.
- **filters: - name:** Applies a CircuitBreaker to prevent cascading failures.

- **args: name, fallbackUri:** fallbackUri is used when the service is down or exceeds the failure threshold.
- 
- **Retry:** Retry filter configuration: automatically retries the request up to 3 times on specified status codes and methods.
- **backoff:** Uses exponential backoff starting from 1 second to 5 seconds.
- **StripPrefix:** Removes the first segment of the request path (e.g., /products/123 becomes /123) before forwarding it to the backend service.
```yaml
filters:
  - name: CircuitBreaker
    args:
      name: myCircuitBreaker
      fallbackUri: forward:/fallback
  - name: Retry
    args:
      retries: 3
      statuses: BAD_GATEWAY, GATEWAY_TIMEOUT
      methods: GET
      backoff:
       firstBackoff: 1s
       maxBackoff: 5s
       factor: 2
  - StripPrefix=1
```

### 4. 📉 Rate Limiting
Set request limits per IP or user.

```yaml
filters:
  - name: RequestRateLimiter
    args:
      redis-rate-limiter.replenishRate: 10
      redis-rate-limiter.burstCapacity: 20
```

> ⚠️ Redis is required for rate limiting.

### 5. 🧠 Path Rewriting
Request paths can be modified before routing.

```yaml
filters:
  - RewritePath=/api/v1/(?<segment>.*), /${segment}
```

### 6. 🔁 Load Balancing
Distributes requests among multiple backend instances using the `lb://` prefix.

```yaml
uri: lb://USER-SERVICE
```
### 7. 🔁 Other
- **registerHealthIndicator:** Registers a health check endpoint for the circuit breaker (e.g., /actuator/health).
- **slidingWindowSize:** Tracks the last 10 calls to determine failure rates.
- **slidingWindowSize:** Requires at least 5 calls before it starts evaluating failure rates.
- **failureRateThreshold:** If more than 50% of the calls in the window fail, the circuit opens.
- **waitDurationInOpenState** The amount of time the circuit stays open before transitioning to half-open state.
- **permittedNumberOfCallsInHalfOpenState** Allows 3 test requests while in half-open state to determine whether to close the circuit again.
- **maxAttempts** Maximum number of retry attempts per request.
- **waitDuration** Waits 2 seconds between retries.
- **retryExceptions** Only retries for specified exception types.
```yaml
filters:
  resilience4j:
  circuitbreaker:
    instances:
      productServiceCircuitBreaker:
        registerHealthIndicator: true
        slidingWindowSize: 10
        minimumNumberOfCalls: 5
        failureRateThreshold: 50
        waitDurationInOpenState: 10s
        permittedNumberOfCallsInHalfOpenState: 3
  retry:
    instances:
      productServiceCircuitBreaker:
        maxAttempts: 3
        waitDuration: 2s
        retryExceptions:
          - java.io.IOException
          - java.util.concurrent.TimeoutException
```
## Service Discovery

### 🔍 Eureka 🧭
A Netflix OSS project offering central service registry, though no longer actively maintained.

### 🚀 Modern Alternatives

| System                        | Description                                       |
|-------------------------------|---------------------------------------------------|
| **Consul**                    | Key-value store + service registry (by HashiCorp) | (https://developer.hashicorp.com/consul/install)
| **Zookeeper**                 | Apache-based config and discovery tool            |
| **Kubernetes**                | Built-in service discovery                        |
| **Spring Cloud LoadBalancer** | Client-side load balancing                        |

## Actuator Support

💡 Spring Boot Actuator provides built-in endpoints for health checks, metrics, and configuration.

**Sample endpoints:**
```
/actuator/health  
/actuator/gateway/routes
```

Add dependency:
```xml
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```


##  Consul Docker Setup
This repository contains instructions for running HashiCorp Consul using Docker.
### Quick Start
Run Consul in development mode using the following command:
```bash
docker run -d --name=consul --network=app-net -p 8500:8500 -p 8600:8600/udp hashicorp/consul:1.20.5 agent -dev -client=0.0.0.0
```
### Command Breakdown
- **docker run**: Launches a new Docker container
- **-d**: Runs the container in detached mode (background process)
- **--name=consul**: Assigns the name "consul" to the container for easy identification
- **--network=app-net**: Connects the container to the "app-net" Docker network, enabling DNS-based communication between services
- **-p 8500:8500**: Maps port 8500 on the host machine to port 8500 in the container (Consul web UI)
- **-p 8600:8600/udp**: Maps UDP port 8600 for DNS resolution (required for DNS-based service discovery)
- **hashicorp/consul:1.20.5**: Specifies the Docker image and version to use
- **agent**: Runs Consul in agent mode, which is the base operational mode for both server and client functions
- **-dev**: Starts Consul in development mode with a single-node cluster (not recommended for production use as it doesn't persist data)
- **-client=0.0.0.0**: Makes Consul accessible from all IP ranges outside the container (otherwise it would only be accessible from within the container)

### Accessing Consul
- Web UI: http://localhost:8500
- DNS Interface: Port 8600 (UDP)
### Notes
- This setup is for development purposes only
- For production environments, consider using a proper cluster configuration with data persistence
- The app-net network must be created beforehand using `docker network create app-net`