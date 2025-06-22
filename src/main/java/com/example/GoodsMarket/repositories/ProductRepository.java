package com.example.GoodsMarket.repositories;

import com.example.GoodsMarket.models.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {
    @Query("SELECT p FROM Product p WHERE " +
            "(:city IS NULL OR p.city = :city) AND " +
            "(lower(p.title) LIKE lower(concat('%', :searchWord, '%')) OR " +
            "lower(p.description) LIKE lower(concat('%', :searchWord, '%')))")
    List<Product> searchProducts(@Param("city") String city,
                                 @Param("searchWord") String searchWord);
}
