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

    @PostMapping("/register")
    public Object registerUser(@RequestBody UserRegistrationRequest request){
        try {
            return userService.registerCustomer(request);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE);
        }
    }

    @PostMapping("/login")
    public Object loginUser(@RequestBody UserLoginRequest request){
        try {
            return userService.loginCustomer(request);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE);
        }
    }

    @GetMapping("/check-validation/{id}")
    public Object checkValidation(@PathVariable Integer id){
        return Map.of("isValid",userService.checkValidation(id));
    }

    @PostMapping("/set-validation/{id}")
    public Object setValidation(@PathVariable Integer id){
        return userService.setValidation(id);
    }

    @GetMapping("/check-username/{id}")
    public Object checkUsernameFromId(@PathVariable Integer id){
        return Map.of("username",userService.checkUsernameFromId(id));
    }

}
