package com.ronymawad.user;

public record UseRegistrationRequest(
        String username,
        String email,
        String password
) {
}
