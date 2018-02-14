package nl.marcenschede.demo.rpinode2;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;

@SpringBootApplication
@RestController
public class RpiNode2Application {

	public static void main(String[] args) {
		SpringApplication.run(RpiNode2Application.class, args);
	}

	@PostMapping("/upper")
	public String helloGet(@RequestBody String name) {
		return name.toLowerCase();
	}

}
