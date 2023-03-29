package com.ronymawad.user;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class UserService {

    private UserRepository userRepository;

    public void registerCustomer(UseRegistrationRequest request){
        UserModel user = UserModel.builder()
                .username(request.username())
                .email(request.email())
                .password(request.password())
                .build();
        userRepository.save(user);
    }
}
