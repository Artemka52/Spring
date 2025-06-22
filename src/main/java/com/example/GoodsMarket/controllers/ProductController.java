package com.example.GoodsMarket.controllers;

import com.example.GoodsMarket.models.Product;
import com.example.GoodsMarket.models.User;
import com.example.GoodsMarket.services.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;


    @GetMapping("/")
    public String products(
            @RequestParam(name = "searchWord", required = false) String searchWord,
            @RequestParam(name = "city", required = false) String city,
            Principal principal,
            Model model
    ) {
        model.addAttribute("products", productService.listProducts(searchWord, city));
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("selectedCity", city); // Для сохранения выбора в форме
        return "products";
    }

    @GetMapping("/product/{id}")
    public String productInfo(@PathVariable Long id, Model model, Principal principal) {
        Product product = productService.getProductById(id);
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("product", product);
        model.addAttribute("images", product.getImages());
        model.addAttribute("authorProduct", product.getUser());
        return "product-info";
    }

    @PostMapping("/product/create")
    public String createProduct(
            @RequestParam("files") MultipartFile[] files,
            Product product,
            Principal principal
    ) throws IOException {
        productService.saveProduct(principal, product, files);
        return "redirect:/my/products";
    }

    @GetMapping("/product/edit/{id}")
    public String editProductForm(@PathVariable Long id, Model model, Principal principal) {
        Product product = productService.getProductById(id);
        User user = productService.getUserByPrincipal(principal);
        if (product == null || !product.getUser().getId().equals(user.getId())) {
            return "redirect:/my/products";
        }
        model.addAttribute("product", product);
        model.addAttribute("user", user);
        return "edit-product";
    }

    @PostMapping("/product/update/{id}")
    public String updateProduct(@PathVariable Long id,
                                @RequestParam(value = "files", required = false) MultipartFile[] files,
                                Product updatedProduct,
                                Principal principal) throws IOException {
        try {
            if (files != null && files.length > 8) {
                throw new IllegalArgumentException("Максимум 8 изображений");
            }
            productService.updateProduct(principal, id, updatedProduct, files);
        } catch (AccessDeniedException e) {
            return "redirect:/my/products?error=access_denied";
        } catch (IllegalArgumentException e) {
            return "redirect:/product/edit/" + id + "?error=invalid_files";
        }
        return "redirect:/my/products";
    }

    @PostMapping("/product/delete/{id}")
    public String deleteProduct(@PathVariable Long id, Principal principal) {
        productService.deleteProduct(productService.getUserByPrincipal(principal), id);
        return "redirect:/my/products";
    }

    @GetMapping("/my/products")
    public String userProducts(Principal principal, Model model) {
        User user = productService.getUserByPrincipal(principal);
        model.addAttribute("user", user);
        model.addAttribute("products", user.getProducts());
        return "my-products";
    }
}