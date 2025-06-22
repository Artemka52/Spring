package com.example.GoodsMarket.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import lombok.extern.slf4j.Slf4j;

import java.util.Arrays;

@Service
@Slf4j
public class EmailSenderService {
    private final JavaMailSender javaMailSender;

    @Autowired
    public EmailSenderService(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

    @Async
    public void sendEmail(SimpleMailMessage email) {
        try {
            javaMailSender.send(email);
            log.info("Email sent to: {}", Arrays.toString(email.getTo()));
        } catch (Exception ex) {
            log.error("Failed to send email: {}", ex.getMessage());
            throw new RuntimeException("Ошибка отправки письма");
        }
    }
}