package com.example.GoodsMarket.services;

import com.example.GoodsMarket.models.Image;
import com.example.GoodsMarket.models.User;
import com.example.GoodsMarket.models.enums.Role;
import com.example.GoodsMarket.repositories.ImageRepository;
import com.example.GoodsMarket.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final ImageService imageService;
    private final ImageRepository imageRepository;
    private final EmailSenderService emailSenderService;

    public boolean createUser(User user) {
        String email = user.getEmail();
        if (userRepository.findByEmail(email) != null) return false;

        // Генерация кода активации
        user.setActivationCode(UUID.randomUUID().toString()); // <-- ЗДЕСЬ!
        user.setActive(false);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.getRoles().add(Role.ROLE_USER);
        userRepository.save(user);

        // Отправка письма с кодом
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setTo(user.getEmail());
        mailMessage.setSubject("Активация аккаунта");
        mailMessage.setText("Перейдите по ссылке: http://localhost:8080/activate/" + user.getActivationCode());
        emailSenderService.sendEmail(mailMessage);

        return true;
    }

    public boolean activateUser(String activationCode) {
        User user = userRepository.findByActivationCode(activationCode); // <-- ЗДЕСЬ!
        if (user == null) return false;

        user.setActive(true);
        user.setActivationCode(null);
        userRepository.save(user);
        return true;
    }

    public List<User> list() {
        return userRepository.findAll();
    }

    public void banUser(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            if (user.isActive()) {
                user.setActive(false);
                log.info("Ban user with id = {}; email: {}", user.getId(), user.getEmail());
            } else {
                user.setActive(true);
                log.info("Unban user with id = {}; email: {}", user.getId(), user.getEmail());
            }
        }
        userRepository.save(user);
    }

    public void changeUserRoles(User user, Map<String, String> form) {
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());
        user.getRoles().clear();
        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userRepository.save(user);
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    public void updateUser(Principal principal, User updatedUser, MultipartFile avatarFile) throws IOException {
        User user = getUserByPrincipal(principal);
        user.setName(updatedUser.getName());
        user.setPhoneNumber(updatedUser.getPhoneNumber());

        if (avatarFile != null && !avatarFile.isEmpty()) {
            if (user.getAvatar() != null) {
                // Удаляем старую аватарку
                imageRepository.delete(user.getAvatar());
            }
            Image avatar = imageService.toImageEntity(avatarFile);
            user.setAvatar(avatar);
        }
        userRepository.save(user);
    }
}
