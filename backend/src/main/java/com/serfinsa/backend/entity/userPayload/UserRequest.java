package com.serfinsa.backend.entity.userPayload;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserRequest {

    @NotNull
    String mail;
    @NotNull
    String contrasenia;
}
