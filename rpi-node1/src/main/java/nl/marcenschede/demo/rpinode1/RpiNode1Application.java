package nl.marcenschede.demo.rpinode1;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@SpringBootApplication
@RestController
public class RpiNode1Application {

	public static void main(String[] args) {
		SpringApplication.run(RpiNode1Application.class, args);
	}

	@GetMapping("/hello/{name}")
    public String helloGet(@PathVariable String name) {

        RestTemplate restTemplate = new RestTemplate();

        final ResponseEntity<String> responseEntity = restTemplate.postForEntity("http://node2:8080/upper", name, String.class);
        final String body = responseEntity.getBody();

        return String.format("Hello %s%n", body);
    }

}
