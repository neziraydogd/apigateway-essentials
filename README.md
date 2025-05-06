## 🧱 Step-by-Step Microservice Setup with Spring Boot, Consul & Docker

### 1. ✅ Spring Boot Project Initialization
A Spring Boot project was created to act as the **API Gateway** and **User Service**. The initial structure contains minimal dependencies to support modular scaling.

---

### 2. 📦 Add `spring-cloud-starter-gateway`

**Purpose:** Enables API Gateway capabilities such as routing, filtering, and load balancing via Spring Cloud Gateway (non-blocking).

**`pom.xml`:**
```xml
<dependency>
  <groupId>org.springframework.cloud</groupId>
  <artifactId>spring-cloud-starter-gateway</artifactId>
</dependency>
```

**`application.yml`:**
```yaml
spring:
  cloud:
    gateway:
      routes:
        - id: user-service
          uri: lb://user-service
          predicates:
            - Path=/api/users/**
```

---

### 3. 🔄 Add `spring-cloud-starter-circuitbreaker-reactor-resilience4j`

**Purpose:** Adds circuit breaker, retry, rate limiter, and fallback capabilities for fault-tolerant communication between services.

**`pom.xml`:**
```xml
<dependency>
  <groupId>org.springframework.cloud</groupId>
  <artifactId>spring-cloud-starter-circuitbreaker-reactor-resilience4j</artifactId>
</dependency>
```

**`application.yml`:**
```yaml
resilience4j:
  circuitbreaker:
    instances:
      userService:
        slidingWindowSize: 10
        failureRateThreshold: 50
```

**Fallback Java Example:**
```java
@GetMapping("/fallback/user-service")
public Mono<String> userServiceFallback() {
    return Mono.just("User service is temporarily unavailable");
}
```

---

### 4.  Add `spring-cloud-starter-consul-discovery`

**Purpose:** Enables service registration and discovery using HashiCorp Consul.

**`pom.xml`:**
```xml
<dependency>
  <groupId>org.springframework.cloud</groupId>
  <artifactId>spring-cloud-starter-consul-discovery</artifactId>
</dependency>
```

**`application-docker.yml`:**
```yaml
spring:
  cloud:
    consul:
      host: consul
      port: 8500
      discovery:
        prefer-ip-address: false
```

**Why Consul instead of Eureka?**
- Lightweight and Go-based (faster boot time),
- Supports health checks natively,
- Combines service registry, config store, and ACL in one package,
- Easier to run in dev mode via Docker.

---

### 5. 📊 Add `spring-boot-starter-actuator`

**Purpose:** Exposes application health and metrics endpoints required by Consul for service health monitoring.

**`pom.xml`:**
```xml
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```

**`application.yml`:**
```yaml
management:
  endpoints:
    web:
      exposure:
        include: health, info
```

---

### 6. ⚖️ Add `spring-cloud-starter-loadbalancer`

**Purpose:** Enables client-side load balancing between service instances (used with `lb://` prefix in Gateway URIs).

**`pom.xml`:**
```xml
<dependency>
  <groupId>org.springframework.cloud</groupId>
  <artifactId>spring-cloud-starter-loadbalancer</artifactId>
</dependency>
```

---

### 7. 🐳 Create `Dockerfile`

**Purpose:** Containerizes each Spring Boot microservice for consistent deployment and testing.

**`Dockerfile`:**
```Dockerfile
FROM openjdk:17
COPY target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
```

**Explanation:**
- Uses JDK 17 base image,
- Copies the built JAR,
- Runs the application with `java -jar`.

---

### 8. 🧩 Define Spring Profiles (local vs docker)

**Purpose:** Switches config based on the environment without editing files.

**`application.yml`:**
```yaml
spring:
  profiles:
    active: local
```

**`application-docker.yml`:**
```yaml
spring:
  cloud:
    consul:
      host: consul
```

**Why?** Local uses localhost-based config, Docker uses container service names (e.g., `consul`, `user-service`).

---

### 9. 🛠️ Define `docker-compose.yml`

**`docker-compose.yml`:**
```yaml
version: '3.8'
services:
  consul:
    image: hashicorp/consul:1.20.5
    ports:
      - "8500:8500"
    command: agent -dev -client=0.0.0.0

  api-gateway:
    build: ./api-gateway
    ports:
      - "8080:8080"
    depends_on:
      - consul
    environment:
      - SPRING_PROFILES_ACTIVE=docker

  user-service:
    build: ./user-service
    ports:
      - "8081:8081"
    depends_on:
      - consul
    environment:
      - SPRING_PROFILES_ACTIVE=docker
```

**Explanation:**
- Uses shared bridge network for container discovery,
- `SPRING_PROFILES_ACTIVE=docker` loads correct profile,
- `depends_on` ensures Consul starts first.

---

### 10. 🌐 Why use a shared Docker network?
Docker automatically creates an internal network in `docker-compose`. This allows:
- Service discovery by name (e.g., `user-service`),
- Consistent communication between services.

---

### 11. 🔧 Why `prefer-ip-address: false`?
Ensures Consul registers the **container name** instead of dynamic IPs, ensuring stability after container restarts.

**`application-docker.yml`:**
```yaml
spring:
  cloud:
    consul:
      discovery:
        prefer-ip-address: false
```

---

### 12. ✅ How to Test

```bash
# Build and run all containers
docker-compose up --build

# Access API Gateway
http://localhost:8080/api/users

# Check Consul UI
http://localhost:8500
```