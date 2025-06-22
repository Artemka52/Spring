package com.example.GoodsMarket.repositories;

import com.example.GoodsMarket.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
    User findByActivationCode(String activationCode);
}