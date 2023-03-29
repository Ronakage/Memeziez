package com.ronymawad.user;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("api/v1/users")
public class UserController {

    private UserService userService;

    @PostMapping
    public UserModel registerUser(@RequestBody UserRegistrationRequest request){
        return userService.registerCustomer(request);
    }

    @GetMapping
    public Object loginUser(@RequestBody UserLoginRequest request){
        try {
            return userService.loginCustomer(request);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE);
        }
    }

    @GetMapping("/check-validation/{id}")
    public Object checkValidation(@PathVariable String id){
        Integer idToInt = Integer.parseInt(id);
        return Map.of("isValid",userService.checkValidation(idToInt));
    }

}
