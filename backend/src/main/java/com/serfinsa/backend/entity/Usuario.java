package com.serfinsa.backend.entity;

import jakarta.persistence.*;

import java.util.HashSet;
import java.util.Set;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="usuario")
@Getter
@Setter
@NoArgsConstructor
public class Usuario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(unique=true, nullable=false)
    private String mail;
    @Column(nullable=false)
    private String contrasenia;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name="usuario_rol",
            joinColumns = @JoinColumn(name="usuario_id"),
            inverseJoinColumns = @JoinColumn(name="rol_id"))
    private Set<Rol> roles = new HashSet<>();
    // getters/setters
}


