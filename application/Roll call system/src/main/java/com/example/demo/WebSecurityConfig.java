package com.example.demo;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {


    private static final String ADMIN = "ADMIN";

    @Autowired
    private DataSource dataSource;

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.jdbcAuthentication().dataSource(dataSource)
           // .withUser("user").password(passwordEncoder().encode("password")).roles("USER", "ADMIN")
        ;
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.
                csrf()
                .disable()
                .authorizeRequests()
                .antMatchers("/").permitAll()
                .and()
                .logout()
                .logoutSuccessUrl("/")
                .and()
                .formLogin()
                .defaultSuccessUrl("/");


    }
}