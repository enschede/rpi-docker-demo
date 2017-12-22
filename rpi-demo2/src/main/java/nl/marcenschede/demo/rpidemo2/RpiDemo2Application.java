package nl.marcenschede.demo.rpidemo2;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;

@SpringBootApplication
@RestController
public class RpiDemo2Application {

	public static void main(String[] args) {
		SpringApplication.run(RpiDemo2Application.class, args);
	}

	@PostMapping("/upper")
	public String helloGet(@RequestBody String name) {
		return "Blabla:" + name.toLowerCase();
	}

}
