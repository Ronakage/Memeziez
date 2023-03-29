package com.ronymawad.user;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class UserService {

    private UserRepository userRepository;

    public UserModel registerCustomer(UserRegistrationRequest request){
        UserModel user = UserModel.builder()
                .username(request.username())
                .email(request.email())
                .password(request.password())
                .isValidated(false)
                .build();
        userRepository.save(user);
        return user;
    }

    public UserModel loginCustomer(UserLoginRequest request) throws Exception {
        UserModel user = userRepository.findByEmail(request.email()).orElseThrow();
        if(request.password().equals(user.getPassword())){
            return user;
        }
        else{
            throw new Exception();
        }
    }

    public Boolean checkValidation(Integer id) {
       UserModel user =  userRepository.findById(id).orElseThrow();
       return user.getIsValidated();
    }

}
