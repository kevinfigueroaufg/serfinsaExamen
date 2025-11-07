package com.serfinsa.backend.controller;

import com.serfinsa.backend.entity.Usuario;
import com.serfinsa.backend.entity.userPayload.JwtResponse;
import com.serfinsa.backend.entity.userPayload.UserRequest;
import com.serfinsa.backend.repository.UsuarioRepository;
import com.serfinsa.backend.security.JwtUtils;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/serfinsa")
public class AuthController {
    @Autowired
    AuthenticationManager authenticationManager;
    @Autowired
    JwtUtils jwtUtils;
    @Autowired
    UsuarioRepository userRepository;
    @Autowired
    PasswordEncoder passwordEncoder;

    @CrossOrigin(origins = "http://localhost:4200")
    @PostMapping("/login")
    public ResponseEntity<?> authenticateUser(@Valid @RequestBody UserRequest loginRequest) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(loginRequest.getMail(), loginRequest.getContrasenia()));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = jwtUtils.generateJwtToken(authentication);
        return ResponseEntity.ok(new JwtResponse(jwt));
    }

    @PostMapping("/registrar")
    public ResponseEntity<?> registerUser(@Valid @RequestBody UserRequest req) {
        if (userRepository.findByMail(req.getMail()).isPresent()) {
            return ResponseEntity.badRequest().body("Correo en uso");
        }
        Usuario user = new Usuario();
        user.setMail(req.getMail());
        user.setContrasenia(passwordEncoder.encode(req.getContrasenia()));
        userRepository.save(user);
        return ResponseEntity.ok("Usuario registrado");
    }
}

