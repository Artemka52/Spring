package com.example.GoodsMarket.services;

import com.example.GoodsMarket.models.Image;
import com.example.GoodsMarket.models.Product;
import com.example.GoodsMarket.models.User;
import com.example.GoodsMarket.repositories.ImageRepository;
import com.example.GoodsMarket.repositories.ProductRepository;
import com.example.GoodsMarket.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.Arrays;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final ImageRepository imageRepository;

    public List<Product> listProducts(String searchWord, String city) {
        String normalizedSearch = (searchWord != null) ? searchWord.trim() : "";
        String normalizedCity = (city != null && !city.isEmpty()) ? city : null;
        return productRepository.searchProducts(
                normalizedCity,
                normalizedSearch.isEmpty() ? "" : normalizedSearch
        );
    }

    public void saveProduct(Principal principal, Product product, MultipartFile[] files) throws IOException {
        product.setUser(getUserByPrincipal(principal));

        if(files.length > 8) {
            throw new IllegalArgumentException("Максимум 8 изображений");
        }

        for(int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            if(!file.isEmpty()) {
                Image image = toImageEntity(file);
                image.setPreviewImage(i == 0);
                product.addImageToProduct(image);
            }
        }

        log.info("Saving new Product. Title: {}; Author email: {}", product.getTitle(), product.getUser().getEmail());
        Product productFromDb = productRepository.save(product);
        if(!productFromDb.getImages().isEmpty()) {
            productFromDb.setPreviewImageId(productFromDb.getImages().get(0).getId());
            productRepository.save(productFromDb);
        }
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }

    public void updateProduct(Principal principal, Long productId, Product updatedProduct,
                              MultipartFile[] files) throws IOException {
        User user = getUserByPrincipal(principal);
        Product existingProduct = getProductById(productId);
        if (existingProduct == null || !existingProduct.getUser().getId().equals(user.getId())) {
            throw new IllegalArgumentException("Доступ запрещен");
        }

        existingProduct.setTitle(updatedProduct.getTitle());
        existingProduct.setPrice(updatedProduct.getPrice());
        existingProduct.setCity(updatedProduct.getCity());
        existingProduct.setDescription(updatedProduct.getDescription());

        boolean hasNewFiles = files != null && Arrays.stream(files).anyMatch(file -> !file.isEmpty());

        if (hasNewFiles) {
            if (files.length > 8) {
                throw new IllegalArgumentException("Максимум 8 изображений");
            }

            // Удаляем старые изображения
            existingProduct.getImages().clear();

            for (int i = 0; i < files.length; i++) {
                MultipartFile file = files[i];
                if (!file.isEmpty()) {
                    Image image = toImageEntity(file);
                    image.setPreviewImage(i == 0);
                    existingProduct.addImageToProduct(image);
                }
            }

            // Сохраняем товар с изображениями, чтобы изображения получили ID
            existingProduct = productRepository.save(existingProduct); // Ключевое изменение!

            // Теперь изображения имеют ID, можно установить превью
            if (!existingProduct.getImages().isEmpty()) {
                existingProduct.setPreviewImageId(existingProduct.getImages().get(0).getId());
            }
        }

        // Всегда обновляем превью на основе первого изображения
        if (!existingProduct.getImages().isEmpty()) {
            // Проверяем, не установлено ли уже превью
            if (existingProduct.getPreviewImageId() == null) {
                existingProduct.setPreviewImageId(existingProduct.getImages().get(0).getId());
            }
        } else {
            existingProduct.setPreviewImageId(null);
        }

        // Финализируем сохранение
        productRepository.save(existingProduct);
    }

    private void processImage(MultipartFile file, Product product, int position) throws IOException {
        List<Image> images = product.getImages();

        if (file != null && !file.isEmpty()) {
            Image newImage = toImageEntity(file);

            if (position < images.size()) {
                Image oldImage = images.get(position);
                imageRepository.delete(oldImage);
            }

            if (position < images.size()) {
                images.set(position, newImage);
            } else if (images.size() < 8) {
                images.add(newImage);
            }
            newImage.setProduct(product);

            if (position == 0) {
                product.setPreviewImageId(newImage.getId());
            }
        }
    }

    public void deleteProduct(User user, Long id) {
        Product product = productRepository.findById(id)
                .orElse(null);
        if (product != null) {
            if (product.getUser().getId().equals(user.getId())) {
                productRepository.delete(product);
                log.info("Product with id = {} was deleted", id);
            } else {
                log.error("User: {} haven't this product with id = {}", user.getEmail(), id);
            }
        } else {
            log.error("Product with id = {} is not found", id);
        }    }

    public Product getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }
}

