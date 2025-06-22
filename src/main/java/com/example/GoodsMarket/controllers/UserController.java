package com.example.GoodsMarket.controllers;

import com.example.GoodsMarket.models.User;
import com.example.GoodsMarket.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    @GetMapping("/login")
    public String login(Principal principal, Model model) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "login";
    }

    @GetMapping("/profile")
    public String profile(Principal principal,
                          Model model) {
        User user = userService.getUserByPrincipal(principal);
        model.addAttribute("user", user);
        return "profile";
    }

    @GetMapping("/registration")
    public String registration(Principal principal, Model model) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "registration";
    }


    @PostMapping("/registration")
    public String createUser(User user, Model model) {
        if (!userService.createUser(user)) {
            model.addAttribute("errorMessage", "Пользователь с email: " + user.getEmail() + " уже существует");
            return "registration";
        }
        return "redirect:/login";
    }

    @GetMapping("/activate/{activationCode}")
    public String activateAccount(
            @PathVariable String activationCode, // <-- ЗДЕСЬ получаем код из URL!
            Model model
    ) {
        boolean isActivated = userService.activateUser(activationCode);
        model.addAttribute("message",
                isActivated
                        ? "Аккаунт активирован!"
                        : "Неверный код активации"
        );
        return "redirect:/login";
    }

    @GetMapping("/user/{user}")
    public String userInfo(@PathVariable("user") User user, Model model, Principal principal) {
        model.addAttribute("user", user);
        model.addAttribute("userByPrincipal", userService.getUserByPrincipal(principal));
        model.addAttribute("products", user.getProducts());
        return "user-info";
    }

    @GetMapping("/profile/edit")
    public String editProfileForm(Principal principal, Model model) {
        User user = userService.getUserByPrincipal(principal);
        model.addAttribute("user", user);
        return "edit-profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(
            @ModelAttribute("user") User updatedUser,
            @RequestParam(value = "avatarFile", required = false) MultipartFile avatarFile,
            Principal principal) throws IOException {
        userService.updateUser(principal, updatedUser, avatarFile);
        return "redirect:/profile";
    }
}