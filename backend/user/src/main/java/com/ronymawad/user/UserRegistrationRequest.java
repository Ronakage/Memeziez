package com.ronymawad.user;

public record UserRegistrationRequest(
        String username,
        String email,
        String password
) {
}
