import { Component } from '@angular/core';
import { AuthService } from '../../services/auth.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  imports: [FormsModule] 
})
export class LoginComponent {
  mail = '';
  contrasenia = '';
  mensaje = '';

  constructor(private authService: AuthService) {}

  login() {
    this.authService.login(this.mail, this.contrasenia).subscribe({
      next: (response) => {
        if (response.token) {
          const rol = this.authService.getUserRole();
          this.mensaje = `Bienvenido, tu rol es: ${rol}`;
        } else {
          this.mensaje = 'Usuario o contraseña incorrectos';
        }
      },
      error: () => {
        this.mensaje = 'Error al conectar con el servidor';
      }
    });
  }
}
