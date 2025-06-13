package com.programmingvishal.productservice.repository;

import com.programmingvishal.productservice.model.Product;
import org.springframework.data.mongodb.repository.MongoRepository;



public interface ProductRepository extends MongoRepository<Product, String> {

}

