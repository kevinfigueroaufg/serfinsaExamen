import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, tap } from 'rxjs';
import { jwtDecode } from 'jwt-decode';


interface TokenData {
  sub: string;
  roles: string[];
  iat: number;
  exp: number;
}

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private apiUrl = 'http://localhost:8080/serfinsa/login';

  constructor(private http: HttpClient) {}

  login(mail: string, contrasenia: string): Observable<any> {
    const body = { mail, contrasenia };
    return this.http.post<any>(this.apiUrl, body).pipe(
      tap(response => {
        if (response.token) {
          localStorage.setItem('token', response.token);
        }
      })
    );
  }

  getToken(): string | null {
    return localStorage.getItem('token');
  }

  getUserRole(): string | null {
    const token = this.getToken();
    if (!token) return null;

    const decoded = jwtDecode<TokenData>(token);
    return decoded.roles[0];
  }

  logout() {
    localStorage.removeItem('token');
  }
}
